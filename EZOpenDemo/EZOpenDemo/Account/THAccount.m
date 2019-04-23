//
//  THAccount.m
//  ThinkHomeLib
//
//  Created by ThinkHome on 2017/8/8.
//  Copyright © 2017年 ThinkHome. All rights reserved.
//

#import "THAccount.h"

@implementation THAccount

-(instancetype)initWithDict:(NSMutableDictionary *)dict{
    self = [super init];
    if(self){
        self.name = dict[@"name"];
        self.imageUrl = dict[@"imageUrl"];
        self.phone = dict[@"phone"];
        self.mail = dict[@"mail"];
        self.isHaveOtherHouseAuth = dict[@"isHaveOtherHouseAuth"];
        self.houseIsAutoSwitch = dict[@"houseIsAutoSwitch"];
        self.isAgreePrivacyPolicy = dict[@"isAgreePrivacyPolicy"];
    }
    return self;
}

-(NSMutableDictionary *)modelToDict{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    dict[@"name"] = self.name;
    dict[@"imageUrl"] = self.imageUrl;
    dict[@"phone"] = self.phone;
    dict[@"mail"] = self.mail;
    dict[@"isHaveOtherHouseAuth"] = self.isHaveOtherHouseAuth;
    dict[@"houseIsAutoSwitch"] = self.houseIsAutoSwitch;
    dict[@"isAgreePrivacyPolicy"] = self.isAgreePrivacyPolicy;
    return dict;
}

- (id)mutableCopyWithZone:(NSZone *)zone{
    THAccount * model = [[self class] allocWithZone:zone];
    model.name = [self.name copy];
    model.imageUrl = [self.imageUrl copy];
    model.phone = [self.phone copy];
    model.mail = [self.mail copy];
    model.isHaveOtherHouseAuth = [self.isHaveOtherHouseAuth copy];
    model.houseIsAutoSwitch = [self.houseIsAutoSwitch copy];
    model.isAgreePrivacyPolicy = [self.isAgreePrivacyPolicy copy];
    return model;
}

@end
