//
//  GDWRecommendTagModel.m
//  百思不得姐
//
//  Created by apple on 15/10/8.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "GDWRecommendTagModel.h"

@implementation GDWRecommendTagModel

+ (instancetype)recommendTagWithThemename:(NSString *)theme_name imagelist:(NSString *)image_list subnumber:(NSInteger)sub_number{
    GDWRecommendTagModel *tagModel=[[GDWRecommendTagModel alloc]  init];
    tagModel.theme_name=theme_name;
    tagModel.image_list=image_list;
    tagModel.sub_number=sub_number;
    return tagModel;
}
+ (instancetype)recommendTagWithDictionary:(NSDictionary *)dic{
   
    return [GDWRecommendTagModel   recommendTagWithThemename:dic[@"theme_name"] imagelist:dic[@"image_list"] subnumber:[dic[@"sub_number"] integerValue]];
}
@end
