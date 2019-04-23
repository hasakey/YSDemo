//
//  THUser.m
//  ThinkHomeLib
//
//  Created by ThinkHome on 2017/8/4.
//  Copyright © 2017年 ThinkHome. All rights reserved.
//

#import "THUser.h"
@implementation THUser

-(instancetype)initWithDict:(NSMutableDictionary *)dict{
    self = [super init];
    if(self){
        self.account = dict[@"account"];
        self.password = dict[@"password"];
        self.accessToken = [[THAccessToken alloc]initWithDict:dict[@"accessToken"]];
        self.timeZone = dict[@"timeZone"];
        self.isTiYan = dict[@"isTiYan"];
    }
    return self;
}

-(NSMutableDictionary *)modelToDict{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    dict[@"account"] = self.account;
    dict[@"password"] = self.password;
    dict[@"accessToken"] = [self.accessToken modelToDict];
    dict[@"timeZone"] = self.timeZone;
    dict[@"isTiYan"] = self.isTiYan;
    return dict;
}

- (id)mutableCopyWithZone:(NSZone *)zone{
    THUser * model = [[self class] allocWithZone:zone];
    model.account = [self.account copy];
    model.password = [self.password copy];
    model.accessToken = [self.accessToken copy];
    model.timeZone = [self.timeZone copy];
    model.isTiYan = [self.isTiYan copy];
    return model;
}

@end
