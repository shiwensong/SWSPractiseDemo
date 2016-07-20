//
//  ElevenDemoViewController.m
//  SWSPractiseDemo
//
//  Created by 施文松 on 16/7/18.
//  Copyright © 2016年 shiwensong. All rights reserved.
//

#import "ElevenDemoViewController.h"
#import "ElevenDemoDetailViewController.h"

@interface ElevenDemoViewController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ElevenDemoViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableView];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    NSDate *date = [NSDate date];
    cell.textLabel.text = [NSString stringWithFormat:@"%f", [date timeIntervalSince1970]];
    
    return cell;
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ElevenDemoDetailViewController *detailViewController = [[ElevenDemoDetailViewController alloc] init];
    detailViewController.title = @"详情页面";
    detailViewController.hidesBottomBarWhenPushed = YES;
    [detailViewController detalBackBlockValue:^(NSString *backString, id info) {
       
        NSLog(@"backString == %@", backString);
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//        cell.textLabel.text = [NSString stringWithFormat:@"%@ --- %@", cell.textLabel.text, backString];
        cell.textLabel.text = [NSString stringWithFormat:@"%@", backString];
        
//        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        [tableView ]
    }];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kNotFooterHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return kNotFooterHeight;
}

#pragma mark - UIResponder
#pragma mark - Private
#pragma mark - Custom

- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
        _tableView.tableFooterView = [[UIView alloc] init];
        
        WS(ws);
        
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(ws.view);
        }];
    }
    return _tableView;
}



@end
