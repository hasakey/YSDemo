//
//  THAccountUrl.m
//  EZOpenDemo
//
//  Created by will on 2019/4/3.
//  Copyright © 2019 will. All rights reserved.
//

#import "THAccountUrl.h"
//#import "THBaseUrl.h"
#import "LocalData.h"
#import "MacroHeader.h"

@implementation THAccountUrl

-(void)getTokenSuccess:(void (^)(id _Nonnull))success{
    
//    if ([[LocalData sharedInstance] getData:ACCESSTOKEN] != nil || ![[[LocalData sharedInstance] getData:ACCESSTOKEN] isEqualToString:@""]) {
//        success([[LocalData sharedInstance] getData:ACCESSTOKEN]);
//        return;
//    }
    
    //这个接口不能频繁请求
//    [[THBaseUrl sharedInstance] GET:@"account/token" params:[NSMutableDictionary dictionary] success:^(id  _Nonnull responseObject) {
//        int result = [[[responseObject objectForKey:@"result"] objectForKey:@"code"] intValue];
//        if (result == UrlErrorCodeSuccess) {
//            NSString *token = responseObject[@"data"][@"accessToken"];
//            [[LocalData sharedInstance] insertData:token withKey:ACCESSTOKEN];
//            success([[LocalData sharedInstance] getData:ACCESSTOKEN]);
//        }
//    } fail:^(NSError * _Nonnull error) {
//
//    }];
    

    
}

@end
