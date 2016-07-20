//
//  ElevenDemoDetailViewController.h
//  SWSPractiseDemo
//
//  Created by 施文松 on 16/7/19.
//  Copyright © 2016年 shiwensong. All rights reserved.
//

#import "BaseViewController.h"

@interface ElevenDemoDetailViewController : BaseViewController

- (void)detalBackBlockValue:(void(^)(NSString *backString, id info))backBlock;

@end
