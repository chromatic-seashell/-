//
//  GDWTableViewHeaderFooterView.m
//  百思不得姐
//
//  Created by apple on 15/10/27.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "GDWTableViewHeaderFooterView.h"

@interface GDWTableViewHeaderFooterView ()

/* 标签 */
@property (nonatomic,weak) UILabel *lableView;
@end

@implementation GDWTableViewHeaderFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super   initWithReuseIdentifier:reuseIdentifier]) {
       
        //添加一些控件
        UILabel *lable=[[UILabel  alloc]  init];
        self.lableView=lable;
        [self.contentView  addSubview:lable];
        self.contentView.backgroundColor=GDWGrayColor(206);
        
        //设置属性
        lable.x=10;
        lable.width=100;
        lable.autoresizingMask=UIViewAutoresizingFlexibleHeight;
        lable.textColor=[UIColor  purpleColor];
        
    }
    return self;
}

-(void)setText:(NSString *)text{

    _text=[text  copy];
    self.lableView.text=text;
}


@end
