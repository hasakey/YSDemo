//
//  LoginVC.m
//  EZOpenDemo
//
//  Created by will on 2019/4/9.
//  Copyright © 2019 will. All rights reserved.
//

#import "LoginVC.h"
#import "AppDelegate.h"
#import "THUrl.h"
#import "THAlertData.h"
//#import "WaitView.h"
#import "UIFactory.h"
#import "MacroHeader.h"
#import "THLoginHelper.h"

//#import "THLoginHelper.h"
//#import "AppBaseInfo.h"

#define TextFieldHeight 50
#define UISpace 20
#define LeftSpace .1*M_WIDTH

@interface LoginVC ()

@property (strong,nonatomic) UITextField *accountField;

@property (strong,nonatomic) UIButton *loginButton;

@property (strong,nonatomic) UITextField *passwordField;

@property (strong,nonatomic) UIButton *registerButton;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MAINCOLOR;
    [self.titleView.title setTitle:@"登录" forState:UIControlStateNormal];
    [self.titleView.leftButton setImage:[UIImage imageNamed:@"icon_nav_arrowleft"] forState:UIControlStateNormal];
    [self.view addSubview:self.accountField];
    [self.view addSubview:self.passwordField];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.registerButton];
}

-(BOOL)canLogin{
    if([_accountField.text length] == 0){
        [THAlertData local_alert_new:180021 target:self];
        return NO;
    }else if([_passwordField.text length] == 0){
        [THAlertData local_alert_new:180019 target:self];
        return NO;
        //    }else if(![THLibStaticDB isMobileNumber:_accountField.text]){
        //        [THAlertData local_alert_new:THLocalErrorMobileWrong target:self];
        //        return NO;
    }else if(_passwordField.text.length < 6){
        [THAlertData local_alert_new:180007 target:self];
        return NO;
    }
    return YES;
}

-(void)loginAccount{
    if([self canLogin]){
        WS(weakSelf);
        [THLoginHelper loginAccount:_accountField.text password:_passwordField.text success:^(int result, NSString *message) {
            if(result == THUrlResposeSucess){
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            }
        } fail:^(NSError *error) {

        }];
    }
}

-(UITextField *)accountField{
    if(!_accountField){
//        _accountField = [UIFactory textFieldWithFrame:CGRectMake(LeftSpace, .5*M_HEIGHT - TextFieldHeight - UISpace/2, M_WIDTH - LeftSpace *2, TextFieldHeight) borderStyle:UITextBorderStyleNone font:[UIFont systemFontOfSize:20] text:@"" placeholder:@"账号"];
        _accountField = [UIFactory textFieldWithFrame:CGRectMake(LeftSpace, 200, M_WIDTH - LeftSpace *2, TextFieldHeight) borderStyle:UITextBorderStyleNone font:[UIFont systemFontOfSize:20] text:@"" placeholder:@"账号"];
        _accountField.layer.borderWidth = 1;
        _accountField.layer.borderColor = [UIColor whiteColor].CGColor;
        _accountField.layer.cornerRadius = 10;
        //        _accountField.keyboardType = UIKeyboardTypeNumberPad;
        _accountField.textColor = [UIColor whiteColor];
        [_accountField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        [_accountField setValue:[NSNumber numberWithInt:NSTextAlignmentCenter] forKeyPath:@"_placeholderLabel.textAlignment"];
        _accountField.textAlignment=NSTextAlignmentCenter;
    }
    return _accountField;
}

-(UITextField *)passwordField{
    if(!_passwordField){
//        _passwordField = [UIFactory textFieldWithFrame:CGRectMake(LeftSpace, .5*M_HEIGHT +  UISpace/2, M_WIDTH - LeftSpace *2, TextFieldHeight) borderStyle:UITextBorderStyleNone font:[UIFont systemFontOfSize:20] text:@"" placeholder:@"密码"];
        _passwordField = [UIFactory textFieldWithFrame:CGRectMake(LeftSpace, 300, M_WIDTH - LeftSpace *2, TextFieldHeight) borderStyle:UITextBorderStyleNone font:[UIFont systemFontOfSize:20] text:@"" placeholder:@"密码"];
        _passwordField.layer.borderWidth = 1;
        _passwordField.layer.borderColor = [UIColor whiteColor].CGColor;
        _passwordField.layer.cornerRadius = 10;
        _passwordField.secureTextEntry = YES;
        _passwordField.textColor = [UIColor whiteColor];
        [_passwordField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        [_passwordField setValue:[NSNumber numberWithInt:NSTextAlignmentCenter] forKeyPath:@"_placeholderLabel.textAlignment"];
        _passwordField.textAlignment=NSTextAlignmentCenter;
    }
    return _passwordField;
}

-(UIButton *)loginButton{
    if(!_loginButton){
        WS(weakSelf);
//        CGRectGetMaxY(self.passwordField.frame) + UISpace
        _loginButton = [UIFactory buttonWithFrame:CGRectMake(LeftSpace, 400, M_WIDTH - LeftSpace *2, TextFieldHeight) title:@"登录" font:[UIFont systemFontOfSize:20] titleColor:[UIColor whiteColor] image:nil highLightImage:nil normalColor:MAINCOLOR highLightColor:MAINCOLOR handler:^(UIButton *sender) {
            [weakSelf.accountField resignFirstResponder];
            [weakSelf.passwordField resignFirstResponder];
            [weakSelf loginAccount];
        }];
        _loginButton.layer.cornerRadius = 10;
    }
    return _loginButton;
}

@end
