//
//  THAccessToken.m
//  ThinkHomeLib
//
//  Created by ThinkHome on 2017/8/4.
//  Copyright © 2017年 ThinkHome. All rights reserved.
//

#import "THAccessToken.h"

@implementation THAccessToken

-(instancetype)initWithDict:(NSMutableDictionary *)dict{
    self = [super init];
    if(self){
        self.accesstoken = dict[@"accessToken"];
        self.expire = [dict[@"expirationTime"] intValue];
        self.expireTime = [[NSDate date] dateByAddingTimeInterval:[dict[@"expirationTime"] intValue]];
    }
    return self;
}

-(NSMutableDictionary *)modelToDict{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    dict[@"accessToken"] = self.accesstoken;
    dict[@"expirationTime"] = [NSString stringWithFormat:@"%d",self.expire];
    return dict;
}

- (id)copyWithZone:(NSZone *)zone{
    THAccessToken * model = [[self class] allocWithZone:zone];
    model.accesstoken = self.accesstoken;
    model.expire = self.expire;
    model.expireTime = self.expireTime;
    return model;
    
}
- (id)mutableCopyWithZone:(NSZone *)zone{
    THAccessToken * model = [[self class] allocWithZone:zone];
    model.accesstoken = [self.accesstoken copy];
    model.expire = self.expire;
    model.expireTime = [self.expireTime copy];
    return model;
}

@end
