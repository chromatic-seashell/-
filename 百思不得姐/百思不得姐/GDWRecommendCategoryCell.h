//
//  GDWRecommendCategoryCell.h
//  百思不得姐
//
//  Created by apple on 15/10/23.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>


@class GDWCategoryModel;

@interface GDWRecommendCategoryCell : UITableViewCell

/** 分类模型 */
@property (nonatomic, strong) GDWCategoryModel *categoryModel;

@end
