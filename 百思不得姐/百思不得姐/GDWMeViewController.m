//
//  GDWMeViewController.m
//  百思不得姐
//
//  Created by apple on 15/9/28.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "GDWMeViewController.h"
#import "GDWSettingController.h"
#import "GDWMeView.h"
#import "GDWMeCell.h"


@interface GDWMeViewController ()<UITableViewDataSource,UITableViewDelegate>

/** meView */
@property (nonatomic, strong) GDWMeView *meView;


@end

@implementation GDWMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.设置导航条
    [self  setUpNavgationBar];
}


#pragma mark - 设置导航条
- (void)setUpNavgationBar{
    //1.设置导航条左侧密码.
    UIButton *button=[UIButton  buttonWithType:UIButtonTypeCustom];
    [button  setImage:[UIImage  imageNamed:@"mine-moon-icon"] forState:UIControlStateNormal];
    [button  setImage:[UIImage  imageNamed: @"mine-moon-icon-click"]   forState:UIControlStateHighlighted];
    [button  sizeToFit];//使按钮自适应大小.
    UIBarButtonItem *item=[[UIBarButtonItem  alloc]  initWithCustomView:button];
    
    UIButton *button1=[UIButton  buttonWithType:UIButtonTypeCustom];
    [button1  setImage:[UIImage  imageNamed:@"mine-setting-icon"] forState:UIControlStateNormal];
    [button1  setImage:[UIImage  imageNamed: @"mine-setting-icon-click"]   forState:UIControlStateHighlighted];
    [button1  sizeToFit];//使按钮自适应大小.
    //button1添加监听事件.
    [button1  addTarget:self action:@selector(settingBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item1=[[UIBarButtonItem  alloc]  initWithCustomView:button1];
    
    self.navigationItem.rightBarButtonItems=@[item1,item];
    
    //2.设置导航条标题控件.
    self.navigationItem.title=@"我的";
    
}
- (void)settingBtnClick:(UIButton *)btn{
    UIViewController *vc=[[GDWSettingController   alloc]   init];
    [self.navigationController  pushViewController:vc animated:YES];
}

/*
 footerView相关类和方法的加载顺序.
  -[GDWMeViewController loadView]
  -[GDWMeView setUp]
  -[GDWMeViewController viewDidLoad]
  -[GDWMeViewController viewWillAppear:]
  -[GDWMeViewController numberOfSectionsInTableView:]
  -[GDWMeViewController numberOfSectionsInTableView:]
  -[GDWMeViewController numberOfSectionsInTableView:]
  -[GDWMeViewController numberOfSectionsInTableView:]
  -[GDWMeViewController numberOfSectionsInTableView:]
  -[GDWMeViewController viewDidAppear:]
  -[GDWMeFooterView addButtonWith:]
 */

#pragma mark - 自定义控制器view.
- (void)loadView{

    //1.当控制器的view加载时,自定义view.
    GDWMeView *meView=[[GDWMeView   alloc]   initWithFrame:[UIScreen  mainScreen].bounds style:UITableViewStyleGrouped];
    self.meView=meView;
    self.view=meView;
    
    //2.设置tableView数据源
    //meView.dataSource=self;
    
}



#pragma mark - tabelView的dataSource方法.
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
// 
//    return 2;
//}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 1;
//}
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    static NSString * ID=@"cell";
//    GDWMeCell *cell=[tableView  dequeueReusableCellWithIdentifier:ID];
//    if (!cell) {
//        cell=[[GDWMeCell  alloc]  init];
//    }
//    //给cell设置内容
//    if (indexPath.section==0) {
//        
//        cell.textLabel.text=@"登录/注册";
//        cell.imageView.image=[UIImage imageNamed:@"publish-audio"];
//    }else if(indexPath.section==1){
//        cell.textLabel.text=@"离线下载";
//        cell.imageView.image=nil;//考虑到循环利用,没有图片的cell的图片也要置空.
//    }
//    
//    return cell;
//}

@end
