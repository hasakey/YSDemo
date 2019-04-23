//
//  THUserHelper.h
//  ThinkHomeLib
//
//  Created by ThinkHome on 2017/8/4.
//  Copyright © 2017年 ThinkHome. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,VerifyCodeType) {
    VerifyCodeTypeRegister = 0,
    VerifyCodeTypeResetAccountPassword = 1,
    VerifyCodeTypeResetSystemPassword = 2,
    VerifyCodeTypeTransfer = 3,
    VerifyCodeTypeExperience = 4,
};

@interface THUserHelper : NSObject

+(void)login:(NSString *)account password:(NSString *)password success:(void (^)(int result,NSString * message))success fail:(void (^)(NSError *error))fail;

//+(void)registerAccount:(NSString *)account password:(NSString *)password verifyCode:(NSString *)verifyCode success:(void (^)(int result,NSString * message))success fail:(void (^)(NSError *error))fail;
//
//+(void)getVerifyCode:(VerifyCodeType)type account:(NSString *)account success:(void (^)(int result,NSString * message))success fail:(void (^)(NSError *error))fail;
//
//+(void)resetPassword:(NSString *)account password:(NSString *)password verifyCode:(NSString *)verifyCode success:(void (^)(int result,NSString * message))success fail:(void (^)(NSError *error))fail;
//
//+(void)changePassword:(NSString *)account password:(NSString *)password newPassword:(NSString *)newPassword success:(void (^)(int result,NSString * message))success fail:(void (^)(NSError *error))fail;
//
//+(void)logOut:(void (^)(int result,NSString * message))success fail:(void (^)(NSError *error))fail;
//
///**
// 注销账户信息（不通过网络请求，用于异常退出）
// */
//+(void)logOutWithoutUrl;
//
//+(void)deleteAccount:(NSString *)account success:(void (^)(int result,NSString * message))success fail:(void (^)(NSError *error))fail;
//
//+(int)checkSameAccount;
//
//+(void)feedback:(NSString *)feedBack sucess:(void (^)(int result,NSString * message))success fail:(void (^)(NSError *error))fail;
//
//+(void)setAutoChange:(BOOL)isAutoChange success:(void (^)(int result,NSString * message))success fail:(void (^)(NSError *error))fail;
//
//+(void)getNewestVersion:(void (^)(int result,NSMutableDictionary *versionInfo,NSString * message))success fail:(void (^)(NSError *error))fail;
//
//+(void)clearPushToken:(void (^)(int result,NSString *version,NSString * message))success fail:(void (^)(NSError *error))fail;
//
//+(void)building:(NSString *)phone getCode:(void (^)(int result,NSString *version,NSString * message))success fail:(void (^)(NSError *error))fail;
//
//+(void)building:(NSString *)phone code:(NSString *)code check:(void (^)(int result,NSString *version,NSString * message))success fail:(void (^)(NSError *error))fail;
//
//+(void)registerBuilding:(NSString *)phone code:(NSString *)code account:(NSString *)account password:(NSString *)password check:(void (^)(int result,NSString *version,NSString * message))success fail:(void (^)(NSError *error))fail;

@end
