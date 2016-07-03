//
//  TemDemoViewController.m
//  SWSPractiseDemo
//
//  Created by 施文松 on 16/7/1.
//  Copyright © 2016年 shiwensong. All rights reserved.
//

#import "TemDemoViewController.h"

@interface TemDemoViewController () <UIWebViewDelegate>

@end

@implementation TemDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIWebView *webView = [[UIWebView alloc] init];
    [self.view addSubview:webView];
    WS(ws);
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view);
    }];
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [webView loadRequest:request];
    
    webView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebView获取Cookie

// 工厂类中存储cookie的方法
+ (void)saveCookies {
    // 创建一个可变字典存放cookie
    NSMutableDictionary *fromappDict = [NSMutableDictionary dictionary];
    [fromappDict setObject:@"fromapp" forKey:NSHTTPCookieName];
    [fromappDict setObject:@"ios" forKey:NSHTTPCookieValue];
    // kDomain是公司app网址
    NSString *kDomain = @"https://www.baidu.com";
    [fromappDict setObject:kDomain forKey:NSHTTPCookieDomain];
    [fromappDict setObject:kDomain forKey:NSHTTPCookieOriginURL];
    [fromappDict setObject:@"/" forKey:NSHTTPCookiePath];
    [fromappDict setObject:@"0" forKey:NSHTTPCookieVersion];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"shiwensong" forKey:@"name"];
    [params setValue:@"23" forKey:@"age"];
    [params setValue:@"choongqing" forKey:@"address"];


    // 将可变字典转化为cookie
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:params];
    
    // 获取cookieStorage
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    // 存储cookie
    [cookieStorage setCookie:cookie];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}

@end
