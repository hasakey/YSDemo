//
//  AppDelegate.m
//  EZOpenDemo
//
//  Created by will on 2019/4/2.
//  Copyright © 2019 will. All rights reserved.
//




#import "AppDelegate.h"
#import <EZOpenSDKFramework/EZOpenSDKFramework.h>
#import "THNavigationViewController.h"
#import "MacroHeader.h"
#import "MainVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [EZOpenSDK setDebugLogEnable:NO];
    [EZOpenSDK initLibWithAppKey:EZOpenAppKey];
    [self setRootView];
    return YES;
}

#pragma mark - Pravite Method
-(void)setRootView{
    MainVC *vc = [[MainVC alloc]init];
    THNavigationViewController *mainNavc=[[THNavigationViewController alloc]initWithRootViewController:vc];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = mainNavc;
}


@end
