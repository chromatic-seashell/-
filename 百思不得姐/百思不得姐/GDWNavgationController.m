//
//  GDWNavgationController.m
//  百思不得姐
//
//  Created by apple on 15/9/29.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "GDWNavgationController.h"

@interface GDWNavgationController ()<UIGestureRecognizerDelegate>

@end

@implementation GDWNavgationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.delegate=self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIGestureRecognizerDelegate
//当自定义导航条左边的返回按钮时,就系统不能自动侧边滑动返回;\
  进行下面的设置:1.self.interactivePopGestureRecognizer.delegate=self;\
               2.实现下面的方法.
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    return self.childViewControllers.count>1;
}

#pragma mark - 导航控制器的push方法.
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{

    if (self.childViewControllers.count!=0) {
//        NSLog(@"%ld",self.childViewControllers.count);
//        NSLog(@"%@",[viewController  class]);
        //1.隐藏底部导航条
        viewController.hidesBottomBarWhenPushed=YES;
        //2.设置左侧返回按钮.
        //2.1创建按钮.
        UIButton *button=[UIButton  buttonWithType:UIButtonTypeCustom];
        //2.2设置按钮图片
        [button  setImage:[UIImage  imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button  setImage:[UIImage  imageNamed: @"navigationButtonReturnClick"]   forState:UIControlStateHighlighted];
        //2.3设置文字
        [button  setTitle:@"返回" forState:UIControlStateNormal];
        [button  setTitle:@"返回" forState:UIControlStateHighlighted];
        [button  setTitleColor:[UIColor  blackColor] forState:UIControlStateNormal];
        [button   setTitleColor:[UIColor  redColor] forState:UIControlStateHighlighted];
        //使按钮自适应大小.
        [button  sizeToFit];
        //2.4改变按钮的内边距,调整按钮的位置.
        button.contentEdgeInsets=UIEdgeInsetsMake(0, -20, 0, 0);
        [button   addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem=[[UIBarButtonItem  alloc]  initWithCustomView:button];
        
    }
    
    [super  pushViewController:viewController animated:YES];
}

- (void)back:(UIButton *)btn{

    [self  popViewControllerAnimated:YES];

}


@end
