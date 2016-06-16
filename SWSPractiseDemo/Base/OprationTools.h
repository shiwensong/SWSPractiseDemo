//
//  OprationTools.h
//  MLTransitionNavigationController
//
//  Created by 施文松 on 16/6/16.
//  Copyright © 2016年 molon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDictionary+JSONString.h"

@interface OprationTools : NSObject

/*!
 *	@brief 延迟调用的block
 *
 *	@param block	<#block description#>
 *	@param delay	<#delay description#>
 */
+(void)performBlock:(void (^)())block afterDelay:(NSTimeInterval)delay;


/*!
 *	@brief 主线程操作
 *
 *	@param block	<#block description#>
 */
+(void)oprationOnMainBlock:(void (^)())block;




@end
