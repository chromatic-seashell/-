//
//  GDWPublishToolBar.m
//  百思不得姐
//
//  Created by apple on 15/10/30.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "GDWPublishToolBar.h"

#import "GDWAddTagViewController.h"
#import "GDWTagLable.h"

@interface GDWPublishToolBar ()
/** 顶部的view */
@property (weak, nonatomic) IBOutlet UIView *topView;
/** 标签数组 */
@property (nonatomic, strong) NSMutableArray *tagLabels;
/* 添加按钮 */
@property (nonatomic,weak) UIButton *addButton;

@end

@implementation GDWPublishToolBar

#pragma mark - 懒加载
/** tagLables懒加载 */
- (NSMutableArray *)tagLabels{
    if (!_tagLabels) {
        self.tagLabels = [NSMutableArray   array];
    }
    return _tagLabels;
}

- (void)awakeFromNib{
   //添加"+"号按钮
    UIButton *addButton=[[UIButton  alloc]    init];
    [addButton  setImage:[UIImage   imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    //自动计算大小.
    [addButton   sizeToFit];
    [addButton   addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.topView  addSubview:addButton];
    self.addButton=addButton;
    
    //默认创建两个标签.
    [self   createTagLabelsWithTags:@[@"吐槽",@"糗事"]];

}
#pragma mark 加号按钮的监听
- (void)addBtnClick:(UIButton *)btn
{
    //GDWLog(@"%p",[UIApplication  sharedApplication].keyWindow.rootViewController.presentedViewController);
    //1.创建添加标签控制器.
    GDWAddTagViewController *addTagVc=[[GDWAddTagViewController  alloc]  init];
    //KVC给控制器tags属性赋值.
    addTagVc.tags=[self.tagLabels   valueForKeyPath:@"text"];
    //给控制器block属性赋值
    __weak  typeof(self)  weakSelf=self;
    addTagVc.getTagsBlock=^(NSArray *tags){
    
        [weakSelf  createTagLabelsWithTags:tags];
    };
    //2.获取GDWPublishViewController控制器madal出的导航控制器.
    UINavigationController *nav=(UINavigationController *)[UIApplication  sharedApplication].keyWindow.rootViewController.presentedViewController;
    [nav  pushViewController:addTagVc animated:YES];
    
    
}
#pragma mark - 创建标签
- (void)createTagLabelsWithTags:(NSArray *)tags{
     //移除以前所有标签.
    [self.tagLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tagLabels   removeAllObjects];
    //根据标签名数组创建标签.
    for (int i=0; i<tags.count; i++) {
        
        GDWTagLable  *tagLable=[[GDWTagLable  alloc]   init];
        tagLable.text=tags[i];
        [self.topView  addSubview:tagLable];
        [self.tagLabels   addObject:tagLable];
    }
    //布局子控件
    [self   setNeedsLayout];
    //[self   layoutIfNeeded];
}
#pragma mark - 布局子控件
-(void)layoutSubviews{
    [super  layoutSubviews];
    
    //布局所有标签
    for (int i=0; i<self.tagLabels.count; i++) {
        GDWTagLable *tagLable=self.tagLabels[i];
        if (i==0) {
            tagLable.x=0;
            tagLable.y=GDWSmallMargin;
        }else{
            GDWTagLable * previousLable=self.tagLabels[i-1];
            
            CGFloat  rightDistance=self.topView.width-CGRectGetMaxX(previousLable.frame)-GDWSmallMargin;
            if (rightDistance >= tagLable.width) {
                tagLable.x=CGRectGetMaxX(previousLable.frame);
                tagLable.y=previousLable.y;
            }else{
                tagLable.x=0;
                tagLable.y=CGRectGetMaxY(previousLable.frame)+GDWSmallMargin;
            
            }
        }
    }
    //添加"+"号按钮
    GDWTagLable *lastTagLable=self.tagLabels.lastObject;
    CGFloat rightDistance=self.topView.width-CGRectGetMaxX(lastTagLable.frame)-GDWSmallMargin;
    if (rightDistance >=self.addButton.width) {
        
        self.addButton.x=CGRectGetMaxX(lastTagLable.frame);
        self.addButton.y=lastTagLable.y;
    }else{
        self.addButton.x=0;
        self.addButton.y=CGRectGetMaxY(lastTagLable.frame)+GDWSmallMargin;
    }
    //topView的尺寸
    self.topView.height=CGRectGetMaxY(self.addButton.frame)+GDWSmallMargin;
    //调整个toolBar的高度
    CGFloat  oldH=self.height;
    self.height=CGRectGetMaxY(self.topView.frame)+GDWSmallMargin+35;
    self.y+=oldH-self.height;

}



@end
