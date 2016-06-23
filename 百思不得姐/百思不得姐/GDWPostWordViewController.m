//
//  GDWPostWordViewController.m
//  百思不得姐
//
//  Created by apple on 15/10/30.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "GDWPostWordViewController.h"
#import "GDWPublishToolBar.h"
#import "GDWPublishTextView.h"

@interface GDWPostWordViewController ()<UITextViewDelegate>

/* toolBar */
@property (nonatomic,weak) GDWPublishToolBar *toolBar;
/* textView */
@property (nonatomic,weak) GDWPublishTextView *textView;

@end

@implementation GDWPostWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航条
    [self  setUpNav];
    
    //设置textView
    [self  setUpTextView];
    
    //设置toolBar
    [self  setUptoolBar];
}
#pragma mark - 控制器view的生命周期方法
- (void)viewWillAppear:(BOOL)animated{
    [super   viewWillAppear:animated];
    //监听键盘的通知
    [[NSNotificationCenter  defaultCenter]   addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [self.textView   becomeFirstResponder];
}
- (void)keyboardWillChangeFrame:(NSNotification  *)note
{
    //GDWLog(@"%@",note);
    double duration=[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView  animateWithDuration:duration animations:^{
        
        CGFloat  keyboardEndY=[note.userInfo[UIKeyboardFrameEndUserInfoKey]  CGRectValue].origin.y;
        //GDWLog(@"%f",keyboardEndY);
        CGFloat delY=keyboardEndY-GDWScreenH;
        //改变self.toolBar的位置
        /*
         CGAffineTransformMakeTranslation(0, delY);
         CGAffineTransformTranslate(self.toolBar.transform, 0, delY);
         */
        self.toolBar.transform=CGAffineTransformMakeTranslation(0, delY);
        
    }];

}
- (void)dealloc{
    [[NSNotificationCenter  defaultCenter]   removeObserver:self];
}

#pragma mark - 设置导航条
- (void)setUpNav{
    self.title=@"发表文字";
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem  alloc]  initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem  alloc]  initWithTitle:@"发表文字" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    //开始发布按钮不能点击.
    self.navigationItem.rightBarButtonItem.enabled=NO;
    
}

- (void)cancel{
    //退出键盘
    [self.view  endEditing:YES];
    //取消madal控制器
    [self   dismissViewControllerAnimated:YES completion:nil];
    

}
- (void)post{
    //发布
    GDWLog(@"发表文字");
}
#pragma mark - 设置textView
- (void)setUpTextView{
    GDWPublishTextView *textView=[[GDWPublishTextView  alloc]  init];
    
    textView.frame=self.view.bounds;
    textView.placeholder=@"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    
    textView.alwaysBounceVertical=YES;
    //设置代理
    textView.delegate=self;
    [self.view   addSubview:textView];
    self.textView=textView;
    
}
#pragma mark - 设置toolBar
- (void)setUptoolBar{
    //从xib中加载控件.
    GDWPublishToolBar *toolBar=[[NSBundle  mainBundle]  loadNibNamed:NSStringFromClass([GDWPublishToolBar  class]) owner:nil options:nil].firstObject;
    toolBar.width=self.view.width;
    toolBar.y=self.view.height-toolBar.height;
    [self.view  addSubview:toolBar];
    self.toolBar=toolBar;
    
    
}
#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    //GDWLogFuc
    self.navigationItem.rightBarButtonItem.enabled=YES;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view  endEditing:YES];
}
@end
