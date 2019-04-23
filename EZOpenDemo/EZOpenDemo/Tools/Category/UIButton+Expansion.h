//
//  UIButton+Expansion.h
//  ThinkHome
//
//  Created by ThinkHome on 15/11/2.
//  Copyright © 2015年 ThinkHome. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^buttonHandler) (UIButton *sender);
@interface UIButton (Expansion)

@property (retain,nonatomic) UIColor* normalColor;
@property (retain,nonatomic) UIColor* highlightColor;
@property (assign,nonatomic) buttonHandler handler;

-(void)becomeRound;
-(void)addButtonAction;
-(void)setLayer:(float)layerWidth layerColor:(UIColor *)layerColor radius:(int)raduis;
@end
