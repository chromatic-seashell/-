//
//  GDWPublishTextView.m
//  百思不得姐
//
//  Created by apple on 15/10/30.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "GDWPublishTextView.h"

@interface GDWPublishTextView ()

/* 显示占位文字的lable */
@property (nonatomic,weak) UILabel *placeHolderLable;

@end


@implementation GDWPublishTextView

/** placeHolderLable懒加载 */
- (UILabel *)placeHolderLable{
    if (!_placeHolderLable) {
        UILabel  * placeHolderLable= [[UILabel   alloc]  init];
        placeHolderLable.x=4;
        placeHolderLable.y=8;
        placeHolderLable.numberOfLines=0;
        [self   addSubview:placeHolderLable];
        _placeHolderLable=placeHolderLable;
    }
    return _placeHolderLable;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置属性.
        self.font=[UIFont  systemFontOfSize:15];
        self.placeholderColor=[UIColor   grayColor];
        //监听通知.
        [[NSNotificationCenter   defaultCenter]   addObserver:self selector:@selector(textViewDidChange:) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}
- (void)textViewDidChange:(NSNotification *)note{
    //如果输入文字,则隐藏占位lable
    self.placeHolderLable.hidden=self.hasText;
    
}

- (void)dealloc{
    //移除监听者
    [[NSNotificationCenter  defaultCenter]   removeObserver:self];
}
#pragma mark - 布局子控件
- (void)layoutSubviews{
    [super  layoutSubviews];
    //设置宽度
    self.placeHolderLable.width=self.width-2*self.placeHolderLable.x;
    
    //自动计算高度
    [self.placeHolderLable  sizeToFit];

}

#pragma mark - placeholder的setter
-(void)setPlaceholder:(NSString *)placeholder{
    //copy字符串
    _placeholder=[placeholder   copy];
    self.placeHolderLable.text=placeholder;
    
    //重新布局子控件
    [self   setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor=placeholderColor;
    self.placeHolderLable.textColor=placeholderColor;
}
#pragma mark - 重写下面方法,给控件赋值的同时,控制占位lable的显示及内容.
- (void)setFont:(UIFont *)font{
    [super   setFont:font];
    
    self.placeHolderLable.font=font;
    //重新布局子控件.
    [self   setNeedsLayout];
}

- (void)setText:(NSString *)text{
    [super  setText:text];
    self.placeHolderLable.hidden=self.hasText;
}
- (void)setAttributedText:(NSAttributedString *)attributedText{
    [super   setAttributedText:attributedText];
    self.placeHolderLable.hidden=self.hasText;
}
@end
