//
//  THAccessToken.h
//  ThinkHomeLib
//
//  Created by ThinkHome on 2017/8/4.
//  Copyright © 2017年 ThinkHome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THAccessToken : NSObject
/**
 *  用户账号登录凭证（accesstoken 会过期）
 *  引入版本: 1.0.0Beta1
 */
@property (strong,nonatomic) NSString *accesstoken;
/**
 *  accesstoken 过期时间剩余秒数 （时间计算方法: 当前时间 + expire）
 *  引入版本: 1.0.0Beta1
 */
@property (assign,nonatomic) int expire;

@property (strong,nonatomic) NSDate *expireTime;

-(instancetype)initWithDict:(NSMutableDictionary *)dict;

-(NSMutableDictionary *)modelToDict;

@end
