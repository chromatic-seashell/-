//
//  GDWCentreCommonView.m
//  百思不得姐
//
//  Created by apple on 15/10/22.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "GDWCentreCommonView.h"

@interface GDWCentreCommonView ()


@end

@implementation GDWCentreCommonView



+(instancetype)centreCommonView{
    return [[NSBundle  mainBundle]  loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
    

}

#pragma mark -  awakeFromNib
-(void)awakeFromNib{
    //如果不设置这个属性,第一个创建的对象的尺寸可能有问题.虽然在GDWTopicCell中self.pictureView.frame=topic.contentFrame;
    self.autoresizingMask=UIViewAutoresizingNone;
    
}

@end
