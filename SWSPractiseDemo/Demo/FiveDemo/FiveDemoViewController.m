//
//  FiveDemoViewController.m
//  SWSPractiseDemo
//
//  Created by 施文松 on 16/6/20.
//  Copyright © 2016年 shiwensong. All rights reserved.
//

#import "FiveDemoViewController.h"

@interface FiveDemoViewController () <UIWebViewDelegate>

@property (strong, nonatomic) UIWebView * webView;

@end

@implementation FiveDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"webview浏览图片";
    
    if (!self.webView) {
        _webView = [[UIWebView alloc] init];
        _webView.delegate = self;
        [self.view addSubview:_webView];
        WS(ws);
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(ws.view);
        }];
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://mp.weixin.qq.com/s?__biz=MjM5NzYwNjk2Mg==&mid=212414038&idx=1&sn=a75b280a33e50c7f52267bb31f4d9390&scene=20&scene=23&srcid=0620Peh4CIqKlBvNhkeVNSwS#rd"]];
    [self.webView loadRequest:request];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnClick:)];
    tap.cancelsTouchesInView = NO;

    [self.webView addGestureRecognizer:tap];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}
- (void)tapOnClick:(UITapGestureRecognizer *)tap {
    
    CGPoint touchPoint = [tap locationInView:self.webView];
    
    NSString *js = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).src", touchPoint.x, touchPoint.y];
    NSString *urlToSave = [self.webView stringByEvaluatingJavaScriptFromString:js];
    
    NSLog(@"urlToSave == %@", urlToSave);
}


@end
