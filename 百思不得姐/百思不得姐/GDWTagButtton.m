
//
//  GDWTagButtton.m
//  百思不得姐
//
//  Created by apple on 15/10/31.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "GDWTagButtton.h"

@implementation GDWTagButtton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置属性
        [self  setTitleColor:[UIColor  whiteColor] forState:UIControlStateNormal];
        self.titleLabel.font=[UIFont   systemFontOfSize:15];
        self.backgroundColor=[UIColor  purpleColor];
        [self   setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
        
    }
    return self;
}
#pragma mark - 重写设置标题方法.
- (void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super  setTitle:title forState:state];
    //自动计算尺寸.
    [self  sizeToFit];
    //调整
    self.height=GDWTagH;
    self.width+=3*GDWSmallMargin;
}

#pragma mark - 布局子控件
- (void)layoutSubviews{
    [super  layoutSubviews];
    self.titleLabel.x=GDWSmallMargin;
    self.imageView.x=CGRectGetMaxX(self.titleLabel.frame)+GDWSmallMargin;
}

@end
