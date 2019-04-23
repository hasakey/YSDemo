//
//  LocalData.m
//  ThinkHomeLib
//
//  Created by ThinkHome on 15/7/6.
//  Copyright (c) 2015年 ThinkHome. All rights reserved.
//

#import "LocalData.h"

@interface LocalData(){
    NSUserDefaults *userDeafaults;
}

@end

@implementation LocalData

+(instancetype)sharedInstance{
    static LocalData *localData=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        localData = [[LocalData alloc]init];
    });
    return localData;
}

-(id)init{
    self=[super init];
    userDeafaults=[NSUserDefaults standardUserDefaults];
    return self;
}

-(void)insertData:(id)info withKey:(NSString*)key{
    [userDeafaults setValue:info forKey:key];
    BOOL flag =  [userDeafaults synchronize];
    if(!flag)
        NSLog(@"更新失败");
}

-(id)getData:(NSString *)key{
    return [userDeafaults objectForKey:key];
}

-(void)removeData:(NSString *)key{
    [userDeafaults removeObjectForKey:key];
    BOOL flag = [userDeafaults synchronize];
    if(!flag)
        NSLog(@"更新失败");
}

@end
