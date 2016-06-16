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

    self.dataSourceArray = @[@"FirstViewController",@"FirstViewController"];
    self.dataSourceDictionary =  @{
                                  @"0" : @"时钟转动有动画和没有动画",
                                  @"1" : @"第二个demo",
                                  };
    
    [self addGrounpTablewDelegate:self];
    
    
    
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hehe"];
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
    [viewController setValue:indexString forKey:@"number"];
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
