//
//  AppDelegate.m
//  百思不得姐
//
//  Created by apple on 15/9/28.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "GDWTabBarController.h"
#import "GDWStatusBarViewController.h"

@interface AppDelegate ()<UITabBarControllerDelegate>

/** tabBarVc子控制器的标识号 */
@property (nonatomic, assign) NSInteger seletedIndex;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //1.创建窗口
    self.window = [[UIWindow  alloc] init];
    
    //2.窗口设置跟控制器
    GDWTabBarController *tabBarViewController=[[GDWTabBarController   alloc]  init];
    tabBarViewController.delegate=self;
    self.seletedIndex =  tabBarViewController.selectedIndex;
    self.window.rootViewController=tabBarViewController;
    
    //3.让窗口成为主窗口,并显示
    [self.window  makeKeyAndVisible];
    
    //自定义一个窗口,覆盖状态栏.
    [GDWStatusBarViewController  show];
    //GDWLog(@"%p--%p",self,[UIApplication  sharedApplication].delegate);
    
    return YES;
}
#pragma mark - UITabBarControllerDelegate
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    NSInteger index=tabBarController.selectedIndex;
    if (self.seletedIndex!=index) {
        self.seletedIndex=index;
        return;
    }
    //重复点击.
    //1.发送重复点击的通知.
    [[NSNotificationCenter   defaultCenter]   postNotificationName:GDWTabBarRepeatClickNotification object:nil];
    //2.通过代理监听重复点击.
//    if (self.delegate &&[self.delegate  respondsToSelector:@selector(appDelegate:tabBarRepeatClick:)]) {
//        [self.delegate  appDelegate:self tabBarRepeatClick:tabBarController];
//    }
    //3.通过block
    //self.block();
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
