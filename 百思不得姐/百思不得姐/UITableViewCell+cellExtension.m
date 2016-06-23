//
//  UITableViewCell+cellExtension.m
//  tableViewCel循环利用
//
//  Created by apple on 15/10/26.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UITableViewCell+cellExtension.h"

@implementation UITableViewCell (cellExtension)
+ (instancetype)createCellWithWithIdentifier:(NSString *)identifer{
    
    
    UITableViewCell *cell=nil;
    NSArray *array=[[NSBundle  mainBundle]  loadNibNamed:NSStringFromClass([self  class]) owner:nil options:nil];
    for (UIView  *view in array) {
        
        if ([view  isKindOfClass:[UITableViewCell   class]]) {
            UITableViewCell *tableViewCell=(UITableViewCell *)view;
            
            if ([tableViewCell.reuseIdentifier  isEqualToString:identifer]) {//判断是否是指定标识的cell
                cell=tableViewCell;
                break;
            }else{//没有指定标示符的cell,使用系统的cell
                NSLog(@"没有找到指定标识的cell使用系统的cell");
                cell=[[UITableViewCell  alloc]  init];
            }
            
        }
        
    }
    return cell;
}
@end
