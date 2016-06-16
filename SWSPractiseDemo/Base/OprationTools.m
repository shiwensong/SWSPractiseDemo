//
//  OprationTools.m
//  MLTransitionNavigationController
//
//  Created by 施文松 on 16/6/16.
//  Copyright © 2016年 molon. All rights reserved.
//

#import "OprationTools.h"

@implementation OprationTools


+(void)performBlock:(void (^)())block afterDelay:(NSTimeInterval)delay{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}


+(void)oprationOnMainBlock:(void (^)())block
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (block) {
            block();
        }
    });
}



@end
