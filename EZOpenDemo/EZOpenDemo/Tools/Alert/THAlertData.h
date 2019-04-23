//
//  THAlertData.h
//  ThinkHomeLib
//
//  Created by ThinkHome on 15/11/16.
//  Copyright © 2015年 ThinkHome. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,THLocalError) {
    THLocalErrorTextCantNull = 180001,
    THLocalErrorMobileWrong = 180016,
    THLocalErrorAccountNotNil = 180021,
    TH_LocalError_Base_SameAccount = 180029,
    TH_LocalError_System_PermissionDenied = 999995,
};

typedef NS_ENUM(NSInteger,THUrlRespose) {
    THUrlResposeSucess = 10000,
    THUrlResposeErrorAcessTokenWrong = 10008,
    THUrlResposeErrorAccountNotExist = 10011,
    THUrlResposeErrorPasswordWrong = 10013,
    THUrlResposeErrorHouseNotExist = 10015,
    THUrlResposeErrorAddBySelf = 10020,
    THUrlResposeErrorAddByOther = 10021,
    THUrlResposeErrorOffline = 10022,
    THUrlResposeErrorCoorNotExist = 10023,
    THUrlResposeErrorLinkageNotExist = 10049,
    THUrlResposeErrorDynamicNotExist = 10053,
    THUrlResposeErrorDynamicAbnormal = 10054,
    THUrlResposeErrorCoorHasLinkage = 10076,
    THUrlResposeErrorMaintaining = 49997,
    THUrlResposeErrorFail = 99999,
};

@interface THAlertData : NSObject

/**
 *  本地错误异常
 *
 *  @param errNo 异常编号
 */
+(void)local_alert:(int)errNo;
/**
 *  网络错误异常
 *
 *  @param errNo 异常编号
 */
+(void)net_alert:(int)errNo;

+(void)local_alert_new:(int)errNo target:(id)target;

+(void)net_alert_new:(int)errNo target:(id)target;

+(void)alertWithText:(NSString *)text target:(id)target block:(void (^ )())blocks;

@end
