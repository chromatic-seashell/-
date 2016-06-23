//
//  GDWAddTagViewController.h
//  百思不得姐
//
//  Created by apple on 15/10/30.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GDWAddTagViewController : UIViewController

/** 上一个界面传递的标签数据 */
@property (nonatomic, strong) NSArray *tags;
/** 传递标签数据给上一个控制器 */
@property (nonatomic, copy) void (^getTagsBlock) (NSArray *tags);

@end
