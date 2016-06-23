//
//  GDWMeSquareModel.h
//  百思不得姐
//
//  Created by apple on 15/10/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 android = "";
 icon = "http://img.spriteapp.cn/ugc/2015/05/20/150532_5078.png";
 id = 28;
 ipad = "";
 iphone = "";
 name = "\U5ba1\U8d34";
 url = "mod://BDJ_To_Check";

 */
@interface GDWMeSquareModel : NSObject

/** 图片 */
@property (nonatomic, copy) NSString *icon;
/** 名称 */
@property (nonatomic, copy) NSString *name;
/** url */
@property (nonatomic, copy) NSString *url;

@end
