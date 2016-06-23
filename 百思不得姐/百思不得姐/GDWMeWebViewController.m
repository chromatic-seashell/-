//
//  GDWMeWebViewController.m
//  百思不得姐
//
//  Created by apple on 15/10/12.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "GDWMeWebViewController.h"

@interface GDWMeWebViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *forward;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *back;
@end

@implementation GDWMeWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url=[NSURL  URLWithString:self.url];
    [self.webView   loadRequest:[NSURLRequest   requestWithURL:url]];
    
    //设置代理.
    self.webView.delegate=self;
}

#pragma mark -  UIWebViewDelegate
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    self.forward.enabled=webView.canGoForward;
    self.back.enabled=webView.canGoBack;

}

- (IBAction)forward:(UIBarButtonItem *)sender {
    [self.webView  goForward];
}

- (IBAction)back:(UIBarButtonItem *)sender {
    [self.webView  goBack];
}
- (IBAction)refresh:(UIBarButtonItem *)sender {
    
    
}

@end
