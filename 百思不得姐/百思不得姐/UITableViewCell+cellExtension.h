//
//  UITableViewCell+cellExtension.h
//  tableViewCel循环利用
//
//  Created by apple on 15/10/26.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (cellExtension)


+ (instancetype)createCellWithWithIdentifier:(NSString *)identifer;


@end
