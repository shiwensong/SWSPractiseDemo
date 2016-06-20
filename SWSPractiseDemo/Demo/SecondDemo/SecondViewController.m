//
//  SecondViewController.m
//  SWSPractiseDemo
//
//  Created by 施文松 on 16/6/18.
//  Copyright © 2016年 shiwensong. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    NSArray *item = [[NSArray alloc] initWithObjects:@"男",@"女", nil];
    
    UISegmentedControl *sexSegment = [[UISegmentedControl alloc] initWithItems:item];
    sexSegment.layer.borderWidth = 0.0;
    sexSegment.tintColor = [UIColor redColor];
    [sexSegment setFrame:CGRectMake(0, 0, 100, 30)];
    [sexSegment addTarget:self
                   action:@selector(selectSex:)
         forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.titleView = sexSegment;
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

- (void)selectSex:(UISegmentedControl *)segmentControl {
    NSInteger number = segmentControl.selectedSegmentIndex;
    if (number == 0) {
        NSLog(@"点击了第一行");
    }else{
        NSLog(@"点击了第二行");
    }
}

@end
