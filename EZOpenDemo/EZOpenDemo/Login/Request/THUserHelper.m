//
//  THUserHelper.m
//  ThinkHomeLib
//
//  Created by ThinkHome on 2017/8/4.
//  Copyright © 2017年 ThinkHome. All rights reserved.
//

#import "THUserHelper.h"
#import "MyMD5.h"
#import "MacroHeader.h"
#import "AppBaseInfo.h"
#import "THUrl.h"
#import "THAlertData.h"
//#import "THUrlHelper.h"
//#import "THAccessToken.h"
//#import "THUser.h"
#import "THKeyChain.h"
//#import "SqliteOperater.h"
//#import "LocalData.h"
//#import "THWebSocket.h"
@implementation THUserHelper

+(void)login:(NSString *)account password:(NSString *)password success:(void (^)(int result,NSString * message))success fail:(void (^)(NSError *error))fail{
    NSDictionary *bodyDict =  @{
                                @"authentication":@{
                                        @"userAccount": account,
                                        @"password": [[MyMD5 md5:[NSString stringWithFormat:@"%@%@",[account lowercaseString],password]]uppercaseString]
                                        },
                                @"clientToken":@{
                                        @"type": @"1",
                                        @"version":APP_TOKEN_VERSION,
                                        @"token": [AppBaseInfo sharedInstance].deviceToken,
                                        @"platform":@"1"
                                        }
                                };
    [[THUrl sharedInstance] POST:@"user/login" params:bodyDict success:^(id responseObject) {
        int result = [[[responseObject objectForKey:@"result"] objectForKey:@"code"] intValue];
        NSDictionary *bodyDict = [[responseObject objectForKey:@"result"] objectForKey:@"body"];
        if(result == THUrlResposeSucess){
            THAccessToken *token = [[THAccessToken alloc]init];
            token.accesstoken = [bodyDict objectForKey:@"accessToken"];
            token.expire = [[bodyDict objectForKey:@"expirationTime"] intValue];
            THUser *user=[[THUser alloc]init];
            user.account = [account lowercaseString];
            user.password = password;
            user.timeZone = [[NSTimeZone systemTimeZone] name];
            user.accessToken = token;
            [AppBaseInfo sharedInstance].tempUser = [AppBaseInfo sharedInstance].nowUser;
            [AppBaseInfo sharedInstance].nowUser = user;
            [THKeyChain save:NOW_ACCOUNT_DATA_KEY data:[[AppBaseInfo sharedInstance].nowUser modelToDict]];
            
            
        }
        success(result,[[responseObject objectForKey:@"result"] objectForKey:@"msg"]);
    } fail:^(NSError *error) {
        fail(error);
    }];
}

//+(void)registerAccount:(NSString *)account password:(NSString *)password verifyCode:(NSString *)verifyCode success:(void (^)(int result,NSString * message))success fail:(void (^)(NSError *error))fail{
//    NSDictionary *bodyDict =  @{
//                                @"authentication":@{
//                                        @"userAccount": account,
//                                        @"password": [[MyMD5 md5:[NSString stringWithFormat:@"%@%@",[account lowercaseString],password]]uppercaseString],
//                                        @"verifyCode":verifyCode,
//                                        },
//                                @"clientToken":@{
//                                        @"type": @"1",
//                                        @"version":AppToeknVersion,
//                                        @"token": [AppBaseInfo sharedInstance].deviceToken,
//                                        @"platform":@"1"
//                                        }
//                                };
//    [[THUrl sharedInstance] POST:@"user/register" params:bodyDict success:^(id responseObject) {
//        int result = [[[responseObject objectForKey:@"result"] objectForKey:@"code"] intValue];
//        success(result,[[responseObject objectForKey:@"result"] objectForKey:@"msg"]);
//    } fail:^(NSError *error) {
//        fail(error);
//    }];
//}
//
//+(void)getVerifyCode:(VerifyCodeType)type account:(NSString *)account success:(void (^)(int result,NSString * message))success fail:(void (^)(NSError *error))fail{
//    NSDictionary *bodyDict =  @{
//                                @"authentication":@{
//                                        @"userAccount": account,
//                                        },
//                                @"captcha":@{
//                                        @"type":[NSString stringWithFormat:@"%d",(int)type],
//                                        }
//                                };
//    [[THUrl sharedInstance] POST:@"user/sendCaptcha" params:bodyDict success:^(id responseObject) {
//        int result = [[[responseObject objectForKey:@"result"] objectForKey:@"code"] intValue];
//        success(result,[[responseObject objectForKey:@"result"] objectForKey:@"msg"]);
//    } fail:^(NSError *error) {
//        fail(error);
//    }];
//}
//
//+(void)resetPassword:(NSString *)account password:(NSString *)password verifyCode:(NSString *)verifyCode success:(void (^)(int result,NSString * message))success fail:(void (^)(NSError *error))fail{
//    NSDictionary *bodyDict =  @{
//                                @"authentication":@{
//                                        @"userAccount": account,
//                                        @"password": [[MyMD5 md5:[NSString stringWithFormat:@"%@%@",[account lowercaseString],password]]uppercaseString ],
//                                        @"verifyCode":verifyCode,
//                                        },
//                                };
//    [[THUrl sharedInstance] POST:@"user/resetPassword" params:bodyDict success:^(id responseObject) {
//        int result = [[[responseObject objectForKey:@"result"] objectForKey:@"code"] intValue];
//        success(result,[[responseObject objectForKey:@"result"] objectForKey:@"msg"]);
//    } fail:^(NSError *error) {
//        fail(error);
//    }];
//}
//
//+(void)changePassword:(NSString *)account password:(NSString *)password newPassword:(NSString *)newPassword success:(void (^)(int result,NSString * message))success fail:(void (^)(NSError *error))fail{
//    NSDictionary *bodyDict =  @{
//                                @"accessToken":[AppBaseInfo sharedInstance].nowUser.accessToken.accesstoken,
//                                @"authentication":@{
//                                        @"password": [[MyMD5 md5:[NSString stringWithFormat:@"%@%@",[[AppBaseInfo sharedInstance].nowUser.account lowercaseString],password]]uppercaseString],
//                                        @"newPassword":[[MyMD5 md5:[NSString stringWithFormat:@"%@%@",[[AppBaseInfo sharedInstance].nowUser.account lowercaseString],newPassword]]uppercaseString],
//                                        },
//                                };
//    [[THUrl sharedInstance] POST:@"user/changePassword" params:bodyDict success:^(id responseObject) {
//        int result = [[[responseObject objectForKey:@"result"] objectForKey:@"code"] intValue];
//        NSDictionary *bodyDict = [[responseObject objectForKey:@"result"] objectForKey:@"body"];
//        if(result == THUrlResposeSucess){
//            THAccessToken *token = [[THAccessToken alloc]init];
//            token.accesstoken = [bodyDict objectForKey:@"accessToken"];
//            token.expire = [[bodyDict objectForKey:@"expirationTime"] intValue];
//            [AppBaseInfo sharedInstance].nowUser.accessToken = token;
//            [AppBaseInfo sharedInstance].nowUser.password = newPassword;
//            [THKeyChain save:NowUserDataKey data:[[AppBaseInfo sharedInstance].nowUser modelToDict]];
//        }
//        success(result,[[responseObject objectForKey:@"result"] objectForKey:@"msg"]);
//    } fail:^(NSError *error) {
//        fail(error);
//    }];
//}
//
//+(void)logOut:(void (^)(int result,NSString * message))success fail:(void (^)(NSError *error))fail{
//    NSDictionary *bodyDict =  @{
//                                @"accessToken": [AppBaseInfo sharedInstance].nowUser.accessToken.accesstoken,
//                                @"clientToken":@{
//                                        @"type": @"1",
//                                        @"version":AppToeknVersion,
//                                        @"token": [AppBaseInfo sharedInstance].deviceToken
//                                        }
//                                };
//    [[THUrl sharedInstance] POST:@"user/logout" params:bodyDict success:^(id responseObject) {
//        int result = [[[responseObject objectForKey:@"result"] objectForKey:@"code"] intValue];
//        if(result == THUrlResposeSucess){
//            [self logOutWithoutUrl];
//        }
//        success(result,[[responseObject objectForKey:@"result"] objectForKey:@"msg"]);
//    } fail:^(NSError *error) {
//        fail(error);
//    }];
//}
//
//+(void)logOutWithoutUrl{
//    NSMutableArray *accountArr = [[THKeyChain load:AccountListDataKey] mutableCopy];
//    int index = [THUserHelper checkSameAccount];
//    if(index != -1)
//        [accountArr removeObjectAtIndex:index];
//    [THKeyChain save:AccountListDataKey data:accountArr];
//
//    [AppBaseInfo sharedInstance].nowHouse = nil;
//    [AppBaseInfo sharedInstance].nowUser = nil;
//    [AppBaseInfo sharedInstance].accountInfo = nil;
//    [THKeyChain delete:NowUserDataKey];
//    [THKeyChain delete:NowHouseDataKey];
//    [THKeyChain delete:AccountInfoDataKey];
//    [[THWebSocket sharedInstance] closeSocket];
//    [[SqliteOperater sharedInstance] cleanAllSqlite];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"UserLogout" object:nil];
//}
//
//+(void)deleteAccount:(NSString *)account success:(void (^)(int result,NSString * message))success fail:(void (^)(NSError *error))fail{
//    NSDictionary *bodyDict =  @{
//                                @"authentication":@{
//                                        @"userAccount":account,
//                                        },
//                                @"clientToken":@{
//                                        @"type": @"1",
//                                        @"version":AppToeknVersion,//1是分发  2是正式
//                                        @"token": [AppBaseInfo sharedInstance].deviceToken
//                                        }
//                                };
//    [[THUrl sharedInstance] POST:@"user/logoutByMobilePhone" params:bodyDict success:^(id responseObject) {
//        int result = [[[responseObject objectForKey:@"result"] objectForKey:@"code"] intValue];
//        if(result == THUrlResposeSucess){
//            NSMutableArray *accountArr = [[THKeyChain load:AccountListDataKey] mutableCopy];
//            int index = [THUserHelper checkSameAccount];
//            if(index != -1)
//                [accountArr removeObjectAtIndex:index];
//            [THKeyChain save:AccountListDataKey data:accountArr];
//        }
//        success(result,[[responseObject objectForKey:@"result"] objectForKey:@"msg"]);
//    } fail:^(NSError *error) {
//        fail(error);
//    }];
//}
//
//+(int)checkSameAccount{
//    NSMutableArray *accountArr = [THKeyChain load:AccountListDataKey];
//    for(int i = 0 ; i < [accountArr count]; i++){
//        NSMutableDictionary *accountDict = [accountArr objectAtIndex:i];
//        if([[accountDict objectForKey:@"account"] isEqualToString:[AppBaseInfo sharedInstance].nowUser.account]){
//            return i;
//        }
//    }
//    return -1;
//}
//
//
//+(void)feedback:(NSString *)feedBack sucess:(void (^)(int result,NSString * message))success fail:(void (^)(NSError *error))fail{
//    NSDictionary *bodyDict =  @{
//                                @"accessToken":[AppBaseInfo sharedInstance].nowUser.accessToken.accesstoken,
//                                @"feedback":@{
//                                        @"info": feedBack,
//                                        }
//                                };
//    [[THUrl sharedInstance] POST:@"user/feedback" params:bodyDict success:^(id responseObject) {
//        int result = [[[responseObject objectForKey:@"result"] objectForKey:@"code"] intValue];
//        success(result,[[responseObject objectForKey:@"result"] objectForKey:@"msg"]);
//    } fail:^(NSError *error) {
//        fail(error);
//    }];
//}
//
//+(void)setAutoChange:(BOOL)isAutoChange success:(void (^)(int result,NSString * message))success fail:(void (^)(NSError *error))fail{
//    NSDictionary *bodyDict =  @{
//                                @"accessToken":[AppBaseInfo sharedInstance].nowUser.accessToken.accesstoken,
//                                @"houseIsAutoSwitch":isAutoChange ? @"1" : @"0",
//                                };
//    [[THUrl sharedInstance] POST:@"user/setHouseAutoSwitch" params:bodyDict success:^(id responseObject) {
//        int result = [[[responseObject objectForKey:@"result"] objectForKey:@"code"] intValue];
//        [AppBaseInfo sharedInstance].accountInfo.houseIsAutoSwitch = isAutoChange ? @"1" : @"0";
//        [THKeyChain save:AccountInfoDataKey data:[[AppBaseInfo sharedInstance].accountInfo modelToDict]];
//        success(result,[[responseObject objectForKey:@"result"] objectForKey:@"msg"]);
//    } fail:^(NSError *error) {
//        fail(error);
//    }];
//}
//
//+(void)getNewestVersion:(void (^)(int result,NSDictionary *versionInfo,NSString * message))success fail:(void (^)(NSError *error))fail{
//    NSDictionary *bodyDict =  @{
//
//                                };
//    [[THUrl sharedInstance] POST:@"system/getClientVersion" params:bodyDict success:^(id responseObject) {
//        int result = [[[responseObject objectForKey:@"result"] objectForKey:@"code"] intValue];
//        NSDictionary *bodyDict = [[responseObject objectForKey:@"result"] objectForKey:@"body"];
//        success(result,bodyDict,[[responseObject objectForKey:@"result"] objectForKey:@"msg"]);
//    } fail:^(NSError *error) {
//        fail(error);
//    }];
//}
//
//+(void)clearPushToken:(void (^)(int result,NSString *version,NSString * message))success fail:(void (^)(NSError *error))fail{
//    NSDictionary *bodyDict =  @{
//                                @"clientToken":@{
//                                        @"type": @"1",
//                                        @"version":AppToeknVersion,
//                                        @"token": [AppBaseInfo sharedInstance].deviceToken
//                                        }
//                                };
//    [[THUrl sharedInstance] POST:@"user/clearPushTokenMapping" params:bodyDict success:^(id responseObject) {
//        int result = [[[responseObject objectForKey:@"result"] objectForKey:@"code"] intValue];
//        success(result,bodyDict[@"version"],[[responseObject objectForKey:@"result"] objectForKey:@"msg"]);
//    } fail:^(NSError *error) {
//        fail(error);
//    }];
//}
//
//+(void)building:(NSString *)phone getCode:(void (^)(int result,NSString *version,NSString * message))success fail:(void (^)(NSError *error))fail{
//    NSDictionary *bodyDict =  @{
//                                @"account":@{
//                                        @"phone": phone,
//                                        }
//                                };
//    [[THUrl sharedInstance] POST:@"hac/sendCaptchaForHAC" params:bodyDict success:^(id responseObject) {
//        int result = [[[responseObject objectForKey:@"result"] objectForKey:@"code"] intValue];
//        success(result,bodyDict[@"version"],[[responseObject objectForKey:@"result"] objectForKey:@"msg"]);
//    } fail:^(NSError *error) {
//        fail(error);
//    }];
//}
//
//+(void)building:(NSString *)phone code:(NSString *)code check:(void (^)(int result,NSString *version,NSString * message))success fail:(void (^)(NSError *error))fail{
//    NSDictionary *bodyDict =  @{
//                                @"account":@{
//                                        @"phone": phone,
//                                        @"code":code,
//                                        }
//                                };
//    [[THUrl sharedInstance] POST:@"hac/checkCode" params:bodyDict success:^(id responseObject) {
//        int result = [[[responseObject objectForKey:@"result"] objectForKey:@"code"] intValue];
//        success(result,bodyDict[@"version"],[[responseObject objectForKey:@"result"] objectForKey:@"msg"]);
//    } fail:^(NSError *error) {
//        fail(error);
//    }];
//}
//
//+(void)registerBuilding:(NSString *)phone code:(NSString *)code account:(NSString *)account password:(NSString *)password check:(void (^)(int result,NSString *version,NSString * message))success fail:(void (^)(NSError *error))fail{
//    NSDictionary *bodyDict =  @{
//                                @"account":@{
//                                        @"virtualAccount":account,
//                                        @"password": [[MyMD5 md5:[NSString stringWithFormat:@"%@%@",[phone lowercaseString],password]]uppercaseString ],
//                                        @"phone": phone,
//                                        @"code":code,
//                                        }
//                                };
//    [[THUrl sharedInstance] POST:@"hac/registerAndTransfer" params:bodyDict success:^(id responseObject) {
//        int result = [[[responseObject objectForKey:@"result"] objectForKey:@"code"] intValue];
//        success(result,bodyDict[@"version"],[[responseObject objectForKey:@"result"] objectForKey:@"msg"]);
//    } fail:^(NSError *error) {
//        fail(error);
//    }];
//}

@end
