//
//  GDWPublishViewController.m
//  百思不得姐
//
//  Created by apple on 15/10/29.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "GDWPublishViewController.h"
#import "GDWNavgationController.h"
#import "GDWPostWordViewController.h"
#import "GDWPublishButton.h"
#import <POP.h>


@interface GDWPublishViewController ()

/** 按钮数组 */
@property (nonatomic, strong) NSMutableArray *buttons;
/* 标语 */
@property (nonatomic,weak) UIImageView *logoView;
/** 动画时间数组 */
@property (nonatomic, strong) NSArray *times;

@end

@implementation GDWPublishViewController

/** 动画的弹性因素 */
static CGFloat const GDWSpringFactor = 10;
/** 每个动画之间的时间间隔 */
static CGFloat const GDWAnimationDelay = 0.1;



/** buttons懒加载 */
- (NSMutableArray *)buttons{
    if (!_buttons) {
        self.buttons = [NSMutableArray   array];
    }
    return _buttons;
}
/** times懒加载 */
- (NSArray *)times{
    if (!_times) {
        self.times = @[@(GDWAnimationDelay * 5),
                       @(GDWAnimationDelay * 3),
                       @(GDWAnimationDelay * 4),
                       @(GDWAnimationDelay * 2),
                       @(GDWAnimationDelay * 0),
                       @(GDWAnimationDelay * 1),
                       @(GDWAnimationDelay * 6)];
    }
    return _times;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.控制器的view禁止交互
    self.view.userInteractionEnabled=NO;
    
    //2.设置button
    [self   setUpButtons];
    //3.设置logo
    [self   setUpLogoView];
}

#pragma mark - setUpLogoView
- (void)setUpLogoView{
    //1.创建logoView
    UIImageView *logoView=[[UIImageView  alloc]   initWithImage:[UIImage  imageNamed:@"app_slogan"]];
    logoView.centerX=self.view.width*.5;
    logoView.y=-GDWScreenH;
    [self.view  addSubview:logoView];
    self.logoView=logoView;
    
    //2.创建pop动画
    POPSpringAnimation *anim=[POPSpringAnimation  animationWithPropertyNamed:kPOPLayerPositionY];
    anim.toValue=@(GDWScreenH*.15);
    //弹性参数
    anim.springSpeed=GDWSpringFactor;
    anim.springSpeed=GDWSpringFactor;
    //设置时间.
    //
    anim.beginTime=CACurrentMediaTime()+[self.times.lastObject  doubleValue];
    [anim  setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        
        //回复点击
        self.view.userInteractionEnabled=YES;
    }];
    //添加动画.
    [self.logoView.layer   pop_addAnimation:anim forKey:nil];

}

#pragma mark - 设置按钮
- (void)setUpButtons{
    // 1.数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    //2.添加按钮
    //总数
    NSInteger totalCount=titles.count;
    //列数
    NSInteger colsCount=3;
    //行数
    NSInteger rowsCount=totalCount%colsCount ? totalCount/colsCount+1 : totalCount/colsCount;
    CGFloat  buttonW=GDWScreenW/colsCount;
    CGFloat  buttonH=buttonW;
    CGFloat  buttonY=(GDWScreenH -rowsCount*buttonH)*.5;
    
    for (int i=0; i<totalCount; i++) {
        NSString *imageName=images[i];
        NSString *title=titles[i];
        //1.创建按钮
        GDWPublishButton *btn=[[GDWPublishButton  alloc]  init];
        btn.tag=i;
        [btn  setImage:[UIImage  imageNamed:imageName] forState:UIControlStateNormal];
        [btn  setTitle:title forState:UIControlStateNormal];
        //设置位置
        CGFloat x=buttonW*(i%colsCount);
        CGFloat y=buttonY+ buttonH*(i/colsCount);
        btn.frame=CGRectMake(x,y, buttonW, buttonH);
        
        //监听按钮点击
        [btn  addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttons  addObject:btn];
        //添加到控制器view
        [self.view  addSubview:btn];
        
        //2.添加动画
        POPSpringAnimation *anim=[POPSpringAnimation  animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue=[NSValue  valueWithCGRect:CGRectMake(x, y-GDWScreenH, buttonW, buttonH)];
        anim.toValue=[NSValue  valueWithCGRect:CGRectMake(x, y, buttonW, buttonH)];
        //时间
        anim.beginTime=CACurrentMediaTime()+[self.times[i]  doubleValue];
        //弹性参数
        anim.springBounciness=GDWSpringFactor;
        anim.springSpeed=GDWSpringFactor;
        //添加动画
        [btn   pop_addAnimation:anim forKey:nil];
        
    }
}
- (void)btnClick:(GDWPublishButton *)btn{
     [self  closeWithTask:^{
         if (btn.tag==2) {
             //1.创建发布文字的控制器.
             GDWPostWordViewController *postWordVc=[[GDWPostWordViewController  alloc]  init];
             GDWNavgationController *nav=[[GDWNavgationController  alloc] initWithRootViewController:postWordVc];
             //2.madal控制器.
             UIViewController *rootViewController=[UIApplication   sharedApplication].keyWindow.rootViewController;
             [rootViewController  presentViewController:nav animated:YES completion:nil];
             GDWLog(@"%p",nav);
             
         }else{
             
             GDWLog(@"点击了:%@",[btn  titleForState:UIControlStateNormal]);
         }
         
     }];

}

#pragma mark - dismiss控制器
- (IBAction)cancel:(UIButton *)sender {
    [self  closeWithTask:nil];
}
- (void)closeWithTask:(void (^)())task{
    //按钮动画
    for (int i=0;i<self.buttons.count;i++) {
        UIButton *btn=self.buttons[i];
        //创建动画
        POPBasicAnimation  *basicAnim=[POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        basicAnim.toValue=@(GDWScreenH+btn.height);
        //时间
        basicAnim.beginTime=CACurrentMediaTime()+[self.times[i] doubleValue];
        [btn  pop_addAnimation:basicAnim forKey:nil];
    }
    //logoView动画
    //创建动画
    POPBasicAnimation  *basicAnim=[POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    basicAnim.toValue=@(GDWScreenH+self.logoView.height);
    //时间
    basicAnim.beginTime=CACurrentMediaTime()+[self.times.lastObject doubleValue];
    [basicAnim  setCompletionBlock:^(POPAnimation *anim, BOOL finish) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
        // 执行一段动画完毕后的代码
        !task ? : task();
    }];
    [self.logoView  pop_addAnimation:basicAnim forKey:nil];

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self  dismissViewControllerAnimated:YES completion:nil];
}

@end
