//
//  GDWTagField.m
//  百思不得姐
//
//  Created by apple on 15/10/31.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "GDWTagField.h"

@implementation GDWTagField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //初始化.
        // 先设置占位文字
        self.placeholder = @"多个标签用逗号或者换行隔开";
        //占位文字颜色
        [self   setValue:[UIColor  grayColor] forKeyPath:GDWTextFieldPlaceholderColor];
    }
    return self;
}

/**
 *  监听删除键，点击删除键，就会调用这个方法
 */
- (void)deleteBackward{

    //GDWLogFuc
    !self.beforeDeleteBackwardBlock ? :self.beforeDeleteBackwardBlock();
    
    [super  deleteBackward];
}


@end
