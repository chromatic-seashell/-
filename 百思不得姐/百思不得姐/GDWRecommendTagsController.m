//
//  GDWRecommendTagsController.m
//  百思不得姐
//
//  Created by apple on 15/10/8.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "GDWRecommendTagsController.h"
#import "GDWRecommendTagModel.h"
#import "GDWRecommendTagCell.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "SVProgressHUD.h"

@interface GDWRecommendTagsController ()

@property (nonatomic,strong) NSArray *tags;
/** 任务 */
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;
/** 请求管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;
/* 搜索框 */
@property (nonatomic,weak)   UIView  *seacherView;

@end

@implementation GDWRecommendTagsController

//cell的标示符.
static NSString * const ID=@"recommendTag";
/*
 1.修改tableView的分隔符的方法.
    -自定义cell,给cell添加一个条状的UIview控件.(额外添加很多控件)
    -自定义cell,重写cell的-(void)setFrame:(CGRect)frame方法.(不添加控件,很方便)
 //一些方法的调用顺序.
 -[GDWRecommendTagsController tableView:cellForRowAtIndexPath:]
 -[GDWRecommendTagCell setFrame:]
 -[GDWRecommendTagCell setFrame:]
 -[GDWRecommendTagCell layoutSubviews]
 -[GDWRecommendTagCell setFrame:]
 
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.设置tableView
    [self  setUpTableView];
    
    
    //2.从服务器上加载数据.
    [self  loadData];        //利用AFNetworking框架加载数据.
    //[self systemLoadData]; //利用系统的NSURLSession加载数据.
    //3.顶部收索框
    [self   addSeacherView];
    
    
 
}
#pragma mark -  AFHTTPSessionManager *manager懒加载
- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        self.manager = [AFHTTPSessionManager   manager];
    }
    return _manager;
}

//设置tableView
- (void)setUpTableView{
    //注册cell
    [self.tableView  registerNib:[UINib  nibWithNibName:NSStringFromClass([GDWRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:ID];
    //设置cell高度.
    self.tableView.rowHeight=70;
    //设置tableView的内边距
    self.tableView.contentInset=UIEdgeInsetsMake(70, 0, 0, 0);
    //调整tableView导航条的位置
    self.tableView.scrollIndicatorInsets=UIEdgeInsetsMake(70, 0, 0, 9);
    //设置分割线.
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    //设置背景为灰色
    self.tableView.backgroundColor=GDWGrayColor(222);
}
//3.顶部收索框
- (void)addSeacherView{
    UIView  *seacherView=[[UIView   alloc]   init];
    self.seacherView=seacherView;
    seacherView.backgroundColor=GDWGrayColor(222);
    //seacherView.frame=CGRectMake(10, 64, self.view.width-20, 70);
    //[[UIApplication  sharedApplication].keyWindow   addSubview:seacherView];
    seacherView.frame=CGRectMake(10, 0, self.view.width-20, 114);
    [self.navigationController.navigationBar  insertSubview:seacherView atIndex:0];
    
    //创建搜索条
    UISearchBar *seacherBar=[[UISearchBar   alloc]  init];
    seacherBar.frame=CGRectMake(0, 44, self.view.width-20, 70);
    seacherBar.backgroundColor=GDWGrayColor(222);
    [seacherView   addSubview:seacherBar];
}
#pragma mark - 利用系统的NSURLSession加载数据.
- (void)systemLoadData{
    //向服务器请求数据.
    NSString *str=@"http://api.budejie.com/api/api_open.php?a=tag_recommend&action=sub&c=topic";
    NSURLSessionDataTask *task = [[NSURLSession  sharedSession]    dataTaskWithURL:[NSURL  URLWithString:str] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            
            NSArray *array= [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            //GDWLog(@"%@",array);
            NSMutableArray *mutableArray=[NSMutableArray  array];
            for (NSDictionary *dic in array) {
                GDWRecommendTagModel *tag=[GDWRecommendTagModel  recommendTagWithDictionary:dic];
                [mutableArray  addObject:tag];
            }
            self.tags=[mutableArray   mutableCopy];
            //刷新表格.
            [self.tableView  reloadData];
        }else{
            GDWLog(@"数据加载失败");
        }
    }];
    //开始任务.
    [task   resume];
    
}

#pragma mark - 利用AFNetworking框架加载数据,MJExtension字典转模型.
- (void)loadData{

    //加载数据时弹框.
    [SVProgressHUD  show];
    //[SVProgressHUD  showWithMaskType:SVProgressHUDMaskTypeBlack];

    //防止block对控制器造成循环引用.
    __weak  typeof(self)   weakSelf = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        NSMutableDictionary *dic=[NSMutableDictionary  dictionary];
        dic[@"a"]=@"tag_recommend";
        dic[@"action"]=@"sub";
        dic[@"c"]=@"topic";

        [weakSelf.manager  GET:GDWURL  parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            
            weakSelf.tags=[GDWRecommendTagModel   objectArrayWithKeyValuesArray:responseObject];
            //刷新表格.
            [weakSelf.tableView   reloadData];
            
            //取消弹框
            [SVProgressHUD  dismiss];
            
        } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
            
            //如果由于取消任务导致的错误,直接返回.
            if (error.code==NSURLErrorCancelled) return ;
            
            NSString *string=[NSString   stringWithFormat:@"数据加载失败--%ld",error.code];
            [SVProgressHUD   showErrorWithStatus:string];
            
        }];

    });
}

#pragma mark - 控制器的生命周期方法.
- (void)viewWillDisappear:(BOOL)animated{
    [super  viewWillDisappear:animated];
    //取消弹框.
    [SVProgressHUD   dismiss];
    //取消任务.
    [self.manager    invalidateSessionCancelingTasks:YES];//manager不能创建任务了.
    //[self.manager.tasks   makeObjectsPerformSelector:@selector(cancel)];//manager可以继续创建任务.
    //[self.dataTask    cancel];
    
    //移除搜索框.
    [self.seacherView  removeFromSuperview];
    
}
//控制器销毁时调用.
-(void)dealloc{
    //GDWLogFuc;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.tags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //GDWLogFuc;
    GDWRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.recommendTagModel=self.tags[indexPath.row];
    return cell;
}






@end
