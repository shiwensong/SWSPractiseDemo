//
//  Constant.h
//  MLTransitionNavigationController
//
//  Created by 施文松 on 16/6/16.
//  Copyright © 2016年 molon. All rights reserved.
//
// 保存常量的宏

#ifndef Constant_h
#define Constant_h


#define kNotFooterHeight 0.000001
#define kHeader20Height 20.0
#define kHeader10Height 10.0
#define kHeader30Height 30.0


/*FIXME: size*/
#define kFontSize17 17
#define kFontSize15 15
#define kFontSize13 13
#define kFontSize12 12
#define kFontSize11 11
#define kFontSize10 10
#define kFontSize9  9
#define kFontSize8  8





/*FIXME: keywindow */
#define kWindow [UIApplication sharedApplication].keyWindow




#endif /* Constant_h */


#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)
#else
#define NSLog(...)
#define debugMethod()

#endif
