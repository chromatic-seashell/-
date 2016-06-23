//
//  UIImageView+GDWExtension.h
//  百思不得姐
//
//  Created by apple on 15/11/2.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (GDWExtension)

/** 设置圆形图片 */
- (void)setCircleImageWithURL:(NSURL *)url;

/** 设置带圆角的矩形图片 */
- (void)setRoundCornerImageWithURL:(NSURL *)url   cornerRadius:(CGFloat)radius;


@end
