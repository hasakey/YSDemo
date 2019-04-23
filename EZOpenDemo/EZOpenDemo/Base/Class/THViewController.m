//
//  THViewController.m
//  ThinkHome
//
//  Created by ThinkHome on 15/11/2.
//  Copyright © 2015年 ThinkHome. All rights reserved.
//

#import "THViewController.h"
//#import "THBaseUrl.h"
#import "WaitView.h"
#import "MacroHeader.h"

@implementation THViewController
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.view addSubview:self.controllerBackButton];
    [self.view addSubview:self.titleView];
    self.navigationController.interactivePopGestureRecognizer.delegate=(id)self;
//    self.automaticallyAdjustsScrollViewInsets=NO;
    // Do any additional setup after loading the view.
}

-(void)dealloc{
    NSLog(@"dealloc");
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

//-(UILabel *)controllerTipsLable{
//    if(_controllerTipsLable == nil){
//        _controllerTipsLable = [UIFactory labelWithFrame:CGRectMake(0.2*M_WIDTH, M_HEIGHT/2-0.2*M_HEIGHT, 0.6*M_WIDTH, 0.4*M_HEIGHT) title:@"" titleColor:GrayFontColor font:[UIFont systemFontOfSize:26.0f] labelAlignment:NSTextAlignmentCenter];
//        _controllerTipsLable.numberOfLines=4;
//        [self.view addSubview:self.controllerTipsLable];
////        _controllerTipsLable.backgroundColor = [UIColor whiteColor];
//        _controllerTipsLable.layer.masksToBounds = YES;
//        
//    }
//    return _controllerTipsLable;
//}
//
//-(UIButton *)controllerBackButton{
//    if(!_controllerBackButton){
//        WS(weakSelf);
//        _controllerBackButton = [UIFactory buttonWithFrame:CGRectMake(0, 0, M_WIDTH, M_HEIGHT) title:@"" font:nil titleColor:nil image:nil highLightImage:nil normalColor:nil highLightColor:nil handler:^(UIButton *sender) {
//            [weakSelf backButtonActon];
//        }];
//    }
//    return _controllerBackButton;
//}

-(void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion{
    dispatch_async(dispatch_get_main_queue(), ^{
        [super presentViewController:viewControllerToPresent animated:flag completion:completion];
    });
}

-(void)controllerUrlRetrunError:(int)errorNo withMsg:(NSString *)msg{
    [[WaitView sharedInstance] removeWaitView];
//    if(errorNo == 200 || errorNo == THUrlResposeSucess)
//        return;
//
//    if(errorNo == THUrlResposeErrorAcessTokenWrong){
//        [THUserHelper login:[AppBaseInfo sharedInstance].nowUser.account password:[AppBaseInfo sharedInstance].nowUser.password success:^(int result, NSString *message) {
//            if(result == THUrlResposeErrorPasswordWrong){
//                [self returnToLoginView:YES];
//            }else if(result == THUrlResposeSucess){
//
//            }
//        } fail:^(NSError *error) {}];
//    }else if(errorNo == THUrlResposeErrorHouseNotExist){
//        [AppBaseInfo sharedInstance].nowHouse.homeID = nil;
//        [THKeyChain delete:NowHouseDataKey];
//        THHouseChangeViewController *houseChange = [[THHouseChangeViewController alloc]init];
//        houseChange.canGoBack = NO;
//        houseChange.isChangeAccount = YES;
//        [self.navigationController pushViewController:houseChange animated:YES];
//    }else if(errorNo == THUrlResposeErrorMaintaining){
//        NSString *timerStr = [NSString stringWithFormat:@"%@%@",msg,[THLibStaticDB DPLocalizedString:@"Minute"]];
//        NSString *errorInfo=[NSString stringWithFormat:[THLibStaticDB DPLocalizedString:@"NetError_49997"],timerStr];
//        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:errorInfo delegate:nil cancelButtonTitle:[THLibStaticDB DPLocalizedString:@"OK"] otherButtonTitles:nil, nil];
//        [alert show];
//    }
//    if(errorNo != THUrlResposeErrorAcessTokenWrong && errorNo != THUrlResposeErrorMaintaining)
//        [THAlertData net_alert_new:errorNo target:self];
//    if(errorNo == 999)
//        return;
}

-(void)controllerUrlRetrunError:(int)errorNo target:(id)target sel:(SEL)action{
    [[WaitView sharedInstance] removeWaitView];
//    if(errorNo == 200 || errorNo == THUrlResposeSucess)
//        return;
//    if(errorNo == THUrlResposeErrorAcessTokenWrong){
//        [THUserHelper login:[AppBaseInfo sharedInstance].nowUser.account password:[AppBaseInfo sharedInstance].nowUser.password success:^(int result, NSString *message) {
//            if(result == THUrlResposeErrorPasswordWrong){
//                [self returnToLoginView:YES];
//            }else if(result == THUrlResposeSucess){
//                [target performSelectorOnMainThread:action withObject:nil waitUntilDone:NO];
//            }
//        } fail:^(NSError *error) {}];
//    }else if(errorNo == THUrlResposeErrorHouseNotExist){
//        [AppBaseInfo sharedInstance].nowHouse.homeID = nil;
//        [THKeyChain delete:NowHouseDataKey];
//        THHouseChangeViewController *houseChange = [[THHouseChangeViewController alloc]init];
//        houseChange.canGoBack = NO;
//        houseChange.isChangeAccount = YES;
//        [self.navigationController pushViewController:houseChange animated:YES];
//    }
//    if(errorNo != THUrlResposeErrorAcessTokenWrong){
//        [THAlertData net_alert:errorNo];
//        [[WaitView sharedInstance] removeWaitView];
//    }
//    if(errorNo == 999)
//        return;
}


-(void)touchTitleLeftButton{
//    [[THBaseUrl sharedInstance]cancelUrlRequest];
    [[WaitView sharedInstance] removeWaitView];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)touchTitleRightButton{
}

-(THTitleView *)titleView{
    if(_titleView == nil){
        WS(weakSelf);
        _titleView = [[THTitleView alloc]initWithLeftBlock:^{
            [weakSelf touchTitleLeftButton];
        } rightBlock:^{
            [weakSelf touchTitleRightButton];
        }];
    }
    return _titleView;
}

-(void)backButtonActon{

}

@end
