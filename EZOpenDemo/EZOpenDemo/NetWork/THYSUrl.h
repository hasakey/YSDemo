//
//  THYSUrl.h
//  EZOpenDemo
//
//  Created by will on 2019/4/3.
//  Copyright © 2019 will. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface THYSUrl : NSObject

-(void)setSSLStatusParam:(NSDictionary *)param Success:(void (^)(id responseObject))success;

-(void)setMobileStatusParam:(NSDictionary *)param Success:(void (^)(id responseObject))success;

-(void)setMicrophoneParam:(NSDictionary *)param Success:(void (^)(id responseObject))success;

-(void)getAlarmList:(NSDictionary *)param Success:(void (^)(id responseObject))success;


/**
 添加设备到账号下

 @param param 参数
 @param success 成功回调
 */
-(void)addDevice:(NSDictionary *)param Success:(void (^)(id responseObject))success;


/**
 关联设备

 @param param 参数
 @param success 成功回调
 */
-(void)relevanceDevice:(NSDictionary *)param Success:(void (^)(id responseObject))success;



@end

NS_ASSUME_NONNULL_END
