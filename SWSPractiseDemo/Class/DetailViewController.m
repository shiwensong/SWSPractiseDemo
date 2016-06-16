//
//  DetailViewController.m
//  MLTransitionNavigationController
//
//  Created by 施文松 on 16/5/18.
//  Copyright © 2016年 molon. All rights reserved.
//

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;


#import "DetailViewController.h"
#import "UIImageView+WebCache.h"

static NSString *cellID = @"cellID";


@interface DetailViewController () <UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.delegate = self;
    NSString *htmlString = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"index.html" ofType:@""] encoding:NSUTF8StringEncoding error:nil];
    
    // 获取当前应用的根目录
//    NSString *path = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"html"];
//    NSURL *baseURL = [NSURL fileURLWithPath:path];
    
    NSString *filePath = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:filePath];

    
    // 通过baseURL的方式加载的HTML
    // 可以在HTML内通过相对目录的方式加载js,css,img等文件
    [webView loadHTMLString:htmlString baseURL:baseURL];
    
//    [webView loadHTMLString:htmlString baseURL:nil];
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    
    
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    
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

#pragma mark - LifeCycle


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
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld=======%ld", indexPath.section, indexPath.row];
    UIImage *image = [UIImage imageNamed:@"IMG_2079"];
    NSURL *url = [NSURL URLWithString:@"http://imgsrc.baidu.com/baike/pic/item/0b7b02087bf40ad11b2b5a51542c11dfa8ecceb1.jpg"];
    [cell.imageView sd_setImageWithURL:url placeholderImage:image];
    
    [cell.imageView sd_setImageWithURL:url placeholderImage:image options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        NSLog(@"下载进度为 : == %f", (float)receivedSize/expectedSize);
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        UIImage *newImage = image;
        
        
    }];
    
    
    return cell;
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    dispatch_queue_t queue = dispatch_queue_create("com.geelycar.loadactivity.loaddealersqueue", NULL);;
    dispatch_async(queue, ^{
        
        [self.tableView reloadData];

        
        UIView *view = [[UIView alloc] init];
        [cell addSubview:view];
        view.backgroundColor = [UIColor yellowColor];
        view.frame = cell.bounds;
        
        [self.tableView reloadData];
    });
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0000001;
}

#pragma mark - UIResponder
#pragma mark - Private
#pragma mark - Custom


- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
        _tableView.tableFooterView = [[UIView alloc] init];
        
        
        _tableView.frame = self.view.bounds;
    }
    return _tableView;
}



@end

