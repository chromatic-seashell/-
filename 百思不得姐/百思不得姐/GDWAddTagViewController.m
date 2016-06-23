//
//  GDWAddTagViewController.m
//  百思不得姐
//
//  Created by apple on 15/10/30.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "GDWAddTagViewController.h"
#import "GDWTagField.h"
#import "GDWTagButtton.h"

@interface GDWAddTagViewController ()<UITextFieldDelegate>

/* 内容控件：用来存放所有的标签按钮和文本输入框 */
@property (nonatomic,weak) UIView *contentView;
/* 添加标签的按钮 */
@property (nonatomic,weak) UIButton *addTagButton;
/* 文本输入框 */
@property (nonatomic,weak) GDWTagField *textField;
/** 标签按钮数组 */
@property (nonatomic, strong) NSMutableArray *tagButtons;



@end

@implementation GDWAddTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor  purpleColor];
    //设置导航条
    [self   setUpNav];
    
    [self   setUpContentView];
    
    //设置textField
    [self   setUpTextField];
    //设置tagButtons
    [self   setUpTagButtons];
}

#pragma mark - 懒加载
/** tagButtons懒加载 */
- (NSMutableArray *)tagButtons{
    if (!_tagButtons) {
        self.tagButtons = [NSMutableArray   array];
    }
    return _tagButtons;
}

/** addTagButton懒加载 */
- (UIButton *)addTagButton{
    if (!_addTagButton) {
        UIButton *addTagButton=[UIButton  buttonWithType:UIButtonTypeCustom];
        addTagButton.backgroundColor=GDWCommonGrayColor;
        addTagButton.width=self.contentView.width;
        addTagButton.height=GDWTagH;
        addTagButton.titleLabel.font=[UIFont  systemFontOfSize:15];
        addTagButton.contentEdgeInsets=UIEdgeInsetsMake(0, GDWSmallMargin, 0, GDWSmallMargin);
        //按钮内容左对齐.
        addTagButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        [addTagButton   setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //监听按钮点击
        [addTagButton  addTarget:self action:@selector(addTag:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView   addSubview:addTagButton];
        self.addTagButton=addTagButton;
    }
    return _addTagButton;
}
#pragma mark  添加标签
- (void)addTag:(UIButton *)btn{
    [self  addTag];
}

#pragma mark - 设置TagButtons
- (void)setUpTagButtons{
    for (NSString *tag in self.tags) {
        self.textField.text=tag;
        [self  addTag];
    }

}
- (void)addTag{
    //没有文字,不添加
    if (self.textField.hasText==NO) return;
    //最多添加5个标签.
    if (self.tagButtons.count==5) {
        [SVProgressHUD  showErrorWithStatus:@"最多添加5个按钮" maskType:SVProgressHUDMaskTypeBlack];
        return;
    }
    //添加一个按钮
    GDWTagButtton  *tagButton=[[GDWTagButtton  alloc]   init];
    [tagButton   setTitle:self.textField.text forState:UIControlStateNormal];
    //给标签按钮添加监听
    [tagButton   addTarget:self action:@selector(deleteTag:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView   addSubview:tagButton];
    
    //计算标签按钮位置.
    GDWTagButtton *lastTagButton=[self.tagButtons   lastObject];
    if (lastTagButton) {//按钮非空
        CGFloat rightDistance=self.contentView.width-CGRectGetMaxX(lastTagButton.frame)-GDWSmallMargin;
        if (rightDistance >=tagButton.width) {
            tagButton.x=CGRectGetMaxX(lastTagButton.frame)+GDWSmallMargin;
            tagButton.y=lastTagButton.y;
        }else{
            tagButton.x=0;
            tagButton.y=CGRectGetMaxY(lastTagButton.frame)+GDWSmallMargin;
        }
        
    }else{//按钮为空
        tagButton.x=0;
        tagButton.y=0;
    
    }
    //存放新标签
    [self.tagButtons   addObject:tagButton];
    //清空文本框
    self.textField.text=nil;
    //设置文本框的frame
    [self  setUpFieldFrame];
    //隐藏添加按钮
    self.addTagButton.hidden=YES;

}
- (void)setUpFieldFrame{
     //取出最后一个标签按钮
    GDWTagButtton *lastTagButton=self.tagButtons.lastObject;
    //计算文字宽度.
    CGFloat  textFieldWidth=[self.textField.text   sizeWithAttributes:@{NSFontAttributeName:self.textField.font}].width;
    textFieldWidth=MAX(100, textFieldWidth);
    
    //文本框位置
    CGFloat  rightWidth=self.contentView.width-CGRectGetMaxX(lastTagButton.frame)-GDWSmallMargin;
    if (rightWidth>=textFieldWidth) {
        
        self.textField.x=CGRectGetMaxX(lastTagButton.frame)+GDWSmallMargin;
        self.textField.y=lastTagButton.y;
    }else{
        self.textField.x=0;
        self.textField.y=CGRectGetMaxY(lastTagButton.frame)+GDWSmallMargin;
    }
    
    //文本框底部"添加按钮"按钮的位置.
    self.addTagButton.y=CGRectGetMaxY(self.textField.frame)+GDWSmallMargin;
}


#pragma mark  删除标签按钮
- (void)deleteTag:(GDWTagButtton *)tagButton{
    //开启动画任务
    [UIView   beginAnimations:nil context:nil];
    //获得删除按钮的位置.
    NSInteger index=[self.tagButtons    indexOfObject:tagButton];
    //删除按钮
    [tagButton  removeFromSuperview];
    [self.tagButtons   removeObject:tagButton];
    //重新排布所有的标签.
    for (NSInteger i=index ; i<self.tagButtons.count; i++) {
        GDWTagButtton *currentTagButton=self.tagButtons[i];
        if (i>0) {
            GDWTagButtton *previousTagButton=self.tagButtons[i-1];
            CGFloat rightDisance=self.contentView.width-CGRectGetMaxX(previousTagButton.frame)-GDWSmallMargin;
            if (rightDisance >=currentTagButton.width) {
                currentTagButton.x=CGRectGetMaxX(previousTagButton.frame)+GDWSmallMargin;
                currentTagButton.y=previousTagButton.y;
            }else{
                currentTagButton.x=0;
                currentTagButton.y=CGRectGetMaxY(previousTagButton.frame)+GDWSmallMargin;
            }
            
        }else{
            currentTagButton.x=0;
            currentTagButton.y=0;
        }
        
    }
    
    //重新排布文本框
    [self  setUpFieldFrame];
    
    //提交动画
    [UIView   commitAnimations];
}


#pragma mark - 设置导航条
-(void)setUpNav{
    self.title = @"添加标签";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
    // 强制更新
    [self.navigationController.navigationBar layoutIfNeeded];

}
- (void)cancel{
    //退出键盘.
    [self.textField resignFirstResponder];
    [self.view   endEditing:YES];
    //pop控制器.
    [self.navigationController  popViewControllerAnimated:YES];
}
- (void)done{
    
    //1.退出键盘
    [self.view  endEditing:YES];
    //2.传递数据.
    //KVC获取所有标签按钮的名字.
    self.tags = [self.tagButtons   valueForKeyPath:@"currentTitle"];
    !self.getTagsBlock ? :self.getTagsBlock(self.tags);
    
    //3.pop当前控制器.
    [self.navigationController  popViewControllerAnimated:YES];
}
#pragma mark - 设置ContentView
- (void)setUpContentView{
    UIView  *contentView=[[UIView   alloc]   init];
    contentView.x=GDWSmallMargin;
    contentView.y=GDWNavBarBottom+GDWSmallMargin;
    contentView.width=self.view.width-2*GDWSmallMargin;
    contentView.height=self.view.height;
    contentView.backgroundColor=[UIColor  whiteColor];
    [self.view   addSubview:contentView];
    self.contentView=contentView;
}
#pragma mark - 设置setUpTextField
- (void)setUpTextField{
    __weak  typeof(self)  weakSelf=self;
    GDWTagField *textField=[[GDWTagField  alloc]  init];
    textField.width=self.contentView.width;
    textField.height=GDWTagH;
    //监听文本内容变化.
    [textField  addTarget:self action:@selector(textFieldChange) forControlEvents:UIControlEventEditingChanged];
    
    textField.beforeDeleteBackwardBlock=^(){
        if (weakSelf.textField.hasText) return ;
        
        //删除最后一个标签
        GDWTagButtton *lastTagButton=weakSelf.tagButtons.lastObject;
        [weakSelf  deleteTag:lastTagButton];
        
        
    };
    textField.delegate=self;
    //成为第一响应者
    [textField  becomeFirstResponder];
    //强制刷新
    [textField   layoutIfNeeded];
    self.textField=textField;
    [self.contentView   addSubview:textField];
}
#pragma mark  监听文本框输入内容.
- (void)textFieldChange{
    if (self.textField.hasText) {
        //计算文本框
        [self  setUpFieldFrame];
        //设置添加按钮
        self.addTagButton.hidden=NO;
        [self.addTagButton   setTitle:[NSString stringWithFormat:@"添加标签：%@", self.textField.text] forState:UIControlStateNormal];
        //查看最后一个文字.
        NSString *text=self.textField.text;
        if (text.length==1) return;
        // unichar是多字节字符，char是单字节字符
        // unichar的占位符是%C，char的占位符是%c
        unichar lastChar=[text  characterAtIndex:text.length-1];
        NSString *lastString=[NSString  stringWithFormat:@"%C",lastChar];
        if ([lastString  isEqualToString:@","]||[lastString  isEqualToString:@"，"]) {
            //去掉后面的逗号.
            [self.textField    deleteBackward];
            //添加标签.
            [self   addTag];
        }
        
        
    }else{
    
        self.addTagButton.hidden=YES;
    }
    

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view  endEditing:YES];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
     //GDWLogFuc
    [self  addTag];
    return YES;
}

@end
