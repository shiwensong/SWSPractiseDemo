//
//  SWSToolsMethod.h
//  MLTransitionNavigationController
//
//  Created by 施文松 on 16/5/13.
//  Copyright © 2016年 molon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWSToolsMethod : NSObject

/*!
 *	静态就交换静态，实例方法就交换实例方法 (hook大法)
 *
 *	@param c				<#c description#>
 *	@param origSEL	<#origSEL description#>
 *	@param newSEL	<#newSEL description#>
 */
void __SWSTransition_Swizzle(Class c, SEL origSEL, SEL newSEL);


@end
