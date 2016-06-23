//
//  NSObject+GDWRuntime.h
//  百思不得姐
//
//  Created by apple on 15/10/8.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

/**
 1.什么是运行时(runtime)?
 1> 是苹果官方提供的一套纯C语言库
 2> 平时编写的OC代码最终都是转换成了运行时(runtime)C语言代码
 // 是苹果官方提供的非常实用的技术,在iOS开发中经常用到
 
 2.你在开发过程中, 怎么使用运行时?
 1> 可以获得一个类中声明的所有成员变量\成员属性\方法等等
 2> 可以动态添加成员变量\成员属性\方法等等
 3> 可以交换两个方法的实现(什么是method swizzle?)
 4> ...
 
 
 3.+ (void)showAllIvar;获得类及父类的所有成员变量.
   + (void)showAllProperty;获得所有类及父类的属性变量,包括类及父类的分类中所有属性变量(分类中属性不能生成成员变量)
 */

@interface NSObject (GDWRuntime)

#pragma mark - 展示所有的成员变量.
+ (void)showAllIvar;
- (void)showAllIvar;
#pragma mark - 显示所有的属性.
- (void)showAllProperty;
+ (void)showAllProperty;

@end
