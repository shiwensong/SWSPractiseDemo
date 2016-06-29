//
//  EightDemoViewController.m
//  SWSPractiseDemo
//
//  Created by 施文松 on 16/6/29.
//  Copyright © 2016年 shiwensong. All rights reserved.
//

#import "EightDemoViewController.h"
#import "ZJLabel.h"

@interface EightDemoViewController ()

@property (nonatomic,strong)ZJLabel * zjlabel;


@end

@implementation EightDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ZJLabel * label = [[ZJLabel alloc]initWithFrame:CGRectMake(0,80, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width)];
    self.zjlabel = label;
    label.present = 0.5;
    [self.view addSubview:label];
    label.layer.cornerRadius = [UIScreen mainScreen].bounds.size.width/2.0;
    //  label.present = 0.01;
    label.layer.masksToBounds = YES;
    //给图层添加一个有色边框

    // 设置边框的宽度和样色
    label.layer.borderWidth = 2;
    label.layer.borderColor = [[UIColor colorWithRed:0.52 green:0.09 blue:0.07 alpha:1] CGColor];

    
    ////    这个是小一号的   去点注释  运行 就会有问题
    //    ZJLabel * label1 = [[ZJLabel alloc]initWithFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.width + 20, 100, 100)];
    //  //  self.zjlabel = label1;
    //    [self.view addSubview:label1];
    //    label1.layer.cornerRadius =50;
    //    //  label.present = 0.01;
    //    label1.layer.masksToBounds = YES;
    //    //给图层添加一个有色边框
    //
    //    label1.layer.borderWidth = 2;
    //
    //    label1.present = 0.5;
    //
    //    label1.layer.borderColor = [[UIColor colorWithRed:0.52 green:0.09 blue:0.07 alpha:1] CGColor];
    //
    
    
    
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(50, [UIScreen mainScreen].bounds.size.height - 40, 300, 20)];
    slider.minimumValue = 0;// 设置最小值
    slider.maximumValue = 100;// 设置最大值
    slider.value = (slider.minimumValue + slider.maximumValue) / 2;// 设置初始值
    slider.continuous = YES;// 设置可连续变化
    
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];// 针对值变化添加响应方法
    [self.view addSubview:slider];


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

#pragma mark - IBAction

- (void)sliderValueChanged:(id)sender {
    UISlider *slider = (UISlider *)sender;
    self.zjlabel.present = slider.value/100.0;
    // self.valueLabel.text = [NSString stringWithFormat:@"%.1f", slider.value];
}

@end
