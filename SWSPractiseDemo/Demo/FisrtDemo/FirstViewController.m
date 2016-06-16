//
//  FirstViewController.m
//  MLTransitionNavigationController
//
//  Created by 施文松 on 16/6/16.
//  Copyright © 2016年 molon. All rights reserved.
//

#import "FirstViewController.h"
#import "HYBClockView.h"
#import "HYBAnimationClock.h"

@interface FirstViewController ()

@property (nonatomic, strong) HYBClockView *clockView;


@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *titleString = [NSString stringWithFormat:@"时钟转动%@", self.number];
    self.title = titleString;


    CGFloat x = ([UIScreen mainScreen].bounds.size.width - 200) / 2;
    self.clockView = [[HYBClockView alloc] initWithFrame:CGRectMake(x, 60, 200, 200)
                                               imageName:@"clock"];
      [self.view addSubview:self.clockView];
    
    HYBAnimationClock *aniClockView = [[HYBAnimationClock alloc] initWithFrame:CGRectMake(x, 280, 200, 200)
                                                                     imageName:@"clock"];
    
    [self.view addSubview:aniClockView];
    
//    [self.clockView releaseTimer];
    //  [self.clockView removeFromSuperview];
//    self.clockView = nil;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
