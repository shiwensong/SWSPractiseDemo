//
//  NineDemoViewController.m
//  SWSPractiseDemo
//
//  Created by 施文松 on 16/6/30.
//  Copyright © 2016年 shiwensong. All rights reserved.
//

#import "NineDemoViewController.h"
//#import "ZipArchive.h"

@interface NineDemoViewController () <SSZipArchiveDelegate, NSURLSessionDownloadDelegate>

@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;

@property (strong, nonatomic)  UIImageView *imageView;

@end

@implementation NineDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.title.length > 0 ) {
        self.title = @"zip解压的demo";
    }

//    [self downFileFromServer];
    
    self.imageView = [[UIImageView alloc] init];
    [self.view addSubview:self.imageView];
    WS(ws);
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view);
    }];
    

    [self downloadTask];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 下载(GET)
- (void)downloadTask
{
    // 1. URL
    NSURL *url = [NSURL URLWithString:@"http://localhost/itcast/images/head1.png"];
    
    // 2. Request
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:2.0];
    
    // 3. Session
    NSURLSession *session = [NSURLSession sharedSession];
    
    // 4. download
    [[session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        // 下载的位置,沙盒中tmp目录中的临时文件,会被及时删除
        NSLog(@"下载完成 %@ %@", location, [NSThread currentThread]);
        /**
         document       备份,下载的文件不能放在此文件夹中
         cache          缓存的,不备份,重新启动不会被清空,如果缓存内容过多,可以考虑新建一条线程检查缓存目录中的文件大小,自动清理缓存,给用户节省控件
         tmp            临时,不备份,不缓存,重新启动iPhone,会自动清空
         */
        // 直接通过文件名就可以加载图像,图像会常驻内存,具体的销毁有系统负责
        // [UIImage imageNamed:@""];
        dispatch_async(dispatch_get_main_queue(), ^{
            // 从网络下载下来的是二进制数据
            NSData *data = [NSData dataWithContentsOfURL:location];
            // 这种方式的图像会自动释放,不占据内存,也不需要放在临时文件夹中缓存
            // 如果用户需要,可以提供一个功能,保存到用户的相册即可
            UIImage *image = [UIImage imageWithData:data];
            
            self.imageView.image = image;
        });
    }] resume];
    
    //    [task resume];
}





- (void)downFileFromServer{
    
    NSString *DOWN_URL = @"https://codeload.github.com/shiwensong/BCQRcode/zip/master";
    //远程地址
    NSURL *URL = [NSURL URLWithString:DOWN_URL];
    //默认配置
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    //AFN3.0+基于封住URLSession的句柄
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    //请求
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    __autoreleasing NSProgress *progress = [NSProgress currentProgress];
    
    [manager downloadTaskWithRequest:request progress:&progress destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        //- block的返回值, 要求返回一个URL, 返回的这个URL就是文件的位置的路径
        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *path = [cachesPath stringByAppendingPathComponent:response.suggestedFilename];
        return [NSURL fileURLWithPath:path];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        //设置下载完成操作
        // filePath就是你下载文件的位置，你可以解压，也可以直接拿来使用
        NSString *imgFilePath = [filePath path];// 将NSURL转成NSString
        NSLog(@"imgFilePath = %@",imgFilePath);
        NSArray *documentArray =  NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString *path = [[documentArray lastObject] stringByAppendingPathComponent:@"Preferences"];
        [self releaseZipFilesWithUnzipFileAtPath:imgFilePath Destination:path];

    }];
    
    [_downloadTask resume];

    
//    //下载Task操作
//    _downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
//        // 下载进度
//    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
//        //- block的返回值, 要求返回一个URL, 返回的这个URL就是文件的位置的路径
//        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//        NSString *path = [cachesPath stringByAppendingPathComponent:response.suggestedFilename];
//        return [NSURL fileURLWithPath:path];
//    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
//        //设置下载完成操作
//        // filePath就是你下载文件的位置，你可以解压，也可以直接拿来使用
//        NSString *imgFilePath = [filePath path];// 将NSURL转成NSString
//        NSLog(@"imgFilePath = %@",imgFilePath);
//        NSArray *documentArray =  NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
//        NSString *path = [[documentArray lastObject] stringByAppendingPathComponent:@"Preferences"];
//        [self releaseZipFilesWithUnzipFileAtPath:imgFilePath Destination:path];
//    }];
//    [_downloadTask resume];
}
// 解压
- (void)releaseZipFilesWithUnzipFileAtPath:(NSString *)zipPath Destination:(NSString *)unzipPath{
    NSError *error;
    
    if ([SSZipArchive unzipFileAtPath:zipPath toDestination:unzipPath overwrite:YES password:nil error:&error delegate:self]) {
        NSLog(@"success");
        NSLog(@"unzipPath = %@",unzipPath);
    }else {
        NSLog(@"%@",error);
    }
}

#pragma mark - SSZipArchiveDelegate
- (void)zipArchiveWillUnzipArchiveAtPath:(NSString *)path zipInfo:(unz_global_info)zipInfo {
    NSLog(@"将要解压。");
}
- (void)zipArchiveDidUnzipArchiveAtPath:(NSString *)path zipInfo:(unz_global_info)zipInfo unzippedPath:(NSString *)unzippedPat uniqueId:(NSString *)uniqueId {
    NSLog(@"解压完成！");
}

@end
