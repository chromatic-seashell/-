//
//  GDWCentreCommonView.h
//  百思不得姐
//
//  Created by apple on 15/10/22.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDWTopicModel.h"

#import <MediaPlayer/MediaPlayer.h>

@interface GDWCentreCommonView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

/** 帖子模型 */
@property (nonatomic, strong) GDWTopicModel *topic;

+ (instancetype)centreCommonView;


/* 
 视频播放器
 作用:1.当cell从屏幕消失时,及时停止视屏播放
     2.将GDWTopicVideoView中的播放器传递给GDWTopicCell中的播放器
 */
@property (nonatomic, strong) MPMoviePlayerController *videoPlayer;

@end
