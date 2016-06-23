//
//  GDWQuickLoggingButton.m
//  百思不得姐
//
//  Created by apple on 15/10/1.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "GDWQuickLoggingButton.h"

@implementation GDWQuickLoggingButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
    }
    return self;
}

-(void)awakeFromNib{

    //GDWLogFuc;
    self.titleLabel.textAlignment=NSTextAlignmentCenter;
    
}


-(void)layoutSubviews{
    //调用[super  layoutSubviews]方法,系统已经将子控件的尺寸计算好了.
    [super  layoutSubviews];
    //GDWLogFuc;
    //1.改变内部子控件的位置.(使用UIView的分类)
    CGFloat  width=self.width;
    CGFloat  height=self.height;
    //1.1调整内部图片位置.
    self.imageView.y=0;
    self.imageView.centerX=width/2;
    //1.2调整内部lable位置
    self.titleLabel.centerX=width/2;
    self.titleLabel.y=self.imageView.height;
    self.titleLabel.height=height-self.imageView.height;
    self.titleLabel.width=self.width;
    self.titleLabel.x=0;
    
    

}

@end
