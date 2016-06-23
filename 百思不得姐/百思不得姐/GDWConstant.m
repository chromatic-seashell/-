//
//  GDWConstant.m
//  百思不得姐
//
//  Created by apple on 15/10/11.
//  Copyright © 2015年 apple. All rights reserved.
//
#import "GDWConstant.h"

/** 向服务器请求url */
NSString  * const GDWURL = @"http://api.budejie.com/api/api_open.php";

/** 控件间距 */
CGFloat  const  GDWMargin=10;

/** table的group样式下最前面那个cell默认的Y值 */
CGFloat const GDWGorupFirstCellY = 35;


/** 导航条和tabar的参数 */
CGFloat const  GDWNavBarBottom=64;
CGFloat const  GDWTitleViewH=40;
CGFloat const  GDWTabarH=49;

/** 重复点击tabBar按钮的通知名 */
 NSString * const GDWTabBarRepeatClickNotification=@"tabBarRepeatClickNotification";
/** 重复点击titleView按钮的通知名 */
 NSString * const GDWTitleViewButtonRepeatClickNotification=@"titleViewButtonRepeatClickNotification";

/** 小间距 */
 CGFloat const GDWSmallMargin=5;
/** 标签的高度 */
 CGFloat const GDWTagH=25;

/** UITextField占位文字颜色的key（属性名） */
NSString * const GDWTextFieldPlaceholderColor = @"placeholderLabel.textColor";
