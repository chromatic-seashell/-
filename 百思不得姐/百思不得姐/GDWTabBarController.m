//
//  GDWTabBarController.m
//  百思不得姐
//
//  Created by apple on 15/9/28.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "GDWTabBarController.h"
#import "GDWEssenceController.h"
#import "GDWNewViewController.h"
#import "GDWFriendTrendsViewController.h"
#import "GDWMeViewController.h"
#import "GDWTabBar.h"

#import "GDWNavgationController.h"


@interface GDWTabBarController ()

@property (nonatomic,strong) UITabBar *tab;
@end

@implementation GDWTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //tabBar是控制器只读属性,利用KVC给tabBar赋值.
    // Provided for -[UIActionSheet showFromTabBar:]. Attempting to modify the contents of the tab bar directly will throw an exception.
    [self  setValue:[[GDWTabBar  alloc]  init] forKey:@"tabBar"];
    //1.添加子控制器
    [self  setUpChildViewController];
    
    //选中关注控制器.
    self.selectedIndex=0;
    
    
}
- (void)setUpChildViewController{
    //统一设置tabBarItem的文字属性
    UITabBarItem *item =[UITabBarItem  appearance];
    NSMutableDictionary *dic=[NSMutableDictionary  dictionary];
    dic[NSForegroundColorAttributeName]=[UIColor   darkGrayColor];
    [item  setTitleTextAttributes:dic forState:UIControlStateSelected];
    
    //精华
    UIViewController *essenceVc=[[GDWEssenceController  alloc]  init];
    [self  setUpOneViewController:essenceVc title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    //新帖
    UIViewController *newVc=[[GDWNewViewController  alloc]  init];
    [self  setUpOneViewController:newVc title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    //关注
    //从Storyboard 中加载控制器.
    UIViewController *friendTrendsVc=[UIStoryboard  storyboardWithName:NSStringFromClass([GDWFriendTrendsViewController  class]) bundle:nil].instantiateInitialViewController;
    [self   setUpOneViewController:friendTrendsVc title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    //我
    UIViewController *meVc=[[GDWMeViewController  alloc]  init];
    [self   setUpOneViewController:meVc title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
}
- (void)setUpOneViewController:(UIViewController *)vc  title:(NSString *)title image:(NSString *)image  selectedImage:(NSString *)selectedImage{
    //1.创建导航控制器
    GDWNavgationController *navgationVc=[[GDWNavgationController  alloc]  initWithRootViewController:vc];


    vc.tabBarItem.title=title;
    vc.tabBarItem.image=[[UIImage  imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage=[[UIImage  imageNamed:selectedImage]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //2.导航控制器加到tabBar控制器中.
    [self  addChildViewController:navgationVc];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
