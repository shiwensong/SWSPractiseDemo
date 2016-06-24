//
//  FirstTableViewController.m
//  MLTransitionNavigationController
//
//  Created by 施文松 on 16/6/16.
//  Copyright © 2016年 molon. All rights reserved.
//

#import "FirstTableViewController.h"

@interface FirstTableViewController ()


@property (strong, nonatomic) NSArray      *dataSourceArray;
@property (strong, nonatomic) NSDictionary *dataSourceDictionary;

@end

@implementation FirstTableViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dataSourceArray = @[
                             @"FirstViewController",
                             @"SecondViewController",
                             @"ThirdViewController",
                             @"FourViewController",
                             @"FiveDemoViewController",
                             @"SixDemoViewController",
                             @"FirstViewController",
                             @"FirstViewController",
                             @"FirstViewController",
                             @"FirstViewController",
                             @"FirstViewController",
                             @"FirstViewController",
                             @"FirstViewController",
                             @"FirstViewController",
                             @"FirstViewController",
                             @"FirstViewController",
                             @"FirstViewController",
                             @"FirstViewController",
                             ];
    self.dataSourceDictionary =  @{
                                  @"0" : @"时钟转动有动画和没有动画",
                                  @"1" : @"关于segmentView的使用",
                                  @"2" : @"关于调用手机上已有的地图进行导航",
                                  @"3" : @"排序算法demo",
                                  @"4" : @"webView浏览图片",
                                  @"5" : @"ReactiveCocoa的练习",
                                  @"6" : @"时钟转动有动画和没有动画",
                                  @"7" : @"第二个demo",
                                  @"8" : @"时钟转动有动画和没有动画",
                                  @"9" : @"时钟转动有动画和没有动画",
                                  @"10" : @"第二个demo",
                                  @"11" : @"时钟转动有动画和没有动画",
                                  @"12" : @"第二个demo",
                                  @"13" : @"时钟转动有动画和没有动画",
                                  @"14" : @"第二个demo",
                                  @"15" : @"时钟转动有动画和没有动画",
                                  @"16" : @"第二个demo",
                                  @"17" : @"时钟转动有动画和没有动画",
                                  };
    
    [self addGrounpTablewDelegate:self];
    
    
// 对viewController的手势，可以操作navigationBar
//    self.navigationController.hidesBarsOnSwipe = YES;
//    self.navigationController.hidesBarsOnTap = YES;
//    self.navigationController.hidesBarsWhenVerticallyCompact = YES;
    
    
    [[UIBarButtonItem appearance]setBackButtonTitlePositionAdjustment:UIOffsetMake(0,-60)forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [[UIBarButtonItem appearance]setBackButtonTitlePositionAdjustment:UIOffsetMake(0,0)forBarMetrics:UIBarMetricsDefault];

    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)dealloc
{
    NSLog(@"内存释放--%@",NSStringFromClass([self class]) );
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


#pragma mark - Protocol Group
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSourceDictionary.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NSString *keyString = [NSString stringWithFormat:@"%ld", indexPath.section];
    cell.textLabel.text = self.dataSourceDictionary[keyString];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *indexString = [NSString stringWithFormat:@"%ld", indexPath.section];
    NSString *className = self.dataSourceArray[indexString.integerValue];
    Class class = NSClassFromString(className);
    id viewController = [[class alloc] init];
    if ([viewController respondsToSelector:@selector(setNumber:)]) {
        [viewController setValue:indexString forKey:@"number"];
    }
    [self.navigationController pushViewController:viewController animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return kNotFooterHeight;
    }
    return kHeader10Height;}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return kNotFooterHeight;

}


#pragma mark - UIResponder
#pragma mark - Private
#pragma mark - Custom

- (NSArray *)dataSourceArray{
    if (!_dataSourceArray) {
        _dataSourceArray = [NSArray array];
    }
    return _dataSourceArray;
}

- (NSDictionary *)dataSourceDictionary{
    if (!_dataSourceDictionary) {
        _dataSourceDictionary = [NSDictionary dictionary];
    }
    return _dataSourceDictionary;
}

@end
