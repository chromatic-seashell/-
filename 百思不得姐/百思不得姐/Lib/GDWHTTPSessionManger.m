//
//  GDWHTTPSessionManger.m
//  百思不得姐
//
//  Created by apple on 15/11/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "GDWHTTPSessionManger.h"

@implementation GDWHTTPSessionManger

//重写父类的manager方法
+(instancetype)manager{

    GDWHTTPSessionManger *manager =[super  manager];
    return manager;
}

@end
