//
//  NSString+Expansion.m
//  ThinkHome
//
//  Created by ThinkHome on 16/4/28.
//  Copyright © 2016年 ThinkHome. All rights reserved.
//

#import "NSString+Expansion.h"

@implementation NSString (Expansion)

-(NSString *)checkNSStringValidity{
    if([self isKindOfClass:[NSNull class]]){
        return @"";
    }else if([self isKindOfClass:[NSNumber class]]){
        return [NSString stringWithFormat:@"%@",self];
    }
    return self;
}

-(BOOL)checkContainChinese{
    if ([self rangeOfString:@"[\\u4e00-\\u9fa5]" options:NSRegularExpressionSearch].location != NSNotFound){
        return YES;
    }else{
        return NO;
    }
}

-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

-(NSString *)substringSafeToIndex:(NSUInteger)to{
    if(self.length > to){
        return [self substringToIndex:to];
    }else{
        return self;
    }
}

-(CGSize)getStrSize:(UIFont*)font width:(CGFloat)width{
    CGSize titleSize = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    return titleSize;
}

@end
