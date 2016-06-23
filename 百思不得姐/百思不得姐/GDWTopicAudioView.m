//
//  GDWTopicAudioView.m
//  百思不得姐
//
//  Created by apple on 15/10/20.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "GDWTopicAudioView.h"
#import "GDWTopicModel.h"
#import "UIImageView+WebCache.h"

@interface GDWTopicAudioView ()



@property (weak, nonatomic) IBOutlet UILabel *audioPlayCountLable;

@property (weak, nonatomic) IBOutlet UILabel *audioTimeLable;

@end

@implementation GDWTopicAudioView


- (void)setTopic:(GDWTopicModel *)topic{
    [super  setTopic:topic];
    NSString *imageUrl=topic.middle_image;
    [self.imageView  sd_setImageWithURL:[NSURL  URLWithString:imageUrl] placeholderImage:nil];
    
    self.audioPlayCountLable.text=[NSString   stringWithFormat:@"%ld播放",topic.playcount];
    self.audioTimeLable.text=[NSString   stringWithFormat:@"%02ld : %02ld",topic.videotime/60,topic.voicetime%60];
}


-(void)dealloc{
   //GDWLogFuc
}
@end
