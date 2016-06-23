//
//  GDWTopicModel.m
//  百思不得姐
//
//  Created by apple on 15/10/16.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "GDWTopicModel.h"
#import "GDWHotComment.h"
#import "GDWUserModel.h"

@implementation GDWTopicModel

+(NSDictionary *)replacedKeyFromPropertyName{
   
    return @{
             @"ID" : @"id",
             @"small_image" : @"image0",
             @"middle_image" : @"image2",
             @"large_image" : @"image1",
             };

}
+(NSDictionary *)objectClassInArray{

    return @{@"top_cmt":@"GDWHotComment"};

}
/*
 1.今年
 1> 今天
 1) 时间间隔 >= 1个小时 -> 5小时前
 2) 1个小时 > 时间间隔 >= 1分钟 -> 25分钟前
 3) 时间间隔 < 1分钟 -> 刚刚
 
 2> 昨天 -> 昨天 17:56:34
 
 3> 其他 -> 07-06 19:47:57
 
 2.非今年 -> 2014-08-06 19:47:57
 */


/** 重写create_time的getter方法 */

- (NSString *)create_time
{
    // 服务器返回的日期
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createdAtDate = [fmt dateFromString:_create_time];
    
    if (createdAtDate.isThisYear) { // 今年
        if (createdAtDate.isToday) { // 今天
            // 当前时间
            NSDate *nowDate = [NSDate date];
            // 日历对象
            NSCalendar *calendar = [NSCalendar currentCalendar];
            
            NSCalendarUnit unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
            NSDateComponents *cmps = [calendar components:unit fromDate:createdAtDate toDate:nowDate options:0];
            if (cmps.hour >= 1) { // 时间间隔 >= 1个小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1个小时 > 时间间隔 >= 1分钟
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else {
                return @"刚刚";
            }
        } else if (createdAtDate.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:createdAtDate];
        } else { // 其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:createdAtDate];
        }
    } else { // 非今年
        return _create_time;
    }
}

#pragma mark - cell中间部分的frame
//-(CGRect)contentFrame{
//    if(_contentFrame.size.height) return _contentFrame;
//    GDWLogFuc
//   //文字
//    CGFloat  contentH=0;
//    CGFloat  textY=70;
//    CGFloat  textW=[UIScreen   mainScreen].bounds.size.width-2*GDWMargin;
//    CGFloat  textH=[self.text   boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin  attributes:@{NSFontAttributeName:[UIFont  systemFontOfSize:15]} context:nil].size.height;
//    contentH=textY+textH+GDWMargin;
//    
//    //图片
//    CGFloat  imageW=textW;
//    CGFloat  imageH=imageW/self.width*self.height;//图片宽高等比例缩放.
//    if (imageH>[UIScreen   mainScreen].bounds.size.height*.8) {
//        imageH=400;
//    }
//    _contentFrame=CGRectMake(GDWMargin, contentH, textW, imageH);
//    return CGRectMake(GDWMargin, contentH, textW, imageH);
//}

#pragma mark - cell高度
-(CGFloat)cellHeight{
    if(_cellHeight) return _cellHeight;
    //GDWLogFuc
    //文字
    CGFloat  contentH=0;
    CGFloat  textY=70;
    CGFloat  textW=[UIScreen   mainScreen].bounds.size.width-2*GDWMargin;
    CGFloat  textH=[self.text   boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin  attributes:@{NSFontAttributeName:[UIFont  systemFontOfSize:15]} context:nil].size.height;
    contentH=textY+textH+GDWMargin;
    
    //图片
    CGFloat  imageW=textW;
    CGFloat  imageH=0;
    if (self.type!=GDWTopicTypeWord) {//不是文字,计算中间内容.
         imageH=imageW/self.width*self.height;//图片宽高等比例缩放.
    }
    //NSLog(@"%@ 宽%f  高%f",self.text,self.width,self.height);
    if (imageH>[UIScreen   mainScreen].bounds.size.height*.8&&(!self.is_gif)) {
        self.bigPicture=YES;//是大图片
        imageH=200;
    }
    _contentFrame=CGRectMake(GDWMargin, contentH, textW, imageH);
    contentH+=imageH+GDWMargin;
    //最热评论
    if (self.top_cmt.count) {//有最热评论.
        CGFloat  cmtNameH=18;
        GDWHotComment *comment=self.top_cmt[0];
        NSString *cmtContent=[NSString   stringWithFormat:@"%@ : %@",comment.user.username,comment.content];
       CGFloat cmtTextH= [cmtContent  boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont  systemFontOfSize:15]} context:nil].size.height;
        contentH+=cmtNameH+cmtTextH;
    }
    CGFloat cellBottomH=50;
    contentH+=cellBottomH;
    /*
     1.-(void)setFrame:(CGRect)frame
     2.由于在-(void)setFrame:(CGRect)frame方法中减GDWMargin,在此多加GDWMargin
     */
    contentH+=GDWMargin;
    _cellHeight=contentH;
    
    return _cellHeight;

}


@end
