//
//  GDWPictureView.m
//  百思不得姐
//
//  Created by apple on 15/10/18.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "GDWTopicPictureView.h"
#import "UIImageView+WebCache.h"



#import "GDWTabBarController.h"
#import "GDWBigPictureController.h"

#import "ProgressView.h"

@interface GDWTopicPictureView ()

@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;
@property (weak, nonatomic) IBOutlet UIButton *bigImageBtn;

@property (weak, nonatomic) IBOutlet ProgressView *progressView;

@property (weak, nonatomic) IBOutlet UIImageView *LogoImageView;


@end

@implementation GDWTopicPictureView


#pragma mark -  awakeFromNib
-(void)awakeFromNib{
    //调用父类中的方法,进行一下设置.
    [super  awakeFromNib];
    
    //给cell中的imageView添加手势.(手势只需要添加一次)
    self.imageView.userInteractionEnabled=YES;
    UITapGestureRecognizer *panGesture=[[UITapGestureRecognizer   alloc]  initWithTarget:self action:@selector(seeBigPicture:)];
    [self.imageView    addGestureRecognizer:panGesture];

}
- (void)seeBigPicture:(UIGestureRecognizer *)gesture{
    //图片没有下载完时,不进行跳转.
    if (self.topic.pictureProgress<1.0) return;
    //1.创建控制器.
    GDWBigPictureController *bigPictureVC=[[GDWBigPictureController   alloc]  init];
    //2.给bigPictureVC控制器传递数据.
    bigPictureVC.topic=self.topic;
    bigPictureVC.image=self.imageView.image;
    //self.window就是主窗口.
    //NSLog(@"%p-----%p",self.window,[UIApplication sharedApplication].keyWindow);
    //3.madal控制器
    [self.window.rootViewController  presentViewController:bigPictureVC animated:YES completion:nil];

}

#pragma mark -  帖子模型topic的setter方法.
-(void)setTopic:(GDWTopicModel *)topic{
    //GDWLogFuc
    
    /*
     给topic属性赋值.(否知getter方法取得的是nil)
     */
    [super   setTopic:topic];
    
    
    //gig标识.
    self.gifImageView.hidden=![topic.middle_image.pathExtension.lowercaseString  isEqualToString:@"gif"];
    //大图片按钮
    self.bigImageBtn.hidden=!topic.isBigPicture;
    
    
    if (topic.isBigPicture) {//是大图片
        
        self.imageView.contentMode=UIViewContentModeTop;
        self.imageView.clipsToBounds=YES;
        //禁止图片交互--使tap手势失效.
        self.imageView.userInteractionEnabled=NO;
    }else{
        self.imageView.contentMode=UIViewContentModeScaleAspectFit;
        self.imageView.clipsToBounds=NO;
        //图片可以交互
        self.imageView.userInteractionEnabled=YES;
    }
    //加载图片.
    //显示logo图片.
    self.LogoImageView.hidden=NO;
    NSURL *url=[NSURL   URLWithString:topic.middle_image];
    __weak  typeof(self)  weakSelf=self;
    [self.imageView  sd_setImageWithURL:url placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        CGFloat progress=fabs(1.0*receivedSize/expectedSize) ;
        //记录下载进度.
        topic.pictureProgress=progress;
        //回到主线程设置进度.
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.progressView.hidden=NO;
            weakSelf.progressView.progress=progress;
            
//            //记录下载进度.
//            topic.pictureProgress=progress;
        });
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //隐藏进度的view
        weakSelf.progressView.hidden=YES;
        self.topic.pictureProgress=1.0;
        //隐藏logo图片
        self.LogoImageView.hidden=YES;
        
        if (topic.isBigPicture==NO) return ;
        //将大图片变成小图片
        CGSize size=CGSizeMake(self.imageView.width, self.imageView.width/topic.width*topic.height);
        UIGraphicsBeginImageContext(size);
        [image   drawInRect:CGRectMake(0, 0, size.width,size.height)];
        self.imageView.image=UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
    }];
    
    
}

#pragma mark - 点击按钮查看大图
- (IBAction)scanBigPicture:(UIButton *)sender {
    
    //return;
    //1.创建控制器.
    GDWBigPictureController *bigPictureVC=[[GDWBigPictureController   alloc]  init];
    //2.给bigPictureVC控制器传递数据.
    bigPictureVC.topic=self.topic;
    bigPictureVC.image=self.imageView.image;
    //self.window就是主窗口.
    //NSLog(@"%p-----%p",self.window,[UIApplication sharedApplication].keyWindow);
    //3.madal控制器
    [self.window.rootViewController  presentViewController:bigPictureVC animated:YES completion:nil];

    
}

@end
