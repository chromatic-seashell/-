//
//  UIImage+GDWExtention.h
//  百思不得姐
//
//  Created by apple on 15/11/6.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (GDWExtention)

+ (instancetype)imageCircleClippingWithImage:(UIImage *)image border:(CGFloat)border scale:(CGFloat)scale color:(UIColor *)color  baseDistance:(CGFloat)baseDistance;

@end
