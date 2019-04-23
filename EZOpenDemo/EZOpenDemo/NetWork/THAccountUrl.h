//
//  THAccountUrl.h
//  EZOpenDemo
//
//  Created by will on 2019/4/3.
//  Copyright © 2019 will. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface THAccountUrl : NSObject

-(void)getTokenSuccess:(void (^)(id responseObject))success;

@end

NS_ASSUME_NONNULL_END
