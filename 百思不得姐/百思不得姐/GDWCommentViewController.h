//
//  GDWCommentViewController.h
//  百思不得姐
//
//  Created by apple on 15/10/25.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GDWTopicModel;
@interface GDWCommentViewController : UIViewController

/** 帖子模型 */
@property (nonatomic, strong) GDWTopicModel *topic;

@end
