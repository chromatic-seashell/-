//
//  GDWMeFooterView.m
//  百思不得姐
//
//  Created by apple on 15/10/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "GDWMeFooterView.h"
#import "GDWMeSquareModel.h"
#import "UIButton+WebCache.h"
#import "GDWMeSquareButton.h"
#import "GDWMeWebViewController.h"

@implementation GDWMeFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self  loadData];
    }
    return self;
}
#pragma mark - 利用AFNetworking框架加载数据,MJExtension字典转模型.
- (void)loadData{
    
    //防止block对控制器造成循环引用.
    __weak  typeof(self)   weakSelf = self;
    
    NSMutableDictionary *dic=[NSMutableDictionary  dictionary];
    dic[@"a"]=@"square";
    dic[@"c"]=@"topic";
    
    [[AFHTTPSessionManager  manager]  GET:GDWURL  parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
    
        //NSLog(@"%@",responseObject);
        //NSLog(@"%@",[NSThread  currentThread]);
        NSArray *squares=[GDWMeSquareModel   objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
        //刷新表格.
        [weakSelf  addButtonWith:squares];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
        //如果由于取消任务导致的错误,直接返回.
        if (error.code==NSURLErrorCancelled) return ;
    }];
}

#pragma mark - 根据squares模型数据添加UIButton按钮.
- (void)addButtonWith:(NSArray *)squares
{
    //GDWLogFuc;
    //添加控件
    NSInteger toltalNumber=squares.count;
    NSInteger colNumber=4;
    CGFloat  width=self.width/colNumber;
    CGFloat  height=width;
    
    for (NSInteger i=0; i<toltalNumber; i++) {
        //1.创建按钮.
        GDWMeSquareButton *button=[[GDWMeSquareButton  alloc]  init];
        CGFloat x=(i%colNumber)*width;
        CGFloat y=(i/colNumber)*height;
        button.frame=CGRectMake(x, y, width, height);
        //button.backgroundColor=[UIColor  greenColor];
        [self  addSubview:button];
        //2.给按钮设置数据.
        GDWMeSquareModel *square=squares[i];
        [button  setTitle:square.name forState:UIControlStateNormal];
        [button  sd_setImageWithURL:[NSURL   URLWithString:square.icon] forState:UIControlStateNormal];
        button.square=square;
        //3.监听按钮点击.
        [button   addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    self.height=self.subviews.lastObject.bottom;
    // 设置footer
    /*
     1.修改了footerView的高度,需要重新设置一下tableView的footerView.
     2.也可以在创建了footerView后,设置footerView的高度.
     */
    UITableView *tableView = (UITableView *)self.superview;
    tableView.tableFooterView = self;

}

- (void)layoutSubviews{
    [super   layoutSubviews];
//    self.height=self.subviews.lastObject.bottom;
//    UITableView *tableView = (UITableView *)self.superview;
//    tableView.tableFooterView = self;
}

/*
 1.点击按钮可能没有反应原因:
 1>父控件不能点击.
 2>被点击控件,不在父控件范围内.(对于本项目,可能是尾部视图的高度没有设置)
 
 
 2.当按钮点击时,跳转到webView上展示.
 */
- (void)butClick:(GDWMeSquareButton *)btn{
    GDWMeSquareModel *square=btn.square;
    
    NSString *url=square.url;
    if ([url   hasPrefix:@"mod://"]) {
        if ([url hasSuffix:@"BDJ_To_Check"]) {
            GDWLog(@"跳转到Check控制器");
        } else if ([url hasSuffix:@"App_To_SearchUser"]) {
            GDWLog(@"跳转到SearchUser控制器");
        }
        
    }else if([url  hasPrefix:@"http://"]){
        //跳转到http网页上.
        //1.拿到当前页面的导航控制器.
        UITabBarController *barVc=(UITabBarController *)self.window.rootViewController;
        UINavigationController *nav=barVc.selectedViewController;
        //2.加载网页界面.
        GDWMeWebViewController *webVc=[[GDWMeWebViewController alloc]  init];
        webVc.url=url;
        [nav  pushViewController:webVc animated:YES];
    
    }else{
       
    
    }
    
}


@end
