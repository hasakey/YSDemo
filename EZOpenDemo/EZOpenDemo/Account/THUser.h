//
//  THUser.h
//  ThinkHomeLib
//
//  Created by ThinkHome on 2017/8/4.
//  Copyright © 2017年 ThinkHome. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "THAccessToken.h"
@interface THUser : NSObject

@property (strong,nonatomic) NSString *account;

@property (strong,nonatomic) NSString *password;

@property (strong,nonatomic) THAccessToken *accessToken;

@property (strong,nonatomic) NSString *timeZone;

@property (strong,nonatomic) NSString *isTiYan;

-(instancetype)initWithDict:(NSMutableDictionary *)dict;

-(NSMutableDictionary *)modelToDict;

@end
