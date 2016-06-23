//
//  GDWClearCacheCell.m
//  百思不得姐
//
//  Created by apple on 15/10/12.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "GDWClearCacheCell.h"

/** 获得cashes文件路径. */
#define cachesFullPath  [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)  firstObject]  stringByAppendingPathComponent:@"default"]

@implementation GDWClearCacheCell  


/** cell初始化的时候会调用这个方法. */
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super   initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        GDWLogFuc;
        [self  setUp];
    }
    return self;
}

- (void)setUp{
    
    //1.设置cell文字.
    self.textLabel.text=@"清除缓存";
    //2.右边添加一个活动指示器.(指定活动指示器的样式)
    UIActivityIndicatorView *indicatorView=[[UIActivityIndicatorView   alloc]  initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [indicatorView  startAnimating];
    self.accessoryView=indicatorView;
    
    //3.计算缓存大小(计算文件大小可能比较耗时,可以放在子线程中)
    //发送异步任务.
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        //使线程阻塞一段时间.
        [NSThread  sleepForTimeInterval:3];
        // 单位
        double unit = 1000.0;
        //缓存大小
        NSInteger fileSize=[cachesFullPath  fileSize];
        // 标签文字
        NSString *fileSizeText = nil;
        if (fileSize >= pow(unit, 3)) { // fileSize >= 1GB
            fileSizeText = [NSString stringWithFormat:@"%.2fGB", fileSize / pow(unit, 3)];
        } else if (fileSize >= pow(unit, 2)) { // fileSize >= 1MB
            fileSizeText = [NSString stringWithFormat:@"%.2fMB", fileSize / pow(unit, 2)];
        } else if (fileSize >= unit) { // fileSize >= 1KB
            fileSizeText = [NSString stringWithFormat:@"%.2fKB", fileSize / unit];
        } else { // fileSize < 1KB
            fileSizeText = [NSString stringWithFormat:@"%zdB", fileSize];
        }
        
        NSString *text = [NSString stringWithFormat:@"清除缓存(%@)", fileSizeText];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //设置标签文字
            self.textLabel.text=text;
            //去掉活动指示器,设置cell右边箭头样式.
            self.accessoryView=nil;
            self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            
        });
    });
    
    //4.给cell添加一个手势.
    UITapGestureRecognizer  *panGesture=[[UITapGestureRecognizer  alloc]  initWithTarget:self action:@selector(clearCache:)];
    [self  addGestureRecognizer:panGesture];
    
}

- (void)clearCache:(UIGestureRecognizer *)gesture{

    if (self.accessoryView) return;
    //清理缓存.
    //1.弹框
    [SVProgressHUD   showWithStatus:@"正在清理缓存...." maskType:
     SVProgressHUDMaskTypeBlack];
    
    //2.在子线程中清理缓存.
    [[[NSOperationQueue   alloc]  init]  addOperationWithBlock:^{
        
        //使线程阻塞一段时间.
        [NSThread  sleepForTimeInterval:2];
        
        //删除文件
        [[NSFileManager  defaultManager]   removeItemAtPath:cachesFullPath error:nil];
        //回到主线程设置
       [[NSOperationQueue  mainQueue]  addOperationWithBlock:^{
           //取消弹框.
           [SVProgressHUD   dismiss];
           // 修改文字
           self.textLabel.text = @"清除缓存(0B)";
       }];
        
    }];
}


@end
