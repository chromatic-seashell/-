//
//  UIImageView+GDWExtension.m
//  百思不得姐
//
//  Created by apple on 15/11/2.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UIImageView+GDWExtension.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Tool.h"

@implementation UIImageView (GDWExtension)


/** 设置圆形图片 */
- (void)setCircleImageWithURL:(NSURL *)url{
    [self   sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //图片下载失败,直接返回
        if (image==nil) return ;
        UIImage *newImage=[UIImage   imageCircleClippingWithImage:image border:1 scale:1 color:[UIColor   greenColor ] baseDistance:50];
        //NSLog(@"%@--%@",NSStringFromCGSize(image.size),NSStringFromCGSize(newImage.size));
        
        self.image=newImage;
        
    }];

}

/** 设置带圆角的矩形图片 */
- (void)setRoundCornerImageWithURL:(NSURL *)url  cornerRadius:(CGFloat)radius{
    [self   sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //图片下载失败,直接返回
        if (image==nil) return ;
        self.image=[UIImage   imageRectClippingWithImage:image border:0 color:nil cornerRadius:radius];
        
    }];

}



@end
