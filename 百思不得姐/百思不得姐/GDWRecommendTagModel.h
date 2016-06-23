//
//  GDWRecommendTagModel.h
//  百思不得姐
//
//  Created by apple on 15/10/8.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GDWRecommendTagModel : NSObject

/** 名字 */
@property (nonatomic, copy) NSString *theme_name;
/** 图片 */
@property (nonatomic, copy) NSString *image_list;
/** 订阅数 */
@property (nonatomic, assign) NSInteger sub_number;

+ (instancetype)recommendTagWithDictionary:(NSDictionary *)dic;
+ (instancetype)recommendTagWithThemename:(NSString *)theme_name   imagelist:(NSString *)image_list  subnumber:(NSInteger)sub_number;

@end
