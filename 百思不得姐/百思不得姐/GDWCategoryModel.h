//
//  GDWCategoryModel.h
//  百思不得姐
//
//  Created by apple on 15/10/23.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDWDetailModel.h"

@interface GDWCategoryModel : NSObject

/** 名称 */
@property (nonatomic, copy) NSString *name;

/** id */
@property (nonatomic, copy) NSString *id;

/** 详情模型数组---用来缓存从服务器下载的数据 */
@property (nonatomic, strong) NSMutableArray *details;
/** 记录加载详情内容的页数 */
@property (nonatomic, assign) NSInteger page;




@end
