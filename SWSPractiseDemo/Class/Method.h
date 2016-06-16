//
//  Method.h
//  MLTransitionNavigationController
//
//  Created by 施文松 on 16/6/16.
//  Copyright © 2016年 molon. All rights reserved.
//

#ifndef Method_h
#define Method_h

#define kSWS_String1Append(append,before) [NSString stringWithFormat:@"%@%@",append,before]
#define kSWS_String2Append(append,before) [NSString stringWithFormat:@"%@%@",append,before]
#define kSWS_String3Append(append,before,third) [NSString stringWithFormat:@"%@%@%@",append,before,third]

#define kSWS_String2XiaoShu(number) [NSString stringWithFormat:@"%.2f",number]
#define kSWS_String1XiaoShu(number) [NSString stringWithFormat:@"%.1f",number]
#define kSWS_String0XiaoShu(number) [NSString stringWithFormat:@"%.0f",number]

/*FIXME: Document目录*/
#define kDoucumentFile [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]


#endif /* Method_h */
