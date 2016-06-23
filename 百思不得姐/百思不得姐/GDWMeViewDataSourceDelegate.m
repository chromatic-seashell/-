//
//  GDWMeViewDataSourceDelegate.m
//  百思不得姐
//
//  Created by apple on 15/10/12.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "GDWMeViewDataSourceDelegate.h"
#import "GDWMeCell.h"

@implementation GDWMeViewDataSourceDelegate


#pragma mark - tabelView的dataSource方法.
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * ID=@"cell";
    GDWMeCell *cell=[tableView  dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[GDWMeCell  alloc]  init];
    }
    //给cell设置内容
    if (indexPath.section==0) {
        
        cell.textLabel.text=@"登录/注册";
        cell.imageView.image=[UIImage imageNamed:@"publish-audio"];
    }else if(indexPath.section==1){
        cell.textLabel.text=@"离线下载";
        cell.imageView.image=nil;//考虑到循环利用,没有图片的cell的图片也要置空.
    }
    
    return cell;
}


@end
