//
//  AppBaseInfo.h
//  ThinkHomeLib
//
//  Created by ThinkHome on 16/4/26.
//  Copyright © 2016年 ThinkHome. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "THUser.h"
#import "THAccount.h"
#import "THHouse.h"
#import "THHuoseBaseSetting.h"
typedef enum{
    APPNetTypeNone = 0,
    APPNetTypeWlan = 1,
    APPNetTypeWifi = 2
}APPNetType;

@interface AppBaseInfo : NSObject

@property (assign,nonatomic) APPNetType netType;

@property (strong,nonatomic) NSString *deviceToken;

@property (strong,nonatomic) THUser *nowUser;

@property (strong,nonatomic) THAccount *accountInfo;

@property (strong,nonatomic) THHouse *nowHouse;

@property (strong,nonatomic) THHuoseBaseSetting *houseSetting;

@property (strong,nonatomic) THUser *tempUser;

@property (strong,nonatomic) THAccount *tempAccountInfo;


+(instancetype)sharedInstance;

@end
