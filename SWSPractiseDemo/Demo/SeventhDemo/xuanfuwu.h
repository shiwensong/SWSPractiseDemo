//
//  xuanfuwu.h
//  SWSPractiseDemo
//
//  Created by 施文松 on 16/6/24.
//  Copyright © 2016年 shiwensong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DownLoadBlock) ();
@interface xuanfuwu : UIView



@property (nonatomic ,assign) CGPoint startPoint;//触摸起始点

@property (nonatomic ,assign) CGPoint endPoint;//触摸结束点

@property (nonatomic ,copy) DownLoadBlock downLoadBlock;
@end
