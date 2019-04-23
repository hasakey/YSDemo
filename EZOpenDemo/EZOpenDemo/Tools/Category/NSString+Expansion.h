//
//  NSString+Expansion.h
//  ThinkHome
//
//  Created by ThinkHome on 16/4/28.
//  Copyright © 2016年 ThinkHome. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Expansion)

-(NSString *)checkNSStringValidity;

-(BOOL)checkContainChinese;

-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

-(NSString *)substringSafeToIndex:(NSUInteger)to;

-(CGSize)getStrSize:(UIFont*)font width:(CGFloat)width;

@end
