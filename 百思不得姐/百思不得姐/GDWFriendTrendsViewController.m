//
//  GDWFriendTrendsViewController.m
//  百思不得姐
//
//  Created by apple on 15/9/28.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "GDWFriendTrendsViewController.h"
#import "GDWQuickLoggingButton.h"

@interface GDWFriendTrendsViewController ()

@end

@implementation GDWFriendTrendsViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    //设置背景颜色.
    self.view.backgroundColor=GDWGrayColor(206);
    //设置导航条
    [self  setUpNavgationBar];
    
    
}
- (void)setUpNavgationBar{
    //1.设置导航条左侧密码.
    UIButton *button=[UIButton  buttonWithType:UIButtonTypeCustom];
    [button  setImage:[UIImage  imageNamed:@"friendsRecommentIcon"] forState:UIControlStateNormal];
    [button  setImage:[UIImage  imageNamed: @"friendsRecommentIcon-click"]   forState:UIControlStateHighlighted];
    
    [button  addTarget:self action:@selector(leftItemClick:) forControlEvents:UIControlEventTouchUpInside];
    //使按钮自适应大小.
    [button  sizeToFit];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem  alloc]  initWithCustomView:button];
    
    //2.设置导航条标题控件.
    self.navigationItem.title=@"我的关注";
    
}
- (void)leftItemClick:(UIButton *)btn
{
    [self performSegueWithIdentifier:@"recommendController" sender:nil];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //NSLog(@"%@",segue.destinationViewController);
}

//该控制器modal出来的控制器,回到该控制器.
- (IBAction)dismissViewController:(UIStoryboardSegue *)sender{


}


@end
