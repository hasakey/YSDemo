//
//  THLoginHelper.m
//  ThinkHome
//
//  Created by ThinkHome on 2018/4/2.
//  Copyright © 2018年 ThinkHome. All rights reserved.
//

#import "THLoginHelper.h"
//#import "THAccountHelper.h"
//#import "THHouseHelper.h"
//#import "THCoorHelper.h"
//#import "THSenceHelper.h"
//#import "THDeviceHelper.h"
#import "THUserHelper.h"
//#import <CloudPushSDK/CloudPushSDK.h>
//#import "THUserHelper.h"
//#import "THWebSocket.h"
//#import "AppBaseInfo.h"
#import "MacroHeader.h"
#import "THAlertData.h"

@implementation THLoginHelper

+(void)loginAccount:(NSString *)account password:(NSString *)password success:(void (^)(int result,NSString * message))success fail:(void (^)(NSError *error))fail{
//    WS(weakSelf);
    [THUserHelper login:account password:password success:^(int result, NSString *message) {
        if(result == THUrlResposeSucess){
            //            [CloudPushSDK bindAccount:account withCallback:^(CloudPushCallbackResult *res) {
            //                NSLog(@"%@",res);
            //            }];
            success(THUrlResposeSucess,@"ChangeHouse");
        }else
            success(result,message);
    } fail:^(NSError *error) {
        fail(error);
    }];
}
//
//+(void)loginAccount:(NSString *)account password:(NSString *)password success:(void (^)(int result,NSString * message))success fail:(void (^)(NSError *error))fail{
//    WS(weakSelf);
//    [THUserHelper login:account password:password success:^(int result, NSString *message) {
//        if(result == THUrlResposeSucess){
////            [CloudPushSDK bindAccount:account withCallback:^(CloudPushCallbackResult *res) {
////                NSLog(@"%@",res);
////            }];
//            [weakSelf getUserInfo:success fail:fail];
//        }else
//            success(result,message);
//    } fail:^(NSError *error) {
//        fail(error);
//    }];
//}
//
//+(void)getUserInfo:(void (^)(int result,NSString * message))success fail:(void (^)(NSError *error))fail{
//    [THAccountHelper getAccountInfo:^(int result, THAccount *account, NSString *message) {
//        if(result == THUrlResposeSucess){
//            [self getHouseList:success fail:fail];
//        }else
//            success(result,message);
//    } fail:^(NSError *error) {
//        fail(error);
//    }];
//}
//
//+(void)getHouseList:(void (^)(int result,NSString * message))success fail:(void (^)(NSError *error))fail{
//    [THHouseHelper getHouseList:^(int result, NSArray *houseArr, NSString *message) {
//        if(result == THUrlResposeSucess){
//            if(houseArr.count == 1){
//                [self changeHouse:[houseArr[0] homeID] success:success fail:fail];
//            }else{
//                success(THUrlResposeSucess,@"ChangeHouse");
//            }
//        }else
//            success(result,message);
//    } fail:^(NSError *error) {
//        fail(error);
//    }];
//}
//
//+(void)changeHouse:(NSString *)homeID success:(void (^)(int result,NSString * message))success fail:(void (^)(NSError *error))fail{
//    [THHouseHelper getHouseInfo:homeID sucess:^(int result, THHouse *house, NSString *message) {
//        if(result == THUrlResposeSucess){
//            [[THWebSocket sharedInstance] closeSocket];
//            [[THWebSocket sharedInstance] beginSocket];
//            [self getRoomList:success fail:fail];
//        }else{
//            success(result,message);
//        }
//    } fail:^(NSError *error) {
//        fail(error);
//    }];
//}
//
//+(void)getRoomList:(void (^)(int result,NSString * message))success fail:(void (^)(NSError *error))fail{
//    [THRoomHelper getRoomList:^(int result, NSArray *roomArr, NSString *message) {
//        if(result == THUrlResposeSucess){
//            if([[AppBaseInfo sharedInstance].nowHouse.relation isEqualToString:@"2"])
//                [self getSenceList:success fail:fail];
//            else
//                [self getCoorList:success fail:fail];
//        }else{
//            success(result,message);
//        }
//    } fail:^(NSError *error) {
//        fail(error);
//    }];
//}
//
//+(void)getCoorList:(void (^)(int result,NSString * message))success fail:(void (^)(NSError *error))fail{
//    [THCoorHelper getCoorList:^(int result, NSArray *urlCoorArr, NSString *message) {
//        if(result == THUrlResposeSucess){
//            [self getSenceList:success fail:fail];
//        }else{
//            success(result,message);
//        }
//    } fail:^(NSError *error) {
//        fail(error);
//    }];
//}
//
//+(void)getSenceList:(void (^)(int result,NSString * message))success fail:(void (^)(NSError *error))fail{
//    [THSenceHelper getSenceList:0 typeNo:nil sucess:^(int result, NSArray *deviceArr, NSString *message) {
//        if(result == THUrlResposeSucess){
//            [self getFloorList:success fail:fail];
//        }else{
//            success(result,message);
//        }
//    } fail:^(NSError *error) {
//        fail(error);
//    }];
//}
//
//+(void)getFloorList:(void (^)(int result,NSString * message))success fail:(void (^)(NSError *error))fail{
//    [THRoomHelper getFloorInfo:^(int result, NSString *message) {
//        if(result == THUrlResposeSucess){
//            [self getDeviceList:success fail:fail];
//        }else{
//            success(result,message);
//        }
//    } fail:^(NSError *error) {
//        fail(error);
//    }];
//}
//
//+(void)getDeviceList:(void (^)(int result,NSString * message))success fail:(void (^)(NSError *error))fail{
//    [THDeviceHelper getDeviceList:^(int result, NSArray *deviceArr, NSString *message) {
//        success(result,message);
//    } fail:^(NSError *error) {
//        fail(error);
//    }];
//}

@end
