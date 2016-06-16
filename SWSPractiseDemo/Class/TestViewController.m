//
//  TestViewController.m
//  MLTransitionNavigationController
//
//  Created by 施文松 on 16/5/31.
//  Copyright © 2016年 molon. All rights reserved.
//

#import "TestViewController.h"
#import "UIImageView+WebCache.h"

@interface TestViewController ()

@end

@implementation TestViewController

int count = 0;

- (void)viewDidLoad {
    [super viewDidLoad];

    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 50, 300, 500)];
    [self.view addSubview:imageView];
    imageView.layer.cornerRadius = 5.0;
    imageView.layer.masksToBounds = YES;
    imageView.backgroundColor = [UIColor yellowColor];
    
    NSURL *url = [NSURL URLWithString:@"http://api.jiebiannews.com/Uploads/Picture/2016-05-30/574bfb17b7eaa.jpg"];
    UIImage *image = [UIImage imageNamed:@"b1"];
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
    uint64_t interval = (uint64_t)(1.0 * NSEC_PER_SEC); // 结束时间
    
    dispatch_source_set_timer(timer, start, interval, 0);
    

    // 设置回调
    dispatch_source_set_event_handler(timer, ^{
        NSLog(@"------------%@", [NSThread currentThread]);
        count++;
        
        //        if (count == 4) {
        //            // 取消定时器
        //            dispatch_cancel(self.timer);
        //            self.timer = nil;
        //        }
        
        
    });
    // 启动定时器
    dispatch_resume(timer);
    
//    dispatch_group_t group = dispatch_group_create();
//    
//    dispatch_queue_t queue = dispatch_queue_create(<#const char *label#>, <#dispatch_queue_attr_t attr#>)
//    
//    dispatch_async(group, ^{
//        [imageView sd_setImageWithURL:url placeholderImage:image options:SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//            
//        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            
//        }];
//    });
    
    
    
//    [imageView sd_setImageWithURL:url placeholderImage:image options:SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//        
//    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        
//    }];
   
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
