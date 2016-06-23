//
//  GDWTopicCell.h
//  百思不得姐
//
//  Created by apple on 15/10/16.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDWTopicModel.h"

#import <MediaPlayer/MediaPlayer.h>

@interface GDWTopicCell : UITableViewCell

/** 帖子模型 */
@property (nonatomic, strong) GDWTopicModel *topic;

/* 视频播放器 作用:当cell从屏幕消失时,及时停止视屏播放*/

@property (nonatomic, strong) MPMoviePlayerController *player;

@end
