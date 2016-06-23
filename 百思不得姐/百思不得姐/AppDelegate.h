//
//  AppDelegate.h
//  百思不得姐
//
//  Created by apple on 15/9/28.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 关键点:下面两个是同一个对象.
 GDWLog(@"%p--%p",self,[UIApplication  sharedApplication].delegate);
 */
@class AppDelegate;
@protocol GDWAppDelegate <NSObject>
/** 监听tabBar重复点击的代理方法 */
@optional
- (void)appDelegate:(AppDelegate *)appDelegate   tabBarRepeatClick:(UITabBarController *)tabBarVc;
@end

/** 监听tabBar重复点击的block */
typedef void(^GDWAppDelegateBlock)();


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/** 代理 */
@property (nonatomic, strong) id <GDWAppDelegate> delegate;

/** block属性 */
@property (nonatomic, copy) GDWAppDelegateBlock block;

@end

