//
//  THHuoseBaseSetting.m
//  ThinkHomeLib
//
//  Created by ThinkHome on 2017/8/21.
//  Copyright © 2017年 ThinkHome. All rights reserved.
//

#import "THHuoseBaseSetting.h"
#import "LocalData.h"
#import "MacroHeader.h"
#import "AppBaseInfo.h"
#import "THKeyChain.h"
@implementation THHuoseBaseSetting

-(instancetype)initWithDict:(NSMutableDictionary *)dict{
    self = [super init];
    if(self){
        self.location = dict[@"location"];
        self.isConfig = [dict[@"isConfig"] isEqualToString:@"1"];
        self.configAuth = dict[@"configAuth"];
        self.schemeID = dict[@"schemeID"];
        self.isFloorPlan = [dict[@"isUseFloorPlan"] isEqualToString:@"1"];
        self.isSortingChange = [dict[@"isSortingChange"] isKindOfClass:NSNull.class] ? SortingChangeDevice:[dict[@"isSortingChange"] intValue];
        self.isSortingType = [dict[@"isSortingType"]  isKindOfClass:NSNull.class] ? SortingTypeCutom:[dict[@"isSortingType"] intValue];
        self.isVoiceAuth = [dict[@"isVoiceAuth"] isEqualToString:@"1"];
        self.isDefault = [dict[@"isDefault"] isEqualToString:@"1"];
        self.isEnergyButtonShow = dict[@"isEnergyButtonShow"];
        self.energyButtonTopShow = dict[@"energyButtonTopShow"];
        self.energyButtonBelowShow = dict[@"energyButtonBelowShow"];
        self.waterButtonShow = dict[@"waterButtonShow"];
        self.messageNum = dict[@"messageNum"];
        self.currency = dict[@"currency"];
        self.isSetPowerPricing = dict[@"isSetPowerPricing"];
        NSMutableDictionary *homeInfo = [THKeyChain load:NOW_HOUSE_DATA_KEY];
        NSMutableDictionary *homeDict = [[[LocalData sharedInstance] getData:NOW_ACCOUNT_INFO_DATA_KEY] objectForKey:homeInfo[@"homeID"]];
        self.firstShowType = homeDict[@"firstShowType"];
        self.firstShowTypeNo = homeDict[@"firstShowTypeNo"];
        self.showSpecialPassword = [homeDict[@"showSpecialPassword"] isEqualToString:@"1"];
        
        NSArray *arr = [NSMutableArray arrayWithObjects:[dict objectForKey:@"color_1"],[dict objectForKey:@"color_2"],[dict objectForKey:@"color_3"],[dict objectForKey:@"color_4"],[dict objectForKey:@"color_5"],[dict objectForKey:@"color_6"],[dict objectForKey:@"color_7"],[dict objectForKey:@"color_8"],[dict objectForKey:@"color_9"],[dict objectForKey:@"color_10"],[dict objectForKey:@"color_11"],[dict objectForKey:@"color_12"],[dict objectForKey:@"color_13"],[dict objectForKey:@"color_14"],[dict objectForKey:@"color_15"], nil];
        
        if([arr count] == 0)
            self.mathColorDict = nil;
        else
            self.mathColorDict =[NSMutableDictionary dictionaryWithObjects:@[@"",arr] forKeys:@[@"colorName",@"colorArr"]];
        self.mLogo = [[dict objectForKey:@"mLogo"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        self.sLogo = [[dict objectForKey:@"sLogo"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        self.URL = [[dict objectForKey:@"URL"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    return self;
}

-(NSMutableDictionary *)modelToDict{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    dict[@"location"] = self.location;
    dict[@"isConfig"] = self.isConfig ? @"1" : @"0";
    dict[@"configAuth"] = self.configAuth;
    dict[@"schemeID"] = self.schemeID;
    dict[@"isUseFloorPlan"] = self.isFloorPlan ? @"1" : @"0";
    dict[@"isSortingChange"] = [NSString stringWithFormat:@"%d",(int)self.isSortingChange];
    dict[@"isSortingType"] = [NSString stringWithFormat:@"%d",(int)self.isSortingType];
    dict[@"isVoiceAuth"] = self.isVoiceAuth ? @"1" : @"0";
    dict[@"isDefault"] = self.isDefault ? @"1" : @"0";
    dict[@"isEnergyButtonShow"] = self.isEnergyButtonShow;
    dict[@"energyButtonTopShow"] = self.energyButtonTopShow;
    dict[@"energyButtonBelowShow"] = self.energyButtonBelowShow;
    dict[@"waterButtonShow"] = [self.waterButtonShow isKindOfClass:[NSNull class]] ? @"" : self.waterButtonShow;
    dict[@"messageNum"] = self.messageNum;
    dict[@"currency"] = self.currency;
    dict[@"isSetPowerPricing"] = self.isSetPowerPricing;
    NSMutableArray *colorArr = [self.mathColorDict objectForKey:@"colorArr"];
    dict[@"color_1"] = colorArr[0];
    dict[@"color_2"] = colorArr[1];
    dict[@"color_3"] = colorArr[2];
    dict[@"color_4"] = colorArr[3];
    dict[@"color_5"] = colorArr[4];
    dict[@"color_6"] = colorArr[5];
    dict[@"color_7"] = colorArr[6];
    dict[@"color_8"] = colorArr[7];
    dict[@"color_9"] = colorArr[8];
    dict[@"color_10"] = colorArr[9];
    dict[@"color_11"] = colorArr[10];
    dict[@"color_12"] = colorArr[11];
    dict[@"color_13"] = colorArr[12];
    dict[@"color_14"] = colorArr[13];
    dict[@"color_15"] = colorArr[14];
    dict[@"mLogo"] = self.mLogo;
    dict[@"sLogo"] = self.sLogo;
    dict[@"URL"] = self.URL;
    return dict;
}
@end
