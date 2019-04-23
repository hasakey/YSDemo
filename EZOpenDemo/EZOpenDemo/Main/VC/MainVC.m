//
//  MainVC.m
//  EZOpenDemo
//
//  Created by will on 2019/4/23.
//  Copyright © 2019 will. All rights reserved.
//

#import "MainVC.h"
#import "QRCodeVC.h"
#import "LoginVC.h"
#import "AppBaseInfo.h"

@interface MainVC ()

@property(nonatomic,strong)UILabel *loginStatusLabel;

@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.titleView.title setTitle:@"首页" forState:UIControlStateNormal];
    [self.titleView.rightButton setImage:[UIImage imageNamed:@"button_scan"] forState:UIControlStateNormal];
    [self.titleView.leftButton setTitle:@"登录" forState:UIControlStateNormal];
    [self setupSubviews];
    [self checkLogin];
}

-(void)setupSubviews{
    [self.view addSubview:self.loginStatusLabel];
}

-(void)touchTitleLeftButton{
    LoginVC *loginVC=[[LoginVC alloc]init];
    [self.navigationController pushViewController:loginVC animated:YES];
}

-(void)touchTitleRightButton{
    QRCodeVC *qrcvvc=[[QRCodeVC alloc]init];
    qrcvvc.canImport=YES;
    qrcvvc.roomNo=@"";
    qrcvvc.returnPageNum = 1;
    [self.navigationController pushViewController:qrcvvc animated:YES];
}

-(void)checkLogin{
    if([AppBaseInfo sharedInstance].nowUser.account == nil || [AppBaseInfo sharedInstance].nowUser.accessToken.accesstoken == nil){
        self.loginStatusLabel.text = @"未登录";
    } else {
        self.loginStatusLabel.text = @"已登录";
    }
    
}

- (UILabel *)loginStatusLabel{
    if (!_loginStatusLabel) {
        _loginStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
        _loginStatusLabel.center = self.view.center;
        _loginStatusLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _loginStatusLabel;
}

@end
