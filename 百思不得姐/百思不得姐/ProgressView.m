//
//  ProgressView.m
//  UI-0726-Quartz2D-下载进度条
//
//  Created by apple on 15/7/26.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ProgressView.h"

@interface ProgressView ()

@property (nonatomic,weak) UILabel *lable;

@end

@implementation ProgressView

//懒加载(在用到时候才进行加载)
- (UILabel *)lable
{
    if (_lable==nil) {
        UILabel *lable=[[UILabel alloc]  init];
        lable.bounds=CGRectMake(0, 0, 100, 100);
        lable.textAlignment=NSTextAlignmentCenter;
        
        //lable.center=self.center;
        CGFloat centerX=self.bounds.size.width*0.5;
        CGFloat centerY=self.bounds.size.height*0.5;
        lable.center=CGPointMake(centerX, centerY);

        _lable=lable;
        [self  addSubview:_lable];
    }
    return _lable;
   
}

//重写PrpgressView中的progress的设值方法.
- (void)setProgress:(CGFloat)progress
{
//    self.progress=progress;//这一步会造成循环调用设值方法.(死循环)
    _progress=progress;
    self.lable.text=[NSString  stringWithFormat:@"%.0f%%",progress*100];
    
    //在屏幕上做一个标记,当屏幕需要刷新时,就会调用drawRect:方法.
    [self  setNeedsDisplay];

}


//视图显示的时候会调用此方法,默认会调用一次.
- (void)drawRect:(CGRect)rect {
    //1.创建上下文
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    
    //2.创建路径

    //2.1设置中心
    CGPoint center =CGPointMake(rect.size.width/2, rect.size.height/2);
    //设置半径
    CGFloat r= MIN(rect.size.height, rect.size.width)*0.4;
    //2.3设置起始和终止位置角度
    CGFloat begin=-M_PI/2;
    CGFloat end=begin +_progress*M_PI*2;
    //2.4绘制路径
    UIBezierPath *path=[UIBezierPath  bezierPathWithArcCenter:center radius:r startAngle:begin endAngle:end clockwise:YES];
    

    //方法:滑动的时候,根据滑动条的进度----颜色会发生变化.
    UIColor *color=[UIColor  colorWithRed:self.progress green:self.progress*0.3 blue:self.progress alpha:1];
    [color  set];
    
    //2.5设置线条的宽度.
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineWidth(ctx, 10);
    
    //3.路径加入到上下文中
    CGContextAddPath(ctx, path.CGPath);
    
    
    //4.渲染
    CGContextStrokePath(ctx);
    
    
}


@end
