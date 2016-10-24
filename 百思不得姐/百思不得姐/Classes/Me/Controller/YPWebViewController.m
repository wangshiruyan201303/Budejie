//
//  YPWebViewController.m
//  百思不得姐
//
//  Created by yupeng on 16/10/4.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import "YPWebViewController.h"
#import "NJKWebViewProgress.h"

@interface YPWebViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBack;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goForward;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

/**
 * 进度代理对象
 */

@property (nonatomic,strong) NJKWebViewProgress * progress;

@end

@implementation YPWebViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.webView.delegate = self;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    
    self.progress = [[NJKWebViewProgress alloc] init];
    self.webView.delegate = self.progress;
    __weak typeof(self) weakSealf = self;
    self.progress.progressBlock = ^(float progress) {
        
        weakSealf.progressView.progress = progress;
        weakSealf.progressView.hidden = (progress == 1.0);
    };
    self.progress.webViewProxyDelegate = self;
    
}

- (IBAction)goBackClicked:(id)sender {
    
    [self.webView goBack];
}

- (IBAction)goForwardClicked:(id)sender {
    
    [self.webView goForward];
}

- (IBAction)refreshClicked:(id)sender {
    
    [self.webView reload];
}

/**
 * 在代理方法中设置前进和后退按钮是否可点
 */
#pragma  mark - UIWebViewDelegate
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    self.goBack.enabled = webView.canGoBack;
    self.goForward.enabled = webView.canGoForward;
}



@end
