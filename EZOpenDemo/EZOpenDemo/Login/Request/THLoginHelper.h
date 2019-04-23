//
//  THLoginHelper.h
//  ThinkHome
//
//  Created by ThinkHome on 2018/4/2.
//  Copyright © 2018年 ThinkHome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THLoginHelper : NSObject

+(void)loginAccount:(NSString *)account password:(NSString *)password success:(void (^)(int result,NSString * message))success fail:(void (^)(NSError *error))fail;

//+(void)changeHouse:(NSString *)homeID success:(void (^)(int result,NSString * message))success fail:(void (^)(NSError *error))fail;

@end
