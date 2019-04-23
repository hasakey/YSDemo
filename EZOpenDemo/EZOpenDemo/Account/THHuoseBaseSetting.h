//
//  THHuoseBaseSetting.h
//  ThinkHomeLib
//
//  Created by ThinkHome on 2017/8/21.
//  Copyright © 2017年 ThinkHome. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,SortingChange) {
    SortingChangeDevice,//设备优先
    SortingChangeArea,//区域优先
};

typedef NS_ENUM(NSInteger,SortingType) {
    SortingTypeCutom = 1,//自定义
    SortingTypeRoom = 2,//房间排序
    SortingTypeGroup = 3,//类别排序
    SortingTypeOpertaion = 4,//最近操作排序
};


@interface THHuoseBaseSetting : NSObject

//@property (strong,nonatomic) NSString *lockSetting;

@property (strong,nonatomic) NSString *location;

@property (assign,nonatomic) BOOL isConfig;

@property (strong,nonatomic) NSString *configAuth;

@property (strong,nonatomic) NSString *schemeID;

@property (assign,nonatomic) BOOL isFloorPlan;

@property (assign,nonatomic) SortingChange isSortingChange;

@property (assign,nonatomic) SortingType isSortingType;

@property (assign,nonatomic) BOOL isVoiceAuth;

@property (assign,nonatomic) BOOL isDefault;

@property (strong,nonatomic) NSString *isEnergyButtonShow;

@property (strong,nonatomic) NSString *energyButtonTopShow;

@property (strong,nonatomic) NSString *energyButtonBelowShow;

@property (strong,nonatomic) NSString *waterButtonShow;

@property (strong,nonatomic) NSString *messageNum;

@property (strong,nonatomic) NSString *currency;

@property (strong,nonatomic) NSString *isSetPowerPricing;

@property (strong,nonatomic) NSString *firstShowType;

@property (strong,nonatomic) NSString *firstShowTypeNo;

@property (assign,nonatomic) BOOL showSpecialPassword;

@property (strong,nonatomic) NSMutableDictionary *mathColorDict;

@property (retain,nonatomic) NSString *mLogo;

@property (retain,nonatomic) NSString *sLogo;

@property (retain,nonatomic) NSString *URL;

-(instancetype)initWithDict:(NSMutableDictionary *)dict;

-(NSMutableDictionary *)modelToDict;

@end
