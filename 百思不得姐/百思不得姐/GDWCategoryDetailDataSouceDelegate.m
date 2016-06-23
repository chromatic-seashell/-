//
//  GDWCategoryDetailDataSouceDelegate.m
//  百思不得姐
//
//  Created by apple on 15/10/23.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "GDWCategoryDetailDataSouceDelegate.h"
#import "GDWCategoryDetailCell.h"

#import "UITableViewCell+cellExtension.h"



@implementation GDWCategoryDetailDataSouceDelegate

#pragma mark - tabelView的dataSource方法.
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.details.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * ID=@"categoryDetailCell";
    
    GDWCategoryDetailCell *cell=[tableView  dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[GDWCategoryDetailCell  createCellWithWithIdentifier:ID];
        
    }
        //取出模型
    GDWDetailModel *detailModel=self.details[indexPath.row];
    cell.detailModel=detailModel;

    
    return cell;
}


@end
