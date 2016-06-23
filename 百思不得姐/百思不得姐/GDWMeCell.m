//
//  GDWMeCell.m
//  百思不得姐
//
//  Created by apple on 15/10/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "GDWMeCell.h"

@implementation GDWMeCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super  initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //设置背景图片
        //图片边角可能被拉伸,需要进行拉伸设置.
        self.backgroundView=[[UIImageView  alloc]  initWithImage:[UIImage  imageNamed:@"mainCellBackground"]];
        self.textLabel.textColor = [UIColor darkGrayColor];
        
        //self.imageView.backgroundColor=[UIColor  purpleColor];
        
    }
    return self;
}

-(void)layoutSubviews{
    [super  layoutSubviews];
    
    //如果没有图片就不进行设置.
    if (!self.imageView.image) return;
    
    CGFloat width=self.imageView.width;
    CGFloat height=self.height;
    //设置图片
    self.imageView.bounds=CGRectMake(0, 0, .8*width, .8*width);
    self.imageView.centerY=height/2;
    //设置标签.
    self.textLabel.x=self.imageView.right+GDWMargin;

}


@end
