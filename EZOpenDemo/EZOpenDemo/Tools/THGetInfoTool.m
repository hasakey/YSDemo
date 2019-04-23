//
//  THGetInfoTool.m
//  EZOpenDemo
//
//  Created by will on 2019/4/3.
//  Copyright © 2019 will. All rights reserved.
//

#import "THGetInfoTool.h"
#include <sys/param.h>
#include <sys/mount.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <sys/utsname.h>

@implementation THGetInfoTool

+(NSString *)getWifiName
{
    NSString *wifiName = nil;
    
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    
    if (!wifiInterfaces) {
        return nil;
    }
    
    NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
    
    for (NSString *interfaceName in interfaces) {
        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
        
        if (dictRef) {
            NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
            NSLog(@"network info -> %@", networkInfo);
            wifiName = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];
            
            CFRelease(dictRef);
        }
    }
    
    CFRelease(wifiInterfaces);
    return wifiName;
}

@end
