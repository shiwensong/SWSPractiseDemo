//
//  BaseViewController.m
//  CompanyCircle
//
//  Created by gitBurning on 15/10/17.
//  Copyright © 2015年 ZZ. All rights reserved.
//

#import "BaseViewController.h"
@interface BaseViewController () <UIGestureRecognizerDelegate>
@property (copy,nonatomic) id refreshBlcok;

@property (copy,nonatomic) id customLeftBarButtonBackBlcok;

/*!
 *  @brief 右边图片 bar
 */
@property (copy,nonatomic) id customRightBarImageBlock;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.offSetNav = 64;
    self.automaticallyAdjustsScrollViewInsets = YES;
    //self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.view.backgroundColor = UIColorFromRGB(0xf9f9f9);
    
    
   // self.isLateralSpreads = LateralSpreadsType_IsReturnToPreviousPage;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
    
    
   // [self resetSwipeLeft:YES];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   // [self resetSwipeLeft:NO];

}
-(void)dealloc
{
    NSLog(@"内存释放--%@",NSStringFromClass([self class]) );
   // [self resetSwipeLeft:YES];

    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

-(void)resetSwipeLeft:(BOOL)isOpen{
    if (self.isLateralSpreads == LateralSpreadsType_IsNot ) {
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
        {
           // self.navigationController.interactivePopGestureRecognizer.enabled = isOpen;
            self.navigationController.interactivePopGestureRecognizer.delegate = nil;
        }
        
        NSLog(@"不允许侧滑");
    }
    else if(self.isLateralSpreads == LateralSpreadsType_IsReturnToPreviousPage){
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
            {
            //self.navigationController.interactivePopGestureRecognizer.enabled = YES;
            self.navigationController.interactivePopGestureRecognizer.delegate = self;
            }
    }
}

-(void)baseConfigUI
{
    
}
+(void)canUserIQ:(BOOL)can
{
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:can];
    
}

-(void)configViewControllerViewModel
{
    
}

-(void)addRightItemRefresh:(void (^)(id))refrsh
{

    UIBarButtonItem * bar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(selectFresh:)];
    self.navigationItem.rightBarButtonItem = bar;
    if (refrsh) {
        self.refreshBlcok = refrsh;
    }
    
}
-(void)addRightItemTitle:(NSString *)title withBlcok:(void (^)(id))refrsh
{
    if (title.length>0) {
        UIBarButtonItem *bar =[[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleDone target:self action:@selector(selectFresh:)];
        self.navigationItem.rightBarButtonItem = bar;
        if (refrsh) {
            self.refreshBlcok = refrsh;
        }
    }
   
}

-(void)removeRightItemRefrsh
{
    self.refreshBlcok = nil;
    self.navigationItem.rightBarButtonItem = nil;
}

-(void)selectFresh:(UIBarButtonItem*)bar
{
    void(^refrsh)(id info) = self.refreshBlcok;
    refrsh(bar);
}
-(void)setCanUserInterface:(BOOL)can
{
    self.view.userInteractionEnabled = can;
}

- (void)addCustomLeftBarButton:(void(^)(id info))backBlcok {
    
//    if (self.isLateralSpreads == LateralSpreadsType_IsNot ) {
//        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
//            {
//           // self.navigationController.interactivePopGestureRecognizer.enabled = NO;
//
//            self.navigationController.interactivePopGestureRecognizer.delegate = nil;
//            }
//
//        NSLog(@"不允许侧滑");
//    }else if(self.isLateralSpreads == LateralSpreadsType_IsReturnToPreviousPage){
//        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
//        {
//           // self.navigationController.interactivePopGestureRecognizer.enabled = YES;
//            self.navigationController.interactivePopGestureRecognizer.delegate = self;
//        }
//    }
    
    UIBarButtonItem *barButtonItem  = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"NavBack"] style:UIBarButtonItemStyleBordered target:self action:@selector(baseButtonActionOnClick:)];
    UIBarButtonItem * fix = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:@selector(baseButtonActionOnClick:)];
    fix.width = -10;
//    barButtonItem.imageInsets = UIEdgeInsetsMake(- 50, 0, 0,0 );
    self.customLeftBarButtonBackBlcok = backBlcok;
    self.navigationItem.leftBarButtonItems = @[fix,barButtonItem];
    self.navigationItem.hidesBackButton = YES;

}
-(void)addCustomImageLeftBarbuttonWithImage:(UIImage *)image blcok:(void (^)(id))backBlcok
{
    self.customRightBarImageBlock = backBlcok;
    
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(rightImageBar:)];
    self.navigationItem.rightBarButtonItem = bar;
    
    
}
-(void)rightImageBar:(UIBarButtonItem*)bar
{
    if (self.customRightBarImageBlock) {
        void(^refrsh)(id info) = self.customRightBarImageBlock;
        refrsh(nil);
    }
}

- (void)baseButtonActionOnClick:(UIButton *)sender{
    
    if (self.customLeftBarButtonBackBlcok) {
        void(^refrsh)(id info) = self.customLeftBarButtonBackBlcok;
        refrsh(nil);
    }
}


-(NSMutableArray*)prediceteArray:(NSMutableArray*)array withPre:(NSPredicate*)pre
{
    NSMutableArray *tempCopy = [array mutableCopy];
    [tempCopy filterUsingPredicate:pre];
    return tempCopy;
}


- (NSMutableDictionary *)cacheImage{
    if (!_cacheImage) {
        _cacheImage = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return _cacheImage;
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
