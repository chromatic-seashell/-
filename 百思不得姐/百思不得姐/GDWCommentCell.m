//
//  GDWCommendCell.m
//  百思不得姐
//
//  Created by apple on 15/10/27.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "GDWCommentCell.h"
#import "UIImageView+WebCache.h"
#import "GDWCommentModel.h"

@interface GDWCommentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;

@end

@implementation GDWCommentCell

- (void)awakeFromNib {
    // Initialization code
    //设置cell的背景图片
    self.backgroundView=[[UIImageView   alloc]   initWithImage:[UIImage  imageNamed:@"mainCellBackground"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCommendModel:(GDWCommentModel *)commentModel{
    //测试数据
    //commentModel.content=nil;
    //commentModel.voicetime=40+arc4random_uniform(40);
    //commentModel.voiceuri=@"yht";
    
    _commendModel=commentModel;
    GDWUserModel *user=commentModel.user;
    //赋值
    //1.头像
    [self.profileImageView   sd_setImageWithURL:[NSURL   URLWithString:user.profile_image] placeholderImage:nil];
    //2.性别
    if ([user.sex  isEqualToString:@"m"]) {
        self.sexView.image=[UIImage   imageNamed:@"Profile_manIcon"];
    
    }else if([user.sex  isEqualToString:@"f"]){
        self.sexView.image=[UIImage   imageNamed:@"Profile_womanIcon"];
    }
    //3.名称
    self.usernameLabel.text=user.username;
    //4.内容
    self.contentLabel.text=commentModel.content;
    //5.点赞数
    self.likeCountLabel.text=[NSString  stringWithFormat:@"%ld",commentModel.like_count];
    //6.语音评论
    if (commentModel.voiceuri.length) {
        self.voiceButton.hidden=NO;
        [self.voiceButton   setTitle:[NSString  stringWithFormat:@"%ld",commentModel.voicetime] forState:UIControlStateNormal];
    }else{
    
        self.voiceButton.hidden=YES;
    }
    
    

}

@end
