//
//  GDWTagLable.m
//  百思不得姐
//
//  Created by apple on 15/10/30.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "GDWTagLable.h"

@implementation GDWTagLable


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置属性
        self.textColor=[UIColor  whiteColor];
        self.font=[UIFont   systemFontOfSize:15];
        self.backgroundColor=[UIColor   purpleColor];
        self.textAlignment=NSTextAlignmentCenter;
    }
    return self;
}
#pragma mark - 重写text的setter方法
- (void)setText:(NSString *)text{
    [super   setText:text];
    //自动计算大小.
    [self  sizeToFit];
    self.height=GDWTagH;
    self.width+=2*GDWSmallMargin;
}

@end
