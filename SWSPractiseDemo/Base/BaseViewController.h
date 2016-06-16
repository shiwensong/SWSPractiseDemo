//
//  BaseViewController.h
//  CompanyCircle
//
//  Created by gitBurning on 15/10/17.
//  Copyright © 2015年 ZZ. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 *  @brief 侧滑类型
 */
typedef NS_ENUM(NSInteger,LateralSpreadsType) {
    /*!
     *  @brief 默认不能侧滑
     */
    LateralSpreadsType_IsNot = 0,
    /*!
     *  @brief 侧滑返回上一页
     */
    LateralSpreadsType_IsReturnToPreviousPage=1
    
};

@interface BaseViewController : UIViewController

/*!
 *  @brief 缓存 剪切图片
 */
@property (strong,nonatomic) NSMutableDictionary *cacheImage;

@property(assign,nonatomic) float offSetNav;

@property(copy,nonatomic) void(^baseOprationBlock)(id info);

/*!
 *  @brief 是否可以侧滑 返回上一页  1 ： 不能侧滑   2：侧滑返回上一页
 */
@property (assign,nonatomic) NSInteger isLateralSpreads;


-(void)baseConfigUI;

/**
 *  能否使用 IQ
 *
 *  @param can <#can description#>
 */
+(void)canUserIQ:(BOOL)can;


/*!
 *  @brief  配置 viewModel
 */
-(void)configViewControllerViewModel;

/*!
 *  @brief  增加 右边的 item
 *
 *  @param refrsh <#refrsh description#>
 */
-(void)addRightItemRefresh:(void(^)(id info))refrsh;


-(void)removeRightItemRefrsh;

-(void)setCanUserInterface:(BOOL)can;

/*!
 *  @brief  添加自定义左边的返回按钮
 *
 *  @param backBlcok <#backBlcok description#>
 */
- (void)addCustomLeftBarButton:(void(^)(id info))backBlcok ;


-(void)addCustomImageLeftBarbuttonWithImage:(UIImage*)image blcok:(void(^)(id info))backBlcok;

-(void)addRightItemTitle:(NSString*)title withBlcok:(void(^)(id info))refrsh;

-(NSMutableArray*)prediceteArray:(NSMutableArray*)array withPre:(NSPredicate*)pre;

@end
