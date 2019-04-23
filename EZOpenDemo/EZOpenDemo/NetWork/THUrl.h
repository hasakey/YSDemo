//
//  THUrl.h
//  ThinkHome
//
//  Created by ThinkHome on 2018/12/20.
//  Copyright © 2018 ThinkHome. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface THUrl : NSObject

+(instancetype)sharedInstance;

-(void)POST:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success fail:(void (^)(NSError *error))fail;

@end

NS_ASSUME_NONNULL_END
