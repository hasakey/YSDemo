//
//  THKeyChain.h
//  ThinkHomeLib
//
//  Created by ThinkHome on 2017/8/11.
//  Copyright © 2017年 ThinkHome. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>
@interface THKeyChain : NSObject

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service;

+ (void)save:(NSString *)service data:(id)data;

+ (id)load:(NSString *)service;

+ (void)delete:(NSString *)service;

@end
