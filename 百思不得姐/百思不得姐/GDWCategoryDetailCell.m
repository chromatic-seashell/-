//
//  GDWCategoryDetailCell.m
//  百思不得姐
//
//  Created by apple on 15/10/23.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "GDWCategoryDetailCell.h"
#import "GDWDetailModel.h"
#import "UIImageView+WebCache.h"

@interface GDWCategoryDetailCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *countLable;

@end

@implementation GDWCategoryDetailCell

- (void)awakeFromNib {
    self.countLable.font=[UIFont  systemFontOfSize:14];
    self.countLable.textColor=[UIColor  lightGrayColor];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setDetailModel:(GDWDetailModel *)detailModel{

    _detailModel=detailModel;
    [self.iconImage   setCircleImageWithURL:[NSURL  URLWithString: detailModel.header]];
    
    self.nameLable.text=detailModel.screen_name;
    //被关注人数.
    NSString *countStr=nil;
    NSInteger count=[detailModel.fans_count integerValue];
    if (count>10000) {
        countStr=[NSString  stringWithFormat:@"%.1f万人关注",count*1.0/10000];
    }else{
        countStr=[NSString  stringWithFormat:@"%ld人关注",count];
    }
    self.countLable.text=countStr;

}


@end
