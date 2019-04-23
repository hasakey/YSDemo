//
//  THTitleView.h
//  ThinkHome
//
//  Created by ThinkHome on 15/11/16.
//  Copyright © 2015年 ThinkHome. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^LeftButtonBlock) ();
typedef void(^RightButtonBlock) ();
typedef void(^MidButtonBlock) ();
@interface THTitleView : UIView

-(instancetype)initWithLeftBlock:(LeftButtonBlock)leftBlock rightBlock:(RightButtonBlock)rightBlock;

@property (copy,nonatomic) MidButtonBlock midBlock;

@property (strong,nonatomic) UIView *backView;

@property (strong,nonatomic) UIButton *leftButton;

@property (strong,nonatomic) UIButton *title;

@property (strong,nonatomic) UIButton *rightButton;

@property (strong,nonatomic) UIActivityIndicatorView *activity;

@end
