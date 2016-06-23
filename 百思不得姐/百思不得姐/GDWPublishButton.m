//
//  GDWPublishButton.m
//  百思不得姐
//
//  Created by apple on 15/10/29.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "GDWPublishButton.h"

#define imageHScale  .8

@implementation GDWPublishButton

#pragma mark - 改变button内部子控件的属性.
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageView.contentMode=UIViewContentModeCenter;
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        
    }
    return self;
}

#pragma mark - 改变button内部子控件位子的方法1.
//-(CGRect)titleRectForContentRect:(CGRect)contentRect{
//    //GDWLog(@"%@",NSStringFromCGRect(contentRect));
//    CGFloat w=contentRect.size.width;
//    CGFloat h=contentRect.size.height;
//    return  CGRectMake(0, imageHScale*h, w, (1-imageHScale)*h);
//}
//-(CGRect)imageRectForContentRect:(CGRect)contentRect{
//    GDWLog(@"%@",NSStringFromCGRect(contentRect));
//    CGFloat w=contentRect.size.width;
//    CGFloat h=contentRect.size.height;
//    return  CGRectMake(0, 0, w, imageHScale*h);
//}
#pragma mark - 改变button内部子控件位子的方法2.
-(void)layoutSubviews{
    [super  layoutSubviews];
    //GDWLogFuc
    CGFloat w=self.frame.size.width;
    CGFloat h=self.frame.size.height;
    self.titleLabel.frame=CGRectMake(0, imageHScale*h, w, (1-imageHScale)*h);
    self.imageView.frame=CGRectMake(0, 0, w, imageHScale*h);
}

@end
