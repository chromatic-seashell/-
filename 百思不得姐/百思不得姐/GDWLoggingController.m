//
//  GDWLoggingController.m
//  百思不得姐
//
//  Created by apple on 15/9/30.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "GDWLoggingController.h"
#import <objc/runtime.h>


@interface GDWLoggingController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loggingLeadingConstrain;
@end

@implementation GDWLoggingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    

}

//-(void)loadView{
//    //[super loadView];
//    GDWLogFuc;
//    UIImageView *imageView=[[UIImageView  alloc]   initWithImage:[UIImage  imageNamed:@"login_register_background"]];
//
//    self.view=imageView;
//
//}

//状态条由当前控制器决定:
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}





- (IBAction)registerOrNot:(UIButton *)sender {
    //第一种.
//    if ([sender.currentTitle isEqual:@"注册帐号"]) {
//        [sender  setTitle:@"已有帐号吗?" forState:UIControlStateNormal];
//        self.loggingLeadingConstrain.constant=-self.view.width;
//        [UIView   animateWithDuration:.5 animations:^{
//            [self.view   layoutIfNeeded];
//        }];
//    }else{
//        [sender  setTitle:@"注册帐号" forState:UIControlStateNormal];
//        self.loggingLeadingConstrain.constant=0;
//        [UIView   animateWithDuration:.5 animations:^{
////            [self.view   layoutIfNeeded];
//        }];
//    }
    //第二种
    //修改选中状态
    sender.selected=!sender.isSelected;
    //修改约束
    if (self.loggingLeadingConstrain.constant) {
        self.loggingLeadingConstrain.constant=0;
    }else{
        self.loggingLeadingConstrain.constant=-self.view.width;
    }
    //执行动画
    [UIView   animateWithDuration:.5 animations:^{
        [self.view   layoutIfNeeded];
    }];
    
    //退出键盘
    [self.view   endEditing:YES];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.view   endEditing:YES];
}

@end
