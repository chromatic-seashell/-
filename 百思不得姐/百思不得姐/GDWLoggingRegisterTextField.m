//
//  GDWLoggingRegisterTextField.m
//  百思不得姐
//
//  Created by apple on 15/10/2.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "GDWLoggingRegisterTextField.h"

@implementation GDWLoggingRegisterTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //GDWLogFuc;
    }
    return self;
}
/*
 // 富文本 : 具有各种丰富多彩属性的文本
 // 富文本的组成 : NSString(文本) + NSDictionary(丰富多彩属性) + 图片
 // NSAttributedString : 不可变的
 */
-(void)awakeFromNib{
    //GDWLogFuc;
    //文字的颜色;
    self.tintColor=[UIColor  whiteColor];
    //方法1:修改textField的placeholder属性;
    //[self  changePlaceholderByAttributedString];
    
   
}

//方法3:利用KVC来改变placeholder属性.


//方法2:重写父类drawPlaceholderInRect:(CGRect)rect方法,来设置placeholder属性.
- (void)drawPlaceholderInRect:(CGRect)rect{
     //文字属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    attrs[NSFontAttributeName] = self.font;

    // 矩形框
    CGRect placeholderRect;
    placeholderRect.size.height = self.font.lineHeight;
    placeholderRect.size.width = rect.size.width;
    placeholderRect.origin.x = 0;
    placeholderRect.origin.y = (rect.size.height - placeholderRect.size.height) * 0.5;
    // 画占位文字 (下面方法是 NSString(NSStringDrawing)分类中的方法)
    [self.placeholder drawInRect:placeholderRect withAttributes:attrs];
}

//方法1,利用富文本来修改
- (void)changePlaceholderByAttributedString{
    //修改textField的placeholder属性;
    //
    NSMutableDictionary *dic=[NSMutableDictionary  dictionary];
    dic[NSFontAttributeName]=[UIFont   systemFontOfSize:17 weight:3];
    dic[NSForegroundColorAttributeName]=[UIColor  whiteColor];
    self.attributedPlaceholder=[[NSAttributedString   alloc]  initWithString:self.placeholder attributes:dic];
    
    //简单的图文混排
//    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] init];
//    // 哈哈
//    NSAttributedString *haha = [[NSAttributedString alloc] initWithString:@"哈哈"];
//    
//    [string appendAttributedString:haha];
//    
//    // 图片
//    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
//    attachment.image = [UIImage imageNamed:@"header_cry_icon"];
//    attachment.bounds = CGRectMake(0, - 8, 25, 25);
//    NSAttributedString *tupian = [NSAttributedString attributedStringWithAttachment:attachment];
//    [string appendAttributedString:tupian];
//    
//    // 呵呵
//    NSAttributedString *hehe = [[NSAttributedString alloc] initWithString:@"呵呵"];
//    [string appendAttributedString:hehe];
//    self.attributedPlaceholder = string;

}
@end
