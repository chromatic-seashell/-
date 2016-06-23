//
//  GDWMeView.m
//  百思不得姐
//
//  Created by apple on 15/10/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "GDWMeView.h"
#import "GDWMeFooterView.h"
#import "GDWMeViewDataSourceDelegate.h"

@interface GDWMeView ()

/** 数据源和代理对象 */
@property (nonatomic, strong) GDWMeViewDataSourceDelegate *meViewDD;

@end

@implementation GDWMeView

/** tableView初始化,会调用这个方法 */
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self=[super   initWithFrame:frame style:style]) {
        
        //设置GDWMeView对象的一些属性
        [self  setUp];
        
    }
    return self;
}
//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        GDWLogFuc;
//        //设置GDWMeView对象的一些属性
//        [self  setUp];
//    }
//    return self;
//}

- (void)setUp{
    //GDWLogFuc;
    //设置数据源和代理.
    self.meViewDD=[[GDWMeViewDataSourceDelegate  alloc]  init];
    self.dataSource=self.meViewDD;
    self.delegate=self.meViewDD;
    
    //1.设置尾部视图
    GDWMeFooterView *footerView=[[GDWMeFooterView  alloc]  init];
    //footerView.height=1000;
    self.tableFooterView=footerView;
    //2.设置背景颜色
    self.backgroundColor=GDWGrayColor(206);
    //3.设置组头,组头高度.
    self.sectionHeaderHeight=0;
    self.sectionFooterHeight=GDWMargin;
    //4.设置table的内边距.
    self.contentInset=UIEdgeInsetsMake(GDWMargin-GDWGorupFirstCellY, 0, 0, 0);

}

@end
