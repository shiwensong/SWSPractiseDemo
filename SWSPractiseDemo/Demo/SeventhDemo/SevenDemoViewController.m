//
//  SevenDemoViewController.m
//  SWSPractiseDemo
//
//  Created by 施文松 on 16/6/24.
//  Copyright © 2016年 shiwensong. All rights reserved.
//

#import "SevenDemoViewController.h"
#import "xuanfuwu.h"

#import "TopView.h"

@interface SevenDemoViewController ()

@end

@implementation SevenDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"悬浮物的demo";
    
    xuanfuwu *xfw = [[xuanfuwu alloc] initWithFrame:CGRectMake(100, 100, 20, 20)];
    [self.view addSubview:xfw];
    
    
    
    TopView *topView = [[TopView alloc] initWithFrame:CGRectMake(100, 300, 100, 100)];
    topView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:topView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)dealloc
{
    NSLog(@"内存释放--%@",NSStringFromClass([self class]) );
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
