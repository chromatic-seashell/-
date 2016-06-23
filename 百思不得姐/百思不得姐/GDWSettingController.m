//
//  GDWTSettingController.m
//  百思不得姐
//
//  Created by apple on 15/9/29.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "GDWSettingController.h"
#import "GDWClearCacheCell.h"


@interface GDWSettingController ()

@end

@implementation GDWSettingController

/*
  1>不同cell可以绑定不同的标识符,
  2>dequeueReusableCellWithIdentifier:会取出对应标识符的cell
 */
static  NSString * const  clearCacheCell=@"clearCacheCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航条
    self.navigationItem.title=@"设置";
    
   //注册cell
    [self.tableView  registerClass:[GDWClearCacheCell  class] forCellReuseIdentifier:clearCacheCell];
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    GDWClearCacheCell *cell=[tableView  dequeueReusableCellWithIdentifier:clearCacheCell];
    
    //GDWLogFuc;
    return cell;
    
}
#pragma mark - UITableViewDelegate
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    UIViewController *vc=[[UIViewController  alloc]  init];
//    vc.view.backgroundColor=[UIColor  lightGrayColor];
//    [self.navigationController   pushViewController:vc animated:YES];
//}





@end
