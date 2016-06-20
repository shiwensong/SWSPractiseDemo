//
//  ViewController.m
//  MLTransitionNavigationController
//
//  Created by molon on 6/28/14.
//  Copyright (c) 2014 molon. All rights reserved.
//

#import "ViewController.h"
#import "TempViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "SWSToolsMethod.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "DetailViewController.h"
#import "TestViewController.h"

#import "CustomView.h"
#import "FirstTableViewController.h"

//必须自身是导航器的delegate
@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    
    
    
    
    // 测试在子线程中创建View
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//       
//        UIView *view = [[UIView alloc] init];
//        [self.view addSubview:view];
//        view.backgroundColor = [UIColor yellowColor];
//        view.frame = CGRectMake(100, 150, 200, 100);
//        
//    });
//    
//    
//    dispatch_queue_t queue = dispatch_queue_create("com.geelycar.loadactivity.loaddealersqueue", NULL);;
//    dispatch_async(queue, ^{
//        UIView *view = [[UIView alloc] init];
//        [self.view addSubview:view];
//        view.backgroundColor = [UIColor yellowColor];
//        view.frame = CGRectMake(100, 150, 200, 100);
//    });
    
   
    

    UIButton *button = [self.view viewWithTag:100];
    WS(ws);
    [button bk_whenTapped:^{
        
        FirstTableViewController *tableView = [[FirstTableViewController alloc] init];
        tableView.title = @"demo列表";
        tableView.hidesBottomBarWhenPushed = YES;
        [ws.navigationController pushViewController:tableView animated:YES];
        
    }];
    
    
    
    /*FIXME: 替换方法*/
    SEL orignSEL = @selector(touchesBegan:withEvent:);
    SEL newSEL = @selector(sWS_touchesBegan:withEvent:);
//    __SWSTransition_Swizzle([self class], orignSEL, newSEL);
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"哈哈哈哈h === %s", __func__);
    
    
    NSURL *url = [NSURL URLWithString:@"mqq://im/chat?chat_type=wpa&uin=291916410&version=1&src_type=web"];
    
    [[UIApplication sharedApplication] openURL:url];
    
    
//    DetailViewController *viewController = [[DetailViewController alloc] init];
//    viewController.title = @"详情";
//    [self.navigationController pushViewController:viewController animated:YES];
    
}

- (void)sWS_touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self sWS_touchesBegan:touches withEvent:event];
    NSLog(@" 执行的方法是： %s", __func__);
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark UINavigationControllerDelegate methods

- (IBAction)pressed:(id)sender {
    
    
    TestViewController *viewController = [[TestViewController alloc] init];
    viewController.title = @"test";
    [self.navigationController pushViewController:viewController animated:YES];
    
    
    // 测试 是否能跳转到QQ上面
//    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]) {
//        
//        NSString *qqNumberString = @"938039466";
//        NSString *urlString = [NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",qqNumberString];
//        NSURL *url = [NSURL URLWithString:urlString];
//        [[UIApplication sharedApplication] openURL:url];
//        
//        
//        NSLog(@"安装了QQ，可以跳转");
//    }else{
//        
//        NSLog(@"没有安装了QQ，不可以跳转");
//        
//        
//    }
    

    
    
    
//    TempViewController *vc = [[TempViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)selectImage:(id)sender {
    
    //测试在图片浏览器里能否正常执行
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.mediaTypes = @[(NSString *)kUTTypeImage];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}


#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //    UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];
    
    NSLog(@"得到了image");
    
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:^{
        NSLog(@"点击了取消选择图片按钮");
    }];
    
}




#pragma mark - IBAction 


@end
