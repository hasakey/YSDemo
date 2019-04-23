//
//  THViewController.h
//  ThinkHome
//
//  Created by ThinkHome on 15/11/2.
//  Copyright © 2015年 ThinkHome. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THTitleView.h"

@interface THViewController : UIViewController

@property (strong,nonatomic) THTitleView *titleView;

//@property (strong,nonatomic) UIButton *controllerBackButton;
//
//@property (strong,nonatomic) UILabel *controllerTipsLable;

@property (assign,nonatomic) BOOL isLoading;

-(void)controllerUrlRetrunError:(int)errorNo withMsg:(NSString *)msg;

-(void)controllerUrlRetrunError:(int)errorNo target:(id)target sel:(SEL)action;

-(void)backButtonActon;

-(void)touchTitleLeftButton;

-(void)touchTitleRightButton;

//-(void)returnToLoginView:(BOOL)animated;

@end
