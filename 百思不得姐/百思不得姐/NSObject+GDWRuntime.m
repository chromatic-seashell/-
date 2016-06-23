//
//  NSObject+GDWRuntime.m
//  百思不得姐
//
//  Created by apple on 15/10/8.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "NSObject+GDWRuntime.h"

@implementation NSObject (GDWRuntime)

#pragma mark - 展示所有的成员变量.
+(void)showAllIvar{
    
    Class c=[self  class];
        while (c&&c!=[NSObject  class]) {
        
        unsigned int outCount;
        Ivar *ivarList = class_copyIvarList([c  class], &outCount);
        //遍历c的所有成员变量.
        for (int i=0; i<outCount; i++) {
            Ivar ivar=*(ivarList+i);
            NSLog(@"%@->%s--%s",c,ivar_getName(ivar),ivar_getTypeEncoding(ivar));
        }
        //释放ivarList变量.
        free(ivarList);
        
        //获得父类的class类型.
        c=class_getSuperclass(c);
    }

}
-(void)showAllIvar{
    [[self  class]  showAllIvar];
}

#pragma mark - 显示所有的属性.
- (void)showAllProperty
{
    return  [[self  class]  showAllProperty];
}
+ (void)showAllProperty
{
    Class c=[self   class];
    
    while (c&&c!=[NSObject class]) {
        
        unsigned int outCount = 0;
        objc_property_t *propertyList = class_copyPropertyList(c, &outCount);
        
        for (int i = 0; i < outCount; i++) {
            objc_property_t property = propertyList[i];
            NSLog(@"%@->%s--%s",c, property_getName(property), property_getAttributes(property));
        }
        //释放内存
        free(propertyList);
        //获得父类.
        c=class_getSuperclass(c);
    }
}

@end
