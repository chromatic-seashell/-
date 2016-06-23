//
//  UIImage+GDWExtention.m
//  百思不得姐
//
//  Created by apple on 15/11/6.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UIImage+GDWExtention.h"

@implementation UIImage (GDWExtention)

+ (instancetype)imageCircleClippingWithImage:(UIImage *)image border:(CGFloat)border scale:(CGFloat)scale color:(UIColor *)color  baseDistance:(CGFloat)baseDistance{
    //1.定义圆形边框.
    CGFloat bordeW=border;
    
    //2.加载图片.
    CGFloat imageH=image.size.height;
    CGFloat imageW=image.size.width;
    CGFloat contextW=0;
    CGFloat contextH=0;
    //判断高,宽进行等比例缩放
    if (imageH>=imageW) {
        contextW=baseDistance;
        contextH=contextW/imageW*imageH;
        
    }else{
        contextH=baseDistance;
        contextW=contextH/imageH*imageW;
    }
    contextH+=2*bordeW;
    contextW+=2*bordeW;
    //3.确定背景圆的直径
    CGFloat R=MIN(contextW, contextH)/2;
    CGFloat r=R-bordeW;
    
    //4.开启上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(contextW, contextH), NO, 0);
    
    CGFloat f=0;
    if (scale>=0&&scale<=1) {
        f=scale;
    }else
    {
        f=1;
    }
    //5.画大圆(着色背景)
    CGPoint cernter1=CGPointMake(contextW/2, contextH/2);
    UIBezierPath *path=[UIBezierPath  bezierPathWithArcCenter:cernter1 radius:R*f startAngle:0 endAngle:M_PI*2 clockwise:YES];
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    CGContextAddPath(ctx, path.CGPath);
    if (!color) {//颜色为空时,白色为默认颜色.
        [[UIColor  whiteColor]  set];
    }else{
        [color   set];
    }
    CGContextFillPath(ctx);
    //6.画小圆(裁剪图片)
    UIBezierPath *clipPath=[UIBezierPath  bezierPathWithArcCenter:cernter1 radius:r*f startAngle:0 endAngle:M_PI*2 clockwise:YES];
    [clipPath   addClip];
    //7.绘制图片
    //[image  drawAtPoint:CGPointMake(bordeW, bordeW)];
    [image   drawInRect:CGRectMake(bordeW, bordeW, contextW, contextH)];
    //8.获取新图片
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    
    //9关闭上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}


@end
