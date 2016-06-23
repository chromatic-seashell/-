//
//  GDWCommendModel.h
//  百思不得姐
//
//  Created by apple on 15/10/26.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GDWUserModel.h"

@interface GDWCommentModel : NSObject

/** ID */
@property (nonatomic, strong) NSString *ID;
/** 文字内容 */
@property (nonatomic, copy) NSString *content;
/** 被点赞数 */
@property (nonatomic, assign) NSInteger like_count;
/** 用户 */
@property (nonatomic, strong) GDWUserModel *user;
/** 音频时间 */
@property (nonatomic, assign) NSInteger voicetime;
/** 音频文件的路径 */
@property (nonatomic, copy) NSString *voiceuri;
@end
