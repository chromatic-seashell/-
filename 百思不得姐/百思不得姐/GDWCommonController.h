//
//  GDWCommonController.h
//  百思不得姐
//
//  Created by apple on 15/10/22.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GDWTopicModel.h"


@interface GDWCommonController : UITableViewController

/** 由子类重写的方法 */
/**  */
//@property (nonatomic, assign) GDWTopicType type;

- (GDWTopicType)type;

@end
