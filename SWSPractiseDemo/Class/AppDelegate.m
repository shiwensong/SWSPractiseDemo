//
//  AppDelegate.m
//  MLTransitionNavigationController
//
//  Created by molon on 6/28/14.
//  Copyright (c) 2014 molon. All rights reserved.
//

#import "AppDelegate.h"
#import "UINavigationController+StatusBar.h"
#import "MLTransition.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    //一句话启用
    [MLTransition validatePanBackWithMLTransitionGestureRecognizerType:MLTransitionGestureRecognizerTypePan];
    
    
    //简单搞下demo颜色
    UIColor *navBarColor = [UIColor colorWithRed:0.063 green:0.263 blue:0.455 alpha:1.000];
    UIColor *navBarTintColor = [UIColor whiteColor];
    //导航栏
    [[UINavigationBar appearance]setBarTintColor:navBarColor];
    
    [[UINavigationBar appearance]setTintColor:navBarTintColor];
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSFontAttributeName] = [UIFont boldSystemFontOfSize:18.0f];
    attributes[NSForegroundColorAttributeName] = navBarTintColor;
    NSShadow *shadow = [NSShadow new];
    shadow.shadowColor = [UIColor clearColor];
    attributes[NSShadowAttributeName] = shadow;
    [[UINavigationBar appearance] setTitleTextAttributes:attributes];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
