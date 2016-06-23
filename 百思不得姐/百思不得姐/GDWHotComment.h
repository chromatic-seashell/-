//
//  GDWHotComment.h
//  百思不得姐
//
//  Created by apple on 15/10/18.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GDWUserModel;

@interface GDWHotComment : NSObject

/** 最热评论内容 */
@property (nonatomic, copy) NSString *content;

/** 用户模型 */
@property (nonatomic, strong) GDWUserModel *user;

@end
