//
//  GDWCategoryDetailDataSouceDelegate.h
//  百思不得姐
//
//  Created by apple on 15/10/23.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GDWCategoryDetailDataSouceDelegate : NSObject<UITableViewDelegate,UITableViewDataSource>

/** 详情的模型数组. */
@property (nonatomic, strong) NSArray *details;

@end
