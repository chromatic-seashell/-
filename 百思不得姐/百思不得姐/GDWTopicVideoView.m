//
//  GDWTopicVideoView.m
//  百思不得姐
//
//  Created by apple on 15/10/20.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "GDWTopicVideoView.h"

#import "UIImageView+WebCache.h"


#import <MediaPlayer/MediaPlayer.h>


@interface GDWTopicVideoView ()


@property (weak, nonatomic) IBOutlet UILabel *playcountLable;
@property (weak, nonatomic) IBOutlet UILabel *videotimeLable;

/* 视频播放器*/
@property (nonatomic, strong) MPMoviePlayerController *player;

@end



@implementation GDWTopicVideoView

/** player懒加载 */
- (MPMoviePlayerController *)player{
    if (!_player) {
        //1.创建播放器
        NSURL *url =[NSURL  URLWithString:[NSString  stringWithFormat:@"%@",self.topic.videouri]];
        
        MPMoviePlayerController *player = [[MPMoviePlayerController  alloc] initWithContentURL:url];
                
        self.player = player;
    }
    return _player;
}


- (void)setTopic:(GDWTopicModel *)topic{
    
    [super  setTopic:topic];
    if (topic.videotime) {
        //GDWLog(@"%@",topic.videouri);
    }
    
    NSString *imageUrl=topic.middle_image;
    
    [self.imageView  sd_setImageWithURL:[NSURL  URLWithString:imageUrl] placeholderImage:nil];
    
    self.playcountLable.text=[NSString   stringWithFormat:@"%ld播放",topic.playcount];
    self.videotimeLable.text=[NSString   stringWithFormat:@"%02ld : %02ld",topic.videotime/60,topic.videotime%60];
    
    //删除上一个播放器数据
    if (_player != nil) {
        
        [_player.view  removeFromSuperview];
        _player = nil;
    }
    self.videoPlayer = self.player;
    
}

- (IBAction)playVideoClick:(UIButton *)sender {
    
    
    //NSLog(@"开始播放视屏--%@",self.topic.videouri);
    //NSLog(@"%@",NSStringFromCGRect(self.bounds));
    //1创建播放器
//    NSURL *url =[NSURL  URLWithString:[NSString  stringWithFormat:@"%@",self.topic.videouri]];
//    
//    MPMoviePlayerController *player = [[MPMoviePlayerController  alloc] initWithContentURL:url];
//    self.player = player;
    //2.设置播放器内部view的尺寸
    
    self.player.view.frame = self.bounds;
//
    //3.添加到控制器的view中
    [self  addSubview:self.player.view];
    
    //4.开始播放
    [self.player   play];
}

@end
