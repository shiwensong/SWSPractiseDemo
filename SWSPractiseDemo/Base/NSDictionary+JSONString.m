//
//  NSDictionary+JSONString.m
//  MakeMoney
//
//  Created by gitBurning on 15/9/22.
//  Copyright © 2015年 王坜. All rights reserved.
//

#import "NSDictionary+JSONString.h"

@implementation NSDictionary (JSONString)
-(NSString *)JsonToString
{
    NSData *data=[NSJSONSerialization  dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    NSString * body=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return body;
}
@end
