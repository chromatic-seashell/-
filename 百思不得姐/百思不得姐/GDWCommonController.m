//
//  GDWCommonController.m
//  百思不得姐
//
//  Created by apple on 15/10/22.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "GDWCommonController.h"

#import "GDWTopicModel.h"
#import "GDWTopicCell.h"

#import "GDWRefreshHeader.h"
#import "GDWRefreshFooter.h"


#import "GDWNewViewController.h"
/** 评论控制器 */
#import "GDWCommentViewController.h"

#import "AppDelegate.h"


//类型字符串
#define topicStringType(type)    [NSString  stringWithFormat:@"%ld",(type)]

@interface GDWCommonController ()<GDWAppDelegate>

/** 装有帖子模型的数组 */
@property (nonatomic, strong) NSMutableArray *topics;
/** 请求相应的maxtime属性 */
@property (nonatomic, copy) NSString *maxtime;



@end

@implementation GDWCommonController

/** 返回帖子类型 ,子类继承可以重写*/
-(GDWTopicType)type{
    return 0;
}

static  NSString * const  topicID=@"topic";


- (void)viewDidLoad {
    [super viewDidLoad];

    
    //1.设置tableView
    [self  setUp];
    
    
    //2.设置刷新.
    [self   setUpRefresh];
    //3.加载数据
    //[self  loadData];
    //1.监听通知.
    [[NSNotificationCenter  defaultCenter]   addObserver:self selector:@selector(tabBarRepeatClick:) name:GDWTabBarRepeatClickNotification object:nil];
    //2.通过代理监听重复点击
//    AppDelegate *appDelegate=(AppDelegate *)[UIApplication  sharedApplication].delegate;
//    appDelegate.delegate=self;
    
    //3.通过block
//    AppDelegate *appDelegate=(AppDelegate *)[UIApplication  sharedApplication].delegate;    
//    appDelegate.block=^(){
//        CGRect  viewRect=[self.view   convertRect:self.view.bounds toView:nil];
//        CGRect  windowRect=self.view.window.bounds;
//        if (CGRectIntersectsRect(viewRect, windowRect)) {
//            [self.tableView.header  beginRefreshing];
//        }
//    };
    //监听titleView的重复点击的通知
    [[NSNotificationCenter   defaultCenter]   addObserver:self selector:@selector(titleViewButtonRepeatClick:) name:GDWTitleViewButtonRepeatClickNotification object:nil];
    
}
-(void)appDelegate:(AppDelegate *)appDelegate tabBarRepeatClick:(UITabBarController *)tabBarVc
{
    GDWLogFuc
    CGRect  viewRect=[self.view   convertRect:self.view.bounds toView:nil];
    CGRect  windowRect=self.view.window.bounds;
    if (CGRectIntersectsRect(viewRect, windowRect)) {
        //使scrollView回到顶端
        //        CGPoint offset=self.tableView.contentOffset;
        //        offset.y=-self.tableView.contentInset.top;
        //        [self.tableView   setContentOffset:offset animated:YES];
        //刷新数据
        [self.tableView.header  beginRefreshing];
       
    }
}

#pragma mark -  监听通知
- (void)tabBarRepeatClick:(NSNotification *)note
{
    //GDWLogFuc
    //接受通知的控制器的view在窗口上时,进行刷新.
    CGRect  viewRect=[self.view   convertRect:self.view.bounds toView:nil];
    CGRect  windowRect=self.view.window.bounds;
    if (CGRectIntersectsRect(viewRect, windowRect)) {
        //使scrollView回到顶端
//        CGPoint offset=self.tableView.contentOffset;
//        offset.y=-self.tableView.contentInset.top;
//        [self.tableView   setContentOffset:offset animated:YES];
        //刷新数据
        [self.tableView.header  beginRefreshing];
    }
}
#pragma mark  监听titleView的重复点击的通知
- (void)titleViewButtonRepeatClick:(NSNotification *)note{
    //GDWLogFuc
    [self   tabBarRepeatClick:note];
}

- (void)dealloc{
    [[NSNotificationCenter  defaultCenter]   removeObserver:self];
}

#pragma mark - 设置tableView
- (void)setUp{
    self.tableView.contentInset = UIEdgeInsetsMake(GDWNavBarBottom+GDWTitleViewH, 0, GDWTabarH, 0);
    self.tableView.scrollIndicatorInsets=self.tableView.contentInset;
    //设置cell的高度
    self.tableView.rowHeight=500;
    self.tableView.backgroundColor=GDWGrayColor(206);
    //设置分割线
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    //注册cell
    [self.tableView  registerNib:[UINib   nibWithNibName:NSStringFromClass([GDWTopicCell   class]) bundle:nil] forCellReuseIdentifier:topicID];
}
- (void)loadData{
    //加载新数据.
    __weak  typeof(self)   weakSelf = self;
    
    NSMutableDictionary *dic=[NSMutableDictionary  dictionary];
    dic[@"a"]=@"list";
    dic[@"c"]=@"data";
    dic[@"type"] = topicStringType(self.type);//默认服务器会返回@"1",对应的数据.
    
    [[AFHTTPSessionManager  manager]  GET:GDWURL  parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        //记录self.maxtime
        weakSelf.maxtime=responseObject[@"info"][@"maxtime"];
        //字典转模型.
        //GDWLogFuc
        weakSelf.topics=[GDWTopicModel  objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //刷新表格.
        [weakSelf.tableView  reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
        
    }];
    
}

#pragma mark - 设置刷新
- (void)setUpRefresh{
    //1.下拉刷新.
    GDWRefreshHeader *headerView=[GDWRefreshHeader   headerWithRefreshingTarget:self refreshingAction:@selector(downRefresh)];
    //刷新的时候自动调整透明度
    headerView.automaticallyChangeAlpha=YES;
    
    //使用self.tableView.tableHeaderView=headerView时,tableView会向下移动54的高度.
    self.tableView.header=headerView;
    //开始刷新.(控制器view加载的时候就刷新加载数据.)
    [headerView   beginRefreshing];
    
    //2.上拉刷新.
    GDWRefreshFooter *footerView=[GDWRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(upRefresh)];
    self.tableView.footer=footerView;
    
    
}
#pragma mark 根据控制器的父控制器类型加载数据.
- (NSString *)dataTypeOnParentViewController
{
    if ([self.parentViewController  isKindOfClass:[GDWNewViewController  class]]) {
        
        return @"newlist";
    }
    return @"list";
    
}



#pragma mark 下拉刷新.
- (void)downRefresh{
    
    //加载新数据.
    __weak  typeof(self)   weakSelf = self;
    
    NSMutableDictionary *dic=[NSMutableDictionary  dictionary];
    dic[@"a"]=[self  dataTypeOnParentViewController];
    dic[@"c"]=@"data";
    dic[@"type"] =topicStringType(self.type);//默认服务器会返回@"1",对应的数据.
    
    [[AFHTTPSessionManager  manager]  GET:GDWURL  parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
       

        //记录self.maxtime
        weakSelf.maxtime=responseObject[@"info"][@"maxtime"];
        //字典转模型.
        //GDWLogFuc
        weakSelf.topics=[GDWTopicModel  objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //刷新表格.
        [weakSelf.tableView  reloadData];
        //停止下拉刷新
        [weakSelf.tableView.header   endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        //停止下拉刷新
        [weakSelf.tableView.header   endRefreshing];
        
    }];
}

#pragma mark 上拉刷新.
- (void)upRefresh{
    //加载新数据.
    __weak  typeof(self)   weakSelf = self;
    
    NSMutableDictionary *dic=[NSMutableDictionary  dictionary];
    dic[@"a"]=[self   dataTypeOnParentViewController];
    dic[@"c"]=@"data";
    dic[@"type"] = topicStringType(self.type);//默认服务器会返回@"1",对应的数据.
    dic[@"maxtime"] = self.maxtime;
    
    [[AFHTTPSessionManager  manager]  GET:GDWURL  parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        //1.记录self.maxtime
        weakSelf.maxtime=responseObject[@"info"][@"maxtime"];
        //2.字典转模型.
        //GDWLogFuc
        NSArray  *tempArray=[GDWTopicModel  objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //把新数据拼接在原有数据的后面.
        [weakSelf.topics   addObjectsFromArray:tempArray];
        
        //3.刷新表格.
        [weakSelf.tableView  reloadData];
        //4.停止下拉刷新
        [weakSelf.tableView.footer   endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        //停止下拉刷新
        [weakSelf.tableView.footer   endRefreshing];
        
    }];
    
    
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.topics.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //GDWLogFuc
    GDWTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:topicID ];
    
    GDWTopicModel *topic=self.topics[indexPath.row];
    cell.topic=topic;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //GDWLogFuc
    GDWTopicModel *topic=self.topics[indexPath.row];
    //GDWLog(@"%f---%@",topic.cellHeight,topic.name);
    return topic.cellHeight;
    
    
}

#pragma mark - Table view delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GDWTopicModel *topic=self.topics[indexPath.row];
    
    //控制器的view如果通过xib创建,init方法会调用,initWithNibName:bundle:
    GDWCommentViewController *commentVc=[[GDWCommentViewController  alloc]   init];
    commentVc.topic=topic;
    //跳转到评论控制器.
    [self.navigationController   pushViewController:commentVc animated:YES];

}

/*
 作用:当带有视屏的cell从屏幕中消失是停止视屏播放
 */
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    //当cell从屏幕中消失是停止视屏播放
    GDWTopicCell *endDisplayingcell = [tableView  cellForRowAtIndexPath:indexPath];
    [endDisplayingcell.player  stop];
    [endDisplayingcell.player.view  removeFromSuperview];
    endDisplayingcell.player = nil;
    
}
@end
