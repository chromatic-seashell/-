//
//  GDWEssenceController.m
//  百思不得姐
//
//  Created by apple on 15/9/28.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "GDWEssenceController.h"
#import "GDWRecommendTagsController.h"

#import "GDWAllViewController.h"
#import "GDWVideoViewController.h"
#import "GDWAudioViewController.h"
#import "GDWPictureViewController.h"
#import "GDWParagraphViewController.h"

#import "GDWTopicButton.h"

@interface GDWEssenceController ()<UIScrollViewDelegate>

/** 标题栏数组 */
@property (nonatomic, strong) NSArray *titleArray;
/** 被选中的按钮 */
@property (nonatomic, strong) UIButton *seletedBtn;

/* 标题栏view */
@property (nonatomic,weak) UIView *titleView;
/** 保存按钮的数组 */
@property (nonatomic, strong) NSMutableArray *btnArray;
/* 按钮下面的指示器 */
@property (nonatomic,weak) UIView *indicatorView;
/* scrollView */
@property (nonatomic,weak) UIScrollView *scrollView;

@end

@implementation GDWEssenceController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置背景颜色.
    self.view.backgroundColor=GDWGrayColor(206);
    //禁止控制器自动调整内边距.(禁止系统的布局,使用自己的布局)
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    //1.设置导航条
    [self  setUpNavgationBar];
    
    //2.标题数组内容.
    self.titleArray=@[@{@"title":@"全部",@"class":[GDWAllViewController  class]},
                      @{@"title":@"视屏",@"class":[GDWVideoViewController  class]},
                      @{@"title":@"声音",@"class":[GDWAudioViewController  class]},
                      @{@"title":@"图片",@"class":[GDWPictureViewController  class]},
                      @{@"title":@"段子",@"class":[GDWParagraphViewController  class]}
                      ];
    
    //3.添加标题栏.
    [self   addTitleView];
    
    //4.添加scrollView
    [self   addScrollView];
    
}

#pragma mark - 添加标题view
- (void)addTitleView{
    //1.创建并添加标题view.
    UIView  *titleView=[[UIView  alloc]  init];
    self.titleView=titleView;
    titleView.frame=CGRectMake(0, GDWNavBarBottom, self.view.width, GDWTitleViewH);
    //背景颜色设为白色半透明.
    titleView.backgroundColor=GDWColorA(100, 200, 180, .8);
    [self.view   addSubview:titleView];

    //2.添加按钮.
    NSUInteger connt=self.titleArray.count;
    CGFloat width=titleView.width/connt;
    CGFloat height=titleView.height;
    self.btnArray=[NSMutableArray  array];
    for (int i=0; i<connt; i++) {
        NSDictionary *dic=self.titleArray[i];
        GDWTopicButton *btn=[[GDWTopicButton  alloc]  init];
        btn.frame=CGRectMake(i*width, 0, width, height);
        //设置标题文字.
        [btn  setTitle:dic[@"title"] forState:UIControlStateNormal];
        //设置文字颜色.
        [btn  setTitleColor:[UIColor  blackColor] forState:UIControlStateNormal];
        [btn  setTitleColor:[UIColor  redColor] forState:UIControlStateSelected];
        
        
        //给按钮添加点击事件.
        [btn   addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [titleView  addSubview:btn];
        [self.btnArray  addObject:btn];
    }
    //3.添加底部的指示器view.
    //3.1创建红色的长条view
    UIView  *indicatorView=[[UIView  alloc]   init];
    
    self.indicatorView=indicatorView;
    
    GDWTopicButton *firstBtn=[self.btnArray  firstObject];
    //3.2记录第一个按钮
    self.seletedBtn=firstBtn;
    //sizeToFit重新计算lable尺寸.
    [firstBtn.titleLabel  sizeToFit];
    indicatorView.width=firstBtn.titleLabel.width;
    indicatorView.bottom=GDWTitleViewH;
    indicatorView.height=1;
    indicatorView.centerX=firstBtn.centerX;
    indicatorView.backgroundColor=[firstBtn  titleColorForState:UIControlStateSelected];
    [titleView  addSubview:indicatorView];
    
}
- (void)btnClick:(UIButton *)btn{
    //titleView的按钮重复点击,发出通知.
    if (self.seletedBtn==btn) {
        //GDWLog(@"重复点击");
        [[NSNotificationCenter  defaultCenter]   postNotificationName:GDWTitleViewButtonRepeatClickNotification object:nil];
        return;
    }
    
    
    self.seletedBtn.selected=NO;
    self.seletedBtn=btn;
    self.seletedBtn.selected=YES;
    
    //1.改变导航条的位置.
    [UIView    animateWithDuration:.25 animations:^{
        self.indicatorView.width=btn.titleLabel.width;
        self.indicatorView.centerX=btn.centerX;
    }];

    //2.根据被点击按钮,重新设置self.scrollView的contentOffset(本身带有动画)
    NSInteger index=[self.btnArray   indexOfObject:btn];
    [self.scrollView   setContentOffset:CGPointMake(index*self.view.width, 0) animated:YES];
    
    //3.加载按钮对应的控制器.
    CGFloat width=self.view.width;
    CGFloat height=self.view.height;
    NSDictionary *dic=self.titleArray[index];
    Class  class=dic[@"class"];
    
    //防止重复添加控制器
    for (UIViewController *vc in self.childViewControllers) {
        
        if ([vc  class]==class) return;
    }
    
    UIViewController *vc=[[class   alloc]  init];
    vc.view.frame=CGRectMake(index*width, 0, width, height);
    [self.scrollView   addSubview:vc.view];
    [self  addChildViewController:vc];

}

#pragma mark - 添加标题scrollView
- (void)addScrollView{
    //1.创建scrollView
    UIScrollView *scrollView=[[UIScrollView  alloc]    init];
    self.scrollView=scrollView;
    scrollView.frame=self.view.bounds;
    scrollView.backgroundColor=GDWCommonGrayColor;
    //设置代理.
    scrollView.delegate=self;
    
    [self.view   insertSubview:scrollView atIndex:0];
    
    //2.添加控制器的view到scrollView.
    NSUInteger connt=self.titleArray.count;
    CGFloat width=self.view.width;
    CGFloat height=self.view.height;
    //设置滚动范围.
    scrollView.contentSize=CGSizeMake(connt*width, height);
    //设置分页.
    scrollView.pagingEnabled=YES;
    //设置导航条.
    scrollView.showsHorizontalScrollIndicator=NO;
    scrollView.showsVerticalScrollIndicator=NO;
    //设置反弹
    scrollView.bounces=NO;
    
    
    NSDictionary *dic=[self.titleArray   firstObject];
    Class  class=dic[@"class"];
    UIViewController *vc=[[class   alloc]  init];
    
    vc.view.frame=CGRectMake(0, 0, width, height);
    [scrollView   addSubview:vc.view];
    [self  addChildViewController:vc];
        
    

}

#pragma mark - UIScrollViewDelegate
//当scrollView滚动结束的时候调用.
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //GDWLogFuc;
    CGPoint  offset=scrollView.contentOffset;
    NSInteger  index=(NSInteger)offset.x/self.scrollView.width;
    GDWTopicButton *btn=self.btnArray[index];
    [self   btnClick:btn];
    
}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    //GDWLogFuc;
}


#pragma mark - 设置导航条
- (void)setUpNavgationBar{
    //1.设置导航条左侧密码.
    UIButton *button=[UIButton  buttonWithType:UIButtonTypeCustom];
    [button  setImage:[UIImage  imageNamed:@"MainTagSubIcon"] forState:UIControlStateNormal];
    [button  setImage:[UIImage  imageNamed: @"MainTagSubIconClick"]   forState:UIControlStateHighlighted];
    [button  addTarget:self action:@selector(recommend) forControlEvents:UIControlEventTouchUpInside];
    //使按钮自适应大小.
    [button  sizeToFit];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem  alloc]  initWithCustomView:button];
    
    //2.设置导航条标题控件.
    self.navigationItem.titleView=[[UIImageView  alloc]  initWithImage:[UIImage  imageNamed:@"MainTitle"]];

}

- (void)recommend{
    
    UIViewController *vc=[[GDWRecommendTagsController  alloc]  init];
    [self.navigationController  pushViewController:vc animated:YES];
}


@end
