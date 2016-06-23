//
//  GDWNewViewController.m
//  百思不得姐
//
//  Created by apple on 15/9/28.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "GDWNewViewController.h"
#import "GDWRecommendTagsController.h"

@interface GDWNewViewController ()

@end

@implementation GDWNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置背景颜色.
    self.view.backgroundColor=GDWGrayColor(206);
    //1.设置导航条
    [self  setUpNavgationBar];
}
- (void)setUpNavgationBar{
    //1.设置导航条左侧密码.
    UIButton *button=[UIButton  buttonWithType:UIButtonTypeCustom];
    [button  setImage:[UIImage  imageNamed:@"MainTagSubIcon"] forState:UIControlStateNormal];
    [button  setImage:[UIImage  imageNamed: @"MainTagSubIconClick"]   forState:UIControlStateHighlighted];
    [button  addTarget:self action:@selector(recommend) forControlEvents:UIControlEventTouchUpInside];
    //使按钮自适应大小.
    [button  sizeToFit];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem  alloc]  initWithCustomView:button];
    
    //2.设置导航条标题控件.
    self.navigationItem.titleView=[[UIImageView  alloc]  initWithImage:[UIImage  imageNamed:@"MainTitle"]];
    
}

- (void)recommend{

//    UIViewController *vc=[[GDWRecommendTagsController  alloc]  init];
//    [self.navigationController  pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
