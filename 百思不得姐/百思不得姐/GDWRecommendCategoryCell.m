//
//  GDWRecommendCategoryCell.m
//  百思不得姐
//
//  Created by apple on 15/10/23.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "GDWRecommendCategoryCell.h"
#import "GDWCategoryModel.h"

@interface GDWRecommendCategoryCell ()

@property (weak, nonatomic) IBOutlet UILabel *categoryNameLable;
@property (weak, nonatomic) IBOutlet UIView *categoryIndicator;

@end


@implementation GDWRecommendCategoryCell

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    //GDWLog(@"%s--%d",__func__,selected);
    //根据cell的选择状态进行设置.
    if (selected) {
        self.categoryIndicator.hidden=NO;
        self.categoryNameLable.textColor=[UIColor  redColor];
    }else{
        self.categoryIndicator.hidden=YES;
        self.categoryNameLable.textColor=[UIColor  blackColor];
    }
    
}

-(void)setCategoryModel:(GDWCategoryModel *)categoryModel{
    _categoryModel=categoryModel;
    
    //给子控件设置数据
    self.categoryNameLable.text=categoryModel.name;

}

@end
