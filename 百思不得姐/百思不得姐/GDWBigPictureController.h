//
//  GDWBigPictureController.h
//  百思不得姐
//
//  Created by apple on 15/10/21.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GDWTopicModel;
@interface GDWBigPictureController : UIViewController

/** 帖子模型 */
@property (nonatomic, strong) GDWTopicModel *topic;

/** 图片 */
@property (nonatomic, strong) UIImage *image;
@end
