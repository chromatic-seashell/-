//
//  GDWRecommendTagCell.m
//  百思不得姐
//
//  Created by apple on 15/10/8.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "GDWRecommendTagCell.h"
#import "UIImageView+WebCache.h"

@interface GDWRecommendTagCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageListView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;

@end

@implementation GDWRecommendTagCell

/*
   1.把图片变成圆形图片的方法
    1>使用imageView的图层进行设置,会比较消耗性能,当tableView滚动的时候,会卡顿?
    2>使用Quartz2D,把图片裁剪成圆形,在设置在imageView上.(性能较好)
 
 */

-(void)setRecommendTagModel:(GDWRecommendTagModel *)recommendTagModel{
   
    _recommendTagModel=recommendTagModel;    
    //1.设置图片
    //[self.imageListView  sd_setImageWithURL:[NSURL  URLWithString:recommendTagModel.image_list] placeholderImage:[UIImage  imageNamed:@"defaultUserIcon"]];
    [self.imageListView    sd_setImageWithURL:[NSURL   URLWithString:recommendTagModel.image_list] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        UIImage *circleImage=[UIImage   imageCircleClippingWithImage:image border:1 scale:1 color:[UIColor  greenColor]];
        self.imageListView.image=circleImage;
        //矩形圆角
//        UIImage *rectImage=[UIImage   imageRectClippingWithImage:image border:1 color:[UIColor  greenColor] cornerRadius:10];
//        self.imageListView.image=rectImage;
        
    }];
    
    //2.设置主题
    self.themeNameLabel.text=recommendTagModel.theme_name;
    //3.设置订阅人数
    if (recommendTagModel.sub_number>10000) {
        self.subNumberLabel.text=[NSString  stringWithFormat:@"%.1f万人订阅",recommendTagModel.sub_number/10000.0];
    }else{
        self.subNumberLabel.text=[NSString  stringWithFormat:@"%ld人订阅",recommendTagModel.sub_number];
    }
}
//通过图层设置圆形图片.
//- (void)circleImage:(UIImageView *)imageView{
//
//    CGFloat width=imageView.width/2;
//    CGFloat height=imageView.height/2;
//    CGFloat radius=MIN(width, height);
//    imageView.layer.cornerRadius=radius;
//    imageView.layer.masksToBounds=YES;
//}

//监听点击事件,使cell发生移动.
//- (IBAction)showRightBorder:(UIButton *)sender {
//    
//    [UIView  animateWithDuration:.5 animations:^{
//        
//       self.transform=CGAffineTransformTranslate(self.transform, -50, 0);
//    } completion:^(BOOL finished) {
//        
//        
//    }];
//}

-(void)setFrame:(CGRect)frame{
    //GDWLogFuc;
    frame.size.height-=1;
    frame.origin.x+=10;
    frame.size.width-=20;
    [super  setFrame:frame];
    //GDWLog(@"%@",NSStringFromCGRect(frame));

}

-(void)layoutSubviews{
    //GDWLogFuc;
    [super layoutSubviews];
    //self.height-=1;

}

@end
