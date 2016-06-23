//
//  GDWTabBar.m
//  百思不得姐
//
//  Created by apple on 15/9/28.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "GDWTabBar.h"
#import "GDWPublishViewController.h"

@interface GDWTabBar ()

/* 注释 */
@property (nonatomic,weak) UIButton *button;

@end

@implementation GDWTabBar

#pragma mark - 初始化时,添加子控件.
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //添加button按钮
        [self  setUpSubView];
    }
    return self;
}
- (void)setUpSubView{

    UIButton  *publishBtn = [[UIButton  alloc]  init];
    [publishBtn  setImage:[UIImage  imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
    [publishBtn  setImage:[UIImage  imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
     self.button=publishBtn;
    [publishBtn  addTarget:self  action:@selector(publishBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self   addSubview:publishBtn];
    
}
#pragma mark - 监听publishBtn点击
- (void)publishBtnClick:(UIButton *)btn
{
    //1.创建发布控制器
    GDWPublishViewController *publishVc=[[GDWPublishViewController   alloc]  init];
    //2.modal控制器
    [[UIApplication  sharedApplication].keyWindow.rootViewController  presentViewController:publishVc animated:YES completion:nil];
    
}

#pragma mark - 布局子控件
-(void)layoutSubviews{

    [super  layoutSubviews];
    CGFloat width=self.frame.size.width;
    CGFloat height=self.frame.size.height;
    CGFloat buttonW=width/5;
    //1.按钮位置.
    self.button.frame=CGRectMake(0, 0, buttonW, height);
    self.button.center=CGPointMake(width/2, height/2);
    int index=0;
    //UITabBarButton是系统私有类,不能直接使用这个类.
    /*
     self.subviews:contains--
      _UITabBarBackgroundView
      UIButton
      UITabBarButton
      UITabBarButton
      UITabBarButton
      UITabBarButton
      UIImageView
     */
    //2.UIBarButtonItem控件的位置.
    for (UIView  *view in self.subviews) {
        //将类名转化为字符串比较.
        NSString *string=NSStringFromClass([view  class]);
        if (![string  isEqualToString:@"UITabBarButton"]) continue;
        if (index==2) {
            index++;
            
        }
        view.frame=CGRectMake(index*buttonW, 0, buttonW, height);
        index++;
    }

}
-(void)dealloc{
    NSLog(@"tabBar销毁");
}

@end
