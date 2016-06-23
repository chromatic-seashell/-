//
//  GDWTopicCell.m
//  百思不得姐
//
//  Created by apple on 15/10/16.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "GDWTopicCell.h"
#import "GDWTopicPictureView.h"
#import "GDWTopicVideoView.h"
#import "GDWTopicAudioView.h"
#import "UIImageView+WebCache.h"

#import "GDWHotComment.h"
#import "GDWUserModel.h"

@interface GDWTopicCell ()

/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/** 名称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 创建时间 */
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
/** 内容 */
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

//最热评论
@property (weak, nonatomic) IBOutlet UIView *hotComment;
@property (weak, nonatomic) IBOutlet UILabel *hotCmtUserName;
@property (weak, nonatomic) IBOutlet UILabel *hotCmtContent;


/* 图片 */
@property (nonatomic,weak) GDWTopicPictureView *pictureView;
/* 视频 */
@property (nonatomic,weak) GDWTopicVideoView *videoView;
/* 声音 */
@property (nonatomic,weak) GDWTopicAudioView *audioView;


@end

@implementation GDWTopicCell

- (void)awakeFromNib {
    
}



#pragma mark  - 懒加载
- (GDWTopicPictureView *)pictureView{
    if (!_pictureView) {
        GDWTopicPictureView *pictureView=[GDWTopicPictureView  centreCommonView];
        [self.contentView  addSubview:pictureView];
        self.pictureView=pictureView;
    }
    return _pictureView;
}
/** videoView懒加载 */
- (GDWTopicVideoView *)videoView{
    if (!_videoView) {
        GDWTopicVideoView *videoView = [GDWTopicVideoView   centreCommonView];
        self.videoView=videoView;
        [self.contentView   addSubview:videoView];
    }
    return _videoView;
}
/** audioView懒加载 */
- (GDWTopicAudioView *)audioView{
    if (!_audioView) {
        
        GDWTopicAudioView *audioView = [GDWTopicAudioView   centreCommonView];
        self.audioView=audioView;
        [self.contentView  addSubview:self.audioView];
    }
    return _audioView;
}

- (void)setTopic:(GDWTopicModel *)topic{
    //GDWLogFuc
    _topic=topic;
    //1.设置cell头部和尾部.
    //设置头像.
    [self.profileImageView  sd_setImageWithURL:[NSURL  URLWithString:topic.profile_image]];
    //设置名称
    self.nameLabel.text=topic.name;
    //设置创建时间
    self.createdAtLabel.text=topic.create_time;
    //设置内容.
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:topic.text];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, text.length)];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.firstLineHeadIndent = 20;
    [text addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, text.length)];
    self.text_label.attributedText=text;
    //设置4个按钮的文字.
    [self.dingButton  setTitle:[NSString   stringWithFormat:@"%zd",topic.ding] forState:UIControlStateNormal];
    [self.caiButton  setTitle:[NSString   stringWithFormat:@"%zd",topic.cai] forState:UIControlStateNormal];
    [self.repostButton  setTitle:[NSString   stringWithFormat:@"%zd",topic.repost] forState:UIControlStateNormal];
    [self.commentButton  setTitle:[NSString   stringWithFormat:@"%zd",topic.comment] forState:UIControlStateNormal];
    
    //2.设置cell中间内容.
    GDWTopicType type=topic.type;
    
    if (type==GDWTopicTypePicture) {//图片类型
        //显示
        self.pictureView.hidden=NO;
        //设置图片尺寸.
        self.pictureView.frame=topic.contentFrame;
        //给pictureView的模型赋值.
        self.pictureView.topic=topic;
        self.videoView.hidden=YES;
        self.audioView.hidden=YES;
        
    }else if (type==GDWTopicTypeWord){//文字类型
        self.videoView.hidden=YES;
        self.pictureView.hidden=YES;
        self.audioView.hidden=YES;
    }else if (type==GDWTopicTypeVoice) {//声音
        //设置数据
        self.audioView.topic=topic;
        //显示
        self.audioView.hidden=NO;
        //尺寸
        self.audioView.frame=topic.contentFrame;
        
        self.videoView.hidden=YES;
        self.pictureView.hidden=YES;
    }else if (type==GDWTopicTypeVideo){//视频
        self.videoView.topic=topic;
        
        self.player = self.videoView.videoPlayer;
        //尺寸
        self.videoView.frame=topic.contentFrame;
        //显示
        self.videoView.hidden=NO;
        self.pictureView.hidden=YES;
        self.audioView.hidden=YES;
    }
    //3.设置最热评论
    if (topic.top_cmt.count) {//根据条件,显示并设置最热评论的内容.

        self.hotComment.hidden=NO;
        GDWHotComment *hotComment=[topic.top_cmt   firstObject];
        NSString *name=hotComment.user.username;
        NSString *comment=hotComment.content;
        self.hotCmtContent.text=[NSString  stringWithFormat:@"%@ : %@",name,comment];
        
        /*
         NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@""];
         //设置字体颜色
         
         [text addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, text.length)];
         //设置缩进、行距
         NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
         
         style.headIndent = 30;//缩进
         style.firstLineHeadIndent = 0;
         [text addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, text.length)];
         
         
         */
    }else{//考虑循环利用,需要隐藏最热评论.
        self.hotComment.hidden=YES;
    }

}
/*
 一些方法调用顺序:
 -[GDWAllViewController tableView:cellForRowAtIndexPath:]
 -[GDWTopicCell setFrame:]
 -[GDWTopicCell setFrame:]
 -[GDWTopicCell layoutSubviews]
 */
/** 当系统计算好cell尺寸,重新调整cell位置 */
-(void)setFrame:(CGRect)frame{
    //GDWLogFuc
    frame.size.height-=GDWMargin;
    [super setFrame:frame];

}
-(void)layoutSubviews{

    [super  layoutSubviews];
}
@end
