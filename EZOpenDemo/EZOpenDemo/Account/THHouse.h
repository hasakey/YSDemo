//
//  THHouse.h
//  ThinkHomeLib
//
//  Created by ThinkHome on 2017/8/9.
//  Copyright © 2017年 ThinkHome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THHouse : NSObject

@property (strong,nonatomic) NSString *homeID;

@property (strong,nonatomic) NSString *name;

@property (strong,nonatomic) NSString *imageUrl;

@property (strong,nonatomic) NSString *isDefault;

@property (strong,nonatomic) NSString *relation;

@property (strong,nonatomic) NSString *houseClassID;

@property (strong,nonatomic) NSString *houseClassName;

@property (strong,nonatomic) NSString *location;

@property (strong,nonatomic) NSString *locationCN;

@property (strong,nonatomic) NSString *allowRadius;

@property (strong,nonatomic) NSString *sortName;

-(instancetype)initWithDict:(NSMutableDictionary *)dict;

-(NSMutableDictionary *)modelToDict;

-(NSMutableArray *)arrToModel:(NSMutableArray *)arr;

@end
