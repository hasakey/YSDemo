//
//  THHouse.m
//  ThinkHomeLib
//
//  Created by ThinkHome on 2017/8/9.
//  Copyright © 2017年 ThinkHome. All rights reserved.
//

#import "THHouse.h"

@implementation THHouse

-(instancetype)initWithDict:(NSMutableDictionary *)dict{
    self = [super init];
    if(self){
        self.homeID = dict[@"homeID"];
        self.name = dict[@"name"];
        self.imageUrl = dict[@"imageUrl"];
        self.isDefault = dict[@"isDefault"];
        self.relation = dict[@"relation"];
        self.houseClassName = dict[@"houseClassName"];
        self.houseClassID = dict[@"houseClassID"];
        self.location = dict[@"location"];
        self.locationCN = dict[@"locationCN"];
        self.allowRadius = dict[@"allowRadius"];
        self.sortName = dict[@"sortName"];
    }
    return self;
}

-(NSMutableDictionary *)modelToDict{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    dict[@"homeID"] = self.homeID;
    dict[@"name"] = self.name;
    dict[@"imageUrl"] = self.imageUrl;
    dict[@"isDefault"] = self.isDefault;
    dict[@"relation"] = self.relation;
    dict[@"houseClassID"] = self.houseClassID;
    dict[@"houseClassName"] = self.houseClassName;
    dict[@"location"] = self.location;
    dict[@"allowRadius"] = self.allowRadius;
    dict[@"locationCN"] = self.locationCN;
    dict[@"sortName"] = self.sortName;
    return dict;
}

-(NSMutableArray *)arrToModel:(NSMutableArray *)arr{
    if(arr == nil)
        return nil;
    NSMutableArray *houseArr = [[NSMutableArray alloc]init];
    for(NSMutableDictionary * dict in arr){
        [houseArr addObject:[[THHouse alloc] initWithDict:dict]];
    }
    return houseArr;
}

@end
