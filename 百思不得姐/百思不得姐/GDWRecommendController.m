//
//  GDWRecommendController.m
//  百思不得姐
//
//  Created by apple on 15/10/23.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "GDWRecommendController.h"
#import "GDWRecommendCategoryCell.h"

#import "GDWCategoryModel.h"
#import "GDWDetailModel.h"

#import "GDWCategoryDetailDataSouceDelegate.h"

#import "GDWRefreshFooter.h"
#import "GDWRefreshHeader.h"

#import "GDWHTTPSessionManger.h"

@interface GDWRecommendController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;

@property (weak, nonatomic) IBOutlet UITableView *categoryDetailTableView;
/** 分类模型数组 */
@property (nonatomic, strong) NSArray<GDWCategoryModel *> *categories;
/** 分类详情的数据源和代理 */
@property (nonatomic, strong) GDWCategoryDetailDataSouceDelegate *categoryDetailDD;

/** 请求管理者 */
@property (nonatomic, weak) GDWHTTPSessionManger *manager;

@end

@implementation GDWRecommendController

static  NSString * const  recommendCategoryCellID=@"categoryCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置view的背景颜色
    self.view.backgroundColor=GDWCommonGrayColor;
    
    //1.设置tableView
    [self    setUpTableView];
    
    //2.设置刷新.
    [self   setUpRefresh];
    
    //3.左边分类数据.
    [self    loadCategoryData];

}

#pragma mark - 懒加载
/** manager懒加载 */
- (GDWHTTPSessionManger *)manager{
    if (!_manager) {
        self.manager = [GDWHTTPSessionManger   manager];
    }
    return _manager;
}


#pragma mark - 设置tableView
- (void)setUpTableView{
    UIEdgeInsets  insets = UIEdgeInsetsMake(GDWNavBarBottom, 0, 0, 0);
    //1.设置categoryTableView
    self.categoryTableView.contentInset=insets;
    self.categoryTableView.scrollIndicatorInsets=insets;
    //设置代理.
    self.categoryTableView.delegate=self;
    self.categoryTableView.dataSource=self;
    //行高
    //self.categoryTableView.rowHeight=50;
    //分割线
    self.categoryTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    
    //2.设置categoryDetailTableView
    self.categoryDetailTableView.contentInset=insets;
    self.categoryDetailTableView.scrollIndicatorInsets=insets;
    //创建数据源和代理
    GDWCategoryDetailDataSouceDelegate *categoryDetailDD=[[GDWCategoryDetailDataSouceDelegate  alloc]  init];
    self.categoryDetailDD=categoryDetailDD;
    self.categoryDetailTableView.dataSource=categoryDetailDD;
    self.categoryDetailTableView.delegate=categoryDetailDD;
    //设置cell高度
    self.categoryDetailTableView.rowHeight=70;
}

#pragma mark - 左侧数据
- (void)loadCategoryData{
    
    //加载新数据.
    __weak  typeof(self)   weakSelf = self;
    
    NSMutableDictionary *dic=[NSMutableDictionary  dictionary];
    dic[@"a"]=@"category";
    dic[@"c"]=@"subscribe";
    
    
    [self.manager  GET:GDWURL  parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        GDWWriteToPlist(responseObject, @"category");
        //1.字典转模型.
        weakSelf.categories=[GDWCategoryModel  objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //2.刷新表格.
        [weakSelf.categoryTableView  reloadData];
        
        //3.1选中第0行.
        [weakSelf.categoryTableView   selectRowAtIndexPath:[NSIndexPath  indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        //3.2右侧刷新
        [self.categoryDetailTableView.header  beginRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark - 右侧数据

#pragma mark 设置刷新
- (void)setUpRefresh{
    //1.下拉刷新.
    GDWRefreshHeader *headerView=[GDWRefreshHeader   headerWithRefreshingTarget:self refreshingAction:@selector(downRefresh)];
    //刷新的时候自动调整透明度
    headerView.automaticallyChangeAlpha=YES;
    
    //使用self.tableView.tableHeaderView=headerView时,tableView会向下移动54的高度.
    self.categoryDetailTableView.header=headerView;
    
    
    //2.上拉刷新.
    GDWRefreshFooter *footerView=[GDWRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(upRefresh)];
    self.categoryDetailTableView.footer=footerView;
}

#pragma mark 下拉刷新.
- (void)downRefresh{
    
    //取消之前的请求
    [self.manager.tasks  makeObjectsPerformSelector:@selector(cancel)];
    //取出分类模型
    GDWCategoryModel *categoryModel=self.categories[self.categoryTableView.indexPathForSelectedRow.row];
    // NSLog(@"%ld",self.categoryTableView.indexPathForSelectedRow.row);
    //加载新数据.
    __weak  typeof(self)   weakSelf = self;
    
    NSMutableDictionary *dic=[NSMutableDictionary  dictionary];
    dic[@"a"]=@"list";
    dic[@"c"]=@"subscribe";
    dic[@"category_id"]=categoryModel.id;
    
    [self.manager  GET:GDWURL  parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        //GDWWriteToPlist(responseObject, @"categoryDetail");
        //字典转模型.
        categoryModel.details=[GDWDetailModel  objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //给categoryDetailTableView传递数据.
        weakSelf.categoryDetailDD.details=categoryModel.details;
        //当下拉刷新成功时,记录加载数据页数
        categoryModel.page=1;
        //刷新表格.
        [weakSelf.categoryDetailTableView  reloadData];
        //停止下拉刷新
        [weakSelf.categoryDetailTableView.header   endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        //停止下拉刷新
        [weakSelf.categoryDetailTableView.header   endRefreshing];
        
    }];
}

#pragma mark 上拉刷新.
- (void)upRefresh{
    //取消之前的请求
    [self.manager.tasks  makeObjectsPerformSelector:@selector(cancel)];
    //取出分类模型
    GDWCategoryModel *categoryModel=self.categories[self.categoryTableView.indexPathForSelectedRow.row];
    
    //加载新数据.
    __weak  typeof(self)   weakSelf = self;
    
    NSMutableDictionary *dic=[NSMutableDictionary  dictionary];
    dic[@"a"]=@"list";
    dic[@"c"]=@"subscribe";
    dic[@"category_id"]=categoryModel.id;
    dic[@"page"]=@(categoryModel.page+1);
    
    
    
    [self.manager  GET:GDWURL  parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        
        //2.字典转模型.
        //GDWLogFuc
        NSArray  *tempArray=[GDWDetailModel  objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //把新数据拼接在原有数据的后面.
        [categoryModel.details   addObjectsFromArray:tempArray];
        //给categoryDetailTableView传递数据.
        weakSelf.categoryDetailDD.details=categoryModel.details;
        //当下拉刷新成功时,记录加载数据页数
        categoryModel.page++;
        //3.刷新表格.
        [weakSelf.categoryDetailTableView  reloadData];
        //4.停止下拉刷新
        [weakSelf.categoryDetailTableView.footer   endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        //停止下拉刷新
       [weakSelf.categoryDetailTableView.footer   endRefreshing];
    }];
    
}


#pragma mark 加载分类对应的详情数据
/*
- (void)loadCategoryDetailData{

    //取出分类模型
    GDWCategoryModel *categoryModel=self.categories[self.categoryTableView.indexPathForSelectedRow.row];
    
    //加载新数据.
    __weak  typeof(self)   weakSelf = self;
    
    NSMutableDictionary *dic=[NSMutableDictionary  dictionary];
    dic[@"a"]=@"list";
    dic[@"c"]=@"subscribe";
    dic[@"category_id"]=categoryModel.id;
    
    
    [self.manager  GET:GDWURL  parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        //GDWWriteToPlist(responseObject, @"categoryDetail");
        //字典转模型.
        categoryModel.details=[GDWDetailModel  objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //给categoryDetailTableView传递数据.
        weakSelf.categoryDetailDD.details=categoryModel.details;
        //刷新表格.
        [weakSelf.categoryDetailTableView  reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
    }];
}
*/
#pragma mark -  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.categories.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GDWRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendCategoryCellID ];
    //取出cell对应的模型数据
    GDWCategoryModel *categoryModel=self.categories[indexPath.row];
    //给cell的categoryModel属性赋值.
    cell.categoryModel=categoryModel;
    
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     
    //1.取出模型
    GDWCategoryModel *categoryModel=self.categories[indexPath.row];
    //2.根据categoryModel.details.count,判断是否从服务器加载数据.
    if (categoryModel.details.count) {//右侧详情有值,直接刷新.
        self.categoryDetailDD.details=categoryModel.details;
        [self.categoryDetailTableView  reloadData];
    }else{
        //加载分类标签对应的详情数据.
        [self.categoryDetailTableView.header   beginRefreshing];
    }
    
}


@end
