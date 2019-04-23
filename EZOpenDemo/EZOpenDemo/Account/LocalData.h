//
//  LocalData.h
//  ThinkHomeLib
//
//  Created by ThinkHome on 15/7/6.
//  Copyright (c) 2015年 ThinkHome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalData : NSObject
/**
 *  本地数据单例
 *
 *  @return 单例
 */
+(instancetype)sharedInstance;
/**
 *  更新或添加数据
 *
 *  @param info 数据
 *  @param key  对应KEY
 */
-(void)insertData:(id)info withKey:(NSString*)key;
/**
 *  获得数据
 *
 *  @param key 对应KEY
 *
 *  @return KEY对应数据
 */
-(id)getData:(NSString *)key;

-(void)removeData:(NSString *)key;

@end
