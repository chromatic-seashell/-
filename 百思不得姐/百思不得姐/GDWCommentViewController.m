//
//  GDWCommentViewController.m
//  百思不得姐
//
//  Created by apple on 15/10/25.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "GDWCommentViewController.h"
#import "GDWRefreshHeader.h"
#import "GDWRefreshFooter.h"
#import "GDWTopicModel.h"
#import "GDWTopicCell.h"

#import "GDWCommentModel.h"
#import "GDWCommentCell.h"

#import "GDWTableViewHeaderFooterView.h"

@interface GDWCommentViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomDistance;
/** 网络请求管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;
/** 最新评论 */
@property (nonatomic, strong) NSMutableArray<GDWCommentModel *> *latestCommends;
/** 最热评论 */
@property (nonatomic, strong) NSArray<GDWCommentModel *> *hotCommends;

/** 最热评论数组 */
@property (nonatomic, strong) NSArray *top_cmt;

@end

@implementation GDWCommentViewController

/** 循环利用标示符 */
static  NSString * const commentCellID=@"commentCell";
static  NSString * const headerFooterViewID=@"headerFooterView";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //通知监听.
    [[NSNotificationCenter   defaultCenter]  addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    //设置tableView
    [self  setUpTableView];
    //设置头部view
    [self  setUpHeaderView];
    //设置刷新
    [self  setUpRefresh];
    
    
}
/** manager懒加载 */
- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        self.manager = [AFHTTPSessionManager   manager];
    }
    return _manager;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self=[super  initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      //添加控件.

        
    }
    return self;
}
#pragma mark - 监听键盘的通知
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    //GDWLog(@"%@",note)
      //设置约束
    CGRect keyboardFrame=[note.userInfo[UIKeyboardFrameEndUserInfoKey]  CGRectValue];
    self.bottomDistance.constant=[UIScreen  mainScreen].bounds.size.height-keyboardFrame.origin.y;
    [UIView  animateWithDuration:.25 animations:^{
        [self.view   layoutIfNeeded];
        
    }];
}
#pragma mark 移除监听者
-(void)dealloc{
    //GDWLogFuc
    //在控制器销毁的时候,移除控制器这个监听者.
    [[NSNotificationCenter    defaultCenter]   removeObserver:self];
    
    //回复帖子模型中,最热评论部分数据.
    self.topic.top_cmt=self.top_cmt;
    self.topic.cellHeight=0;
}

#pragma mark - 设置TableView
- (void)setUpTableView{
    
    self.tableView.backgroundColor=GDWCommonGrayColor;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    //禁止自动调整TableView
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.tableView.contentInset=UIEdgeInsetsMake(GDWNavBarBottom, 0, 0, 0);
    
    //注册cell
    [self.tableView  registerNib:[UINib  nibWithNibName:NSStringFromClass([GDWCommentCell  class]) bundle:nil] forCellReuseIdentifier:commentCellID];
    [self.tableView   registerClass:[GDWTableViewHeaderFooterView  class] forHeaderFooterViewReuseIdentifier:headerFooterViewID];
    
    //cell的高度自动计算
    self.tableView.rowHeight=UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight=100;
}
#pragma mark 设置headerView
- (void)setUpHeaderView
{
    if (self.topic.top_cmt.count) {
        self.top_cmt=self.topic.top_cmt;
        self.topic.top_cmt=nil;//最热评论置nil,为了去除最热评论部分.
        self.topic.cellHeight=0;//高度置0,是为了让cell重新计算高度.
    }
    UIView *headerView=[[UIView  alloc]  init];
    GDWTopicCell *cell=[[NSBundle    mainBundle]   loadNibNamed:NSStringFromClass([GDWTopicCell  class]) owner:nil options:nil].firstObject;
    cell.frame=CGRectMake(0, GDWMargin, [UIScreen  mainScreen].bounds.size.width, self.topic.cellHeight);
    cell.topic=self.topic;
    
    headerView.height=cell.height+2*GDWMargin;
    [headerView  addSubview:cell];
    self.tableView.tableHeaderView=headerView;

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



#pragma mark 下拉刷新.
- (void)downRefresh{
    //取消其他任务.
    [self.manager.tasks   makeObjectsPerformSelector:@selector(cancel)];
    //加载新数据.
    __weak  typeof(self)   weakSelf = self;
    
    NSMutableDictionary *dic=[NSMutableDictionary  dictionary];
    dic[@"a"]=@"dataList";
    dic[@"c"]=@"comment";
    dic[@"data_id"] =self.topic.ID;
    dic[@"hot"]=@1;
    [self.manager  GET:GDWURL  parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        //GDWWriteToPlist(responseObject, @"comment");
        if ([responseObject  isKindOfClass:[NSArray  class]]) {
            [self.tableView.header  endRefreshing];
            //self.tableView.footer.hidden=YES;
            return ;
        }
        //字典转模型.
        weakSelf.latestCommends=[GDWCommentModel  objectArrayWithKeyValuesArray:responseObject[@"data"]];
        weakSelf.hotCommends=[GDWCommentModel   objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        //刷新表格.
        [weakSelf.tableView  reloadData];
        //停止下拉刷新
        [weakSelf.tableView.header   endRefreshing];
        //判断数据是否加载完,加载完隐藏footer.
        NSInteger  total=[responseObject[@"total"]  integerValue];
        if (self.latestCommends.count==total) {
            self.tableView.footer.hidden=YES;
        }
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        //停止下拉刷新
        [weakSelf.tableView.header   endRefreshing];
        
    }];
}

#pragma mark 上拉刷新.
- (void)upRefresh{
    //取消其他任务.
    [self.manager.tasks  makeObjectsPerformSelector:@selector(cancel)];
    //[self.manager.tasks  performSelector:nil];
    //加载新数据.
    __weak  typeof(self)   weakSelf = self;
    
    NSMutableDictionary *dic=[NSMutableDictionary  dictionary];
    dic[@"a"]=@"dataList";
    dic[@"c"]=@"comment";
    dic[@"data_id"] =self.topic.ID;
    dic[@"lastcid"]=self.latestCommends.lastObject.ID;
    
    [[AFHTTPSessionManager  manager]  GET:GDWURL  parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        //GDWWriteToPlist(responseObject, @"moreComment");
        if ([responseObject isKindOfClass:[NSArray  class]]) {//返回数据是空数组,隐藏footer,直接返回.
            self.tableView.footer.hidden=YES;
            return ;
        }
        //2.字典转模型.
        //NSLog(@"%@",responseObject);
        NSArray  *tempArray=[GDWCommentModel  objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        //把新数据拼接在原有数据的后面.
        [weakSelf.latestCommends   addObjectsFromArray:tempArray];
        
        //3.刷新表格.
        [weakSelf.tableView  reloadData];
        //4.停止下拉刷新
        [weakSelf.tableView.footer   endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        //停止下拉刷新
        [weakSelf.tableView.footer   endRefreshing];
        
    }];
    
    
}


#pragma mark -  UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.hotCommends.count) return 2;
    if (self.latestCommends.count) return 1;
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0&&self.hotCommends.count) {
        return self.hotCommends.count;
    }
    return self.latestCommends.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GDWCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:commentCellID ];
    if (indexPath.section==0&&self.hotCommends.count) {
        GDWCommentModel *hotComment=self.hotCommends[indexPath.row];
        cell.commendModel=hotComment;
    }else {
        cell.commendModel=self.latestCommends[indexPath.row];
    }
    
    
    return cell;
}
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    if (self.hotCommends.count) {
//       return  @"最热评论";
//    }else {
//       return @"最新评论";
//    }
//    
//}
#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSString *str=nil;
    if (self.hotCommends.count&&section==0) {
        str =  @"最热评论";
    }else {
        str = @"最新评论";
    }
    //使用系统的headerView,不能调整它内部控件的位置.
//    UILabel *headerLable=[[UILabel  alloc]  init];
//    headerLable.height=30;
//    headerLable.textColor=[UIColor  purpleColor];
//    headerLable.text=str;
//    headerLable.backgroundColor=GDWGrayColor(206);
    
    //自定义头部view,可以重写它初始化方法,调整内部内部控件的位置.
    GDWTableViewHeaderFooterView *headerView=[tableView  dequeueReusableHeaderFooterViewWithIdentifier:headerFooterViewID];
    headerView.text=str;
    return headerView;
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //开始拖拽tableView的时候,退出键盘
    [self.view   endEditing:YES];
    
}

@end
