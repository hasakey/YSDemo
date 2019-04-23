//
//  AppBaseInfo.m
//  ThinkHomeLib
//
//  Created by ThinkHome on 16/4/26.
//  Copyright © 2016年 ThinkHome. All rights reserved.
//

#import "AppBaseInfo.h"
#import "THKeyChain.h"
#import "MacroHeader.h"
#import "LocalData.h"
@implementation AppBaseInfo

+(instancetype)sharedInstance{
    static AppBaseInfo *_appBaseData=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        _appBaseData = [[AppBaseInfo alloc]init];
        _appBaseData.netType = APPNetTypeWifi;
        _appBaseData.deviceToken = @"";
        _appBaseData.nowUser = [[THUser alloc] initWithDict:[THKeyChain load:NOW_ACCOUNT_DATA_KEY]];
        _appBaseData.accountInfo = [[THAccount alloc]initWithDict:[THKeyChain load:NOW_ACCOUNT_INFO_DATA_KEY]];
        _appBaseData.nowHouse = [[THHouse alloc]initWithDict:[THKeyChain load:NOW_HOUSE_DATA_KEY]];
        _appBaseData.houseSetting = [[THHuoseBaseSetting alloc] initWithDict:[[LocalData sharedInstance] getData:NOW_HOUSE_INFO_DATA_KEY]];
    });
    return _appBaseData;
}

@end
