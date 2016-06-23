//
//  GDWStatusBarViewController.m
//  百思不得姐
//
//  Created by apple on 15/10/27.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "GDWStatusBarViewController.h"

@interface GDWStatusBarViewController ()

@end

@implementation GDWStatusBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark - 自定义窗口成员变量
static  UIWindow *window_;

#pragma mark - 显示自定义窗口
+ (void)show{
    window_=[[UIWindow   alloc]   init];
    window_.frame=[UIApplication  sharedApplication].statusBarFrame;
    window_.backgroundColor=[UIColor  clearColor];
    window_.hidden=NO;
    window_.windowLevel=UIWindowLevelAlert;
    window_.rootViewController=[[GDWStatusBarViewController  alloc]  init];

}
#pragma mark - 控制状态栏的隐藏.
-(BOOL)prefersStatusBarHidden{
    return NO;
}

#pragma mark - 当点击自定义窗口,使指定控件内的scrollView,回到顶端.
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
  
    UIWindow *keyWindow=[UIApplication  sharedApplication].keyWindow;
    [self   seachDesiredScrollViewInView:keyWindow];

}
- (void)seachDesiredScrollViewInView:(UIView *)view
{
    //利用递归遍历,view的所有子控件.
    for (UIView *subView in view.subviews) {
        [self  seachDesiredScrollViewInView:subView];
    }
    if ([view  isKindOfClass:[UIScrollView  class]]) {
        //GDWLog(@"%@",view);
        UIScrollView *scrollView=(UIScrollView *)view;
        //计算控件位置和所在窗口是否交叉
        CGRect scrollRect=[scrollView  convertRect:scrollView.bounds toView:nil];
        CGRect windowRect=scrollView.window.bounds;
        if (!CGRectIntersectsRect(scrollRect, windowRect)) return;
        //使scrollView回到顶端
        CGPoint offset=scrollView.contentOffset;
        offset.y=-scrollView.contentInset.top;
        [scrollView   setContentOffset:offset animated:YES];
    }
    
}

@end
