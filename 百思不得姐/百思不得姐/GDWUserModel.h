//
//  GDWUserModel.h
//  百思不得姐
//
//  Created by apple on 15/10/18.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GDWUserModel : NSObject

/** 有户名 */
@property (nonatomic, copy) NSString *username;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 性别【f:女（female），m:男（male）】 */
@property (nonatomic, copy) NSString *sex;


@end
