//
//  WaitView.h
//  ThinkHome
//
//  Created by ThinkHome on 15/11/16.
//  Copyright © 2015年 ThinkHome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaitView : UIView

+(instancetype)sharedInstance;

-(void)setShowWaitViewText:(NSString *)text;

-(void)showWaitView:(id)target title:(NSString *)text time:(int)time;

-(void)removeWaitView;

-(void)removeWaitViewNow;

@end
