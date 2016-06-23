//
//  GDWMeSquareButton.m
//  百思不得姐
//
//  Created by apple on 15/10/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "GDWMeSquareButton.h"

#define imageScale  0.5

@implementation GDWMeSquareButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self  setUp];
    }
    return self;
}

- (void)setUp{
    self.backgroundColor=[UIColor   whiteColor];
    self.titleLabel.textAlignment=NSTextAlignmentCenter;
    self.titleLabel.font=[UIFont  systemFontOfSize:15];
    [self  setTitleColor:[UIColor  blackColor] forState:UIControlStateNormal];
    

}
- (void)layoutSubviews{
    [super   layoutSubviews];
    
    //图片位置.
    CGFloat  width=self.width;
    CGFloat  height=self.height;
    self.imageView.bounds=CGRectMake(0, 0, width*imageScale, height*imageScale);
    self.imageView.y=height*.2;
    //lable位置.
    self.titleLabel.frame=CGRectMake(0, self.imageView.bottom, width, self.height-self.imageView.bottom);
}

-(void)setFrame:(CGRect)frame{
    
    frame.size.height-=1;
    frame.size.width-=1;
    [super  setFrame:frame];
}

@end
