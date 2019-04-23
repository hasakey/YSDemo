//
//  THAccount.h
//  ThinkHomeLib
//
//  Created by ThinkHome on 2017/8/8.
//  Copyright © 2017年 ThinkHome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THAccount : NSObject

@property (strong,nonatomic) NSString *name;

@property (strong,nonatomic) NSString *imageUrl;

@property (strong,nonatomic) NSString *phone;

@property (strong,nonatomic) NSString *mail;

@property (strong,nonatomic) NSString *isHaveOtherHouseAuth;

@property (strong,nonatomic) NSString *houseIsAutoSwitch;

@property (strong,nonatomic) NSString *isAgreePrivacyPolicy;

-(instancetype)initWithDict:(NSMutableDictionary *)dict;

-(NSMutableDictionary *)modelToDict;

@end
