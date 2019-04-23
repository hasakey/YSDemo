//
//  ViewController.m
//  EZOpenDemo
//
//  Created by will on 2019/4/2.
//  Copyright © 2019 will. All rights reserved.
//

//ys7
//C64129966     //strSn
//ASBQVM    //strVerify
//CS-C6C-3B2WFR //deviceType


//"accountId": "9aa144931a54470aa98d8597366c38a6",
//"accountName": "TESTDING",
//"appKey": "48a2ff7840bf4335a7391850da716d06",
//"accountStatus": 1,
//"policy": null,
//"accessToken": "ra.2tthasnn30q06ubu6m2r4r6f72y35606-2h62r7jlu4-0qy6dql-sxxz5al2a"

//TESTDING
//123456

//TEST2019
//123456
//"accountId": "cc89c5abf2a04762bc2447f6822654f9",
//"accountName": "TEST2019",
//"appKey": "48a2ff7840bf4335a7391850da716d06",
//ra.4jdab6wb2kmqpeg2cr7dfcvq7jbcgkqh-1vwfbus2iw-0lphl6d-eeqa9hlfs

//[EZOpenSDK setAccessToken:@"at.701wer86do2voy3i8kz7b2xab1r1zrcg-77bbpjkqe0-1qoch28-7zm5ointf"];//主账号

//无线录像机设备信息
//ys7
//C98986354
//WRRKKP
//CS-X5C-4
//F8:4D:FC:9A:0D:B0

//摄像头
//ys7
//D04264159
//UBIYKR
//CS-C6C-1C2WFRV

#import "ViewController.h"
#import "THAccountUrl.h"
#import <EZOpenSDKFramework/EZOpenSDKFramework.h>
#import "THQRScanVC.h"
#import "THGetInfoTool.h"
#import "DeviceListCell.h"
#import "MacroHeader.h"
#import "EZLivePlayViewController.h"
#import "NewsListVC.h"
#import "THYSUrl.h"
#import "THAccountUrl.h"

@interface ViewController ()<UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource>{
    NSTimer *connectTimer;
    BOOL isConfig;
}

@property (nonatomic, copy) NSString *YSSN;
@property (nonatomic, copy) NSString *YSVerifyCode;
@property (nonatomic, copy) NSString *YSDeviceType;

@property (nonatomic,strong) NSString *wifiName;
@property (nonatomic,strong) NSString *wifiPassword;

@property (nonatomic, strong) NSMutableArray *deviceList;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.titleView];
    [self.titleView.title setTitle:@"设备列表" forState:UIControlStateNormal];
    [self.titleView.rightButton setTitle:@"二维码" forState:UIControlStateNormal];
    _wifiName = [THGetInfoTool getWifiName];
    [self.titleView.leftButton setTitle:@"消息列表" forState:UIControlStateNormal];
    _wifiPassword = @"TR4008002016";
//     [EZOpenSDK setAccessToken:@"ra.0g4ji42o76guuy82220ahfpe4h5vc6b3-13jjynjufw-1lesjj4-dmi1blm5h"];//子账号
    [EZOpenSDK setAccessToken:@"at.9ax7526u8oj2fycecmzhn53i5eive3w0-4qp3qcsxw2-067dyis-6xnfsvb7w"];//主账号
    
    
    [self.view addSubview:self.tableView];
//    [self getDeviceList];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [connectTimer invalidate];
    connectTimer = nil;
    [EZOpenSDK stopConfigWifi];
}


#pragma mark    查询设备
//- (void)doSearchDevice{
//
//}

#pragma mark    添加设备
- (void)addDevice{
    self.YSSN = @"C98986354";
    self.YSVerifyCode = @"WRRKKP";
    THYSUrl *tool = [THYSUrl new];
    NSDictionary *param = @{@"accessToken" : @"at.9ax7526u8oj2fycecmzhn53i5eive3w0-4qp3qcsxw2-067dyis-6xnfsvb7w",
                          @"deviceSerial" :self.YSSN,
                          @"validateCode" :self.YSVerifyCode
                          };

    [tool addDevice:param Success:^(id  _Nonnull responseObject) {
        
    }];
    
//    [EZOpenSDK addDevice:self.YSSN
//              verifyCode:self.YSVerifyCode
//              completion:^(NSError *error) {
//                  [self handleTheError:error];
//              }];
}

#pragma mark    关联设备
- (void)relevanceDevice{
    self.YSSN = @"C98986354";
//    self.YSVerifyCode = @"WRRKKP";
    THYSUrl *tool = [THYSUrl new];
    NSDictionary *param = @{@"accessToken" : @"at.9ax7526u8oj2fycecmzhn53i5eive3w0-4qp3qcsxw2-067dyis-6xnfsvb7w",
                            @"deviceSerial" :@"C98986354",
                            @"ipcSerial" :@"D04264159"
                            };
    
    [tool relevanceDevice:param Success:^(id  _Nonnull responseObject) {

    }];
}

-(void)getDeviceList{
     __weak typeof(self) weakSelf = self;
    //获取设备列表接口
    [EZOpenSDK getDeviceList:0
                    pageSize:10
                  completion:^(NSArray *deviceList, NSInteger totalCount, NSError *error) {
                      
                      if(error)
                      {
//                          [weakSelf.view makeToast:error.description duration:2.0 position:@"bottom"];
                          NSLog(@"获取设备列表接口失败 : error: %@",error);
                          return;
                      }
                      NSLog(@"获取设备列表接口成功");
                      [weakSelf.deviceList removeAllObjects];
                      [weakSelf.deviceList addObjectsFromArray:deviceList];
                      [weakSelf.tableView reloadData];
//                      [weakSelf.tableView.header endRefreshing];
//                      if (weakSelf.deviceList.count == totalCount)
//                      {
//                          [weakSelf.tableView.footer endRefreshingWithNoMoreData];
//                      }
//                      else
//                      {
//                          [weakSelf addFooter];
//                      }
                  }];
}

//二维码界面
-(void)touchTitleRightButton{
    [self relevanceDevice];
//    [self addDevice];
//    THQRScanVC *VC = [THQRScanVC new];
//    VC.blocks = ^(NSString *returnStr) {
//        self.YSSN =  [self snFromQRcode:returnStr];
//        [self wifiConfig];
//    };
//
//    [self presentViewController:VC animated:YES completion:^{
//
//    }];
//
//    self.YSSN = @"D04264159";
//    self.YSVerifyCode = @"UBIYKR";
//    self.YSSN = @"C98986354";
//    self.YSVerifyCode = @"WRRKKP";
//    [self wifiConfig];
//    connectTimer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(timeOver) userInfo:nil repeats:NO];
}

-(void)touchTitleLeftButton{
//    NewsListVC *vc = [NewsListVC new];
//    [self.navigationController pushViewController:vc animated:NO];
//    THAccountUrl *tool = [THAccountUrl new];
//    [tool getTokenSuccess:^(id  _Nonnull responseObject) {
//
//    }];
    
}


-(void)wifiConfig{
    NSLog(@"wifiConfig");
    isConfig = YES;
    [self smartWifiConfig];
    [EZOpenSDK probeDeviceInfo:self.YSSN deviceType:nil completion:^(EZProbeDeviceInfo *deviceInfo, NSError *error) {
        NSLog(@"deviceInfo : %@",deviceInfo);
        if(([error code] == EZ_HTTPS_DEVICE_ADDED_MYSELF || error.code == EZ_HTTPS_DEVICE_ONLINE_IS_ADDED)){
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"设备已被添加"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
        } else {
            if(deviceInfo){
                [self smartWifiConfig];
                if(deviceInfo.supportAP == 2){
                    [self apWifiConfig];
                }else{
                    [self smartWifiConfig];
                }
            }else{
                [self smartWifiConfig];
            }
        }
    }];
}

-(void)apWifiConfig{
    
    NSLog(@"apWifiConfig");
    NSLog(@"_wifiName ： %@  _wifiPassword : %@  YSSN: %@    YSVerifyCode: %@",_wifiName,_wifiPassword,self.YSSN,self.YSVerifyCode);
    [EZOpenSDK startConfigWifi:_wifiName password:_wifiPassword deviceSerial:self.YSSN mode:1 deviceStatus:^(EZWifiConfigStatus status, NSString *deviceSerial) {
        
        [EZOpenSDK startAPConfigWifiWithSsid:self->_wifiName
                                    password:self->_wifiPassword
                                    deviceSerial:self.YSSN
                                      verifyCode:self.YSVerifyCode
                                          result:^(BOOL ret) {
                                              if (ret)
                                              {
        //                                          if(_isWifiConfig){
        //                                              [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 5] animated:YES];
        //                                          }else{
                                                      [EZOpenSDK addDevice:self.YSSN
                                                                verifyCode:self.YSVerifyCode
                                                                completion:^(NSError *error) {
                                                                    [self finishWifiConfig:nil error:error];
                                                                }];
                                                  }
        //                                      }
                                          }];
        
    }];

}


//ap配网
-(void)smartWifiConfig{
    NSLog(@"smartWifiConfig");
    [EZOpenSDK startAPConfigWifiWithSsid:_wifiName password:_wifiPassword deviceSerial:self.YSSN verifyCode:self.YSVerifyCode result:^(BOOL ret) {
        
        if (ret)
        {
            //配置成功
        }
        else
        {
            //配置失败
        }
        
    }];
//    [EZOpenSDK startConfigWifi:_wifiName password:_wifiPassword deviceSerial:self.YSSN deviceStatus:^(EZWifiConfigStatus status) {
//        if (status == DEVICE_PLATFORM_REGISTED)
//        {
////            [connectTimer invalidate];
////            connectTimer = nil;
//            if(self.YSSN != nil)
//            {
//                [EZOpenSDK addDevice:self.YSSN
//                          verifyCode:self.YSVerifyCode
//                          completion:^(NSError *error) {
//                              [self finishWifiConfig:nil error:error];
//                          }];
//            }
//        }
//        else if (status == DEVICE_ACCOUNT_BINDED)
//        {
////            if(_isWifiConfig){
////                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 5] animated:YES];
////            }else{
//                [self finishWifiConfig:nil error:nil];
////            }
//        }else if (status == DEVICE_WIFI_CONNECTING){
//            [self smartWifiConfig];
//        }
//    }];
}


-(void)timeOver{
    NSLog(@"timeOver");
    [connectTimer invalidate];
    connectTimer = nil;
    [EZOpenSDK stopConfigWifi];
    [EZOpenSDK probeDeviceInfo:self.YSSN
                    deviceType:nil
                    completion:^(EZProbeDeviceInfo *deviceInfo, NSError *error) {
                        if (error)
                        {
//                            [connectImg stopAnimating];
//                            failView.hidden=NO;
                            [EZOpenSDK stopConfigWifi];
//                            [connectImg setImage:[UIImage imageNamed:@"yswifi_fail.png"]];
//                            tipsLabel.text=[THLibStaticDB DPLocalizedString:@"ConnectWifiFail"];
                            
                            int code = (int)[error code];
                            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"添加设备失败(错误码:%d)",code] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                            [alertView show];
                        }
                        else
                        {
                            if (self.YSVerifyCode != nil)
                            {
                                [EZOpenSDK addDevice:self.YSSN
                                          verifyCode:self.YSVerifyCode
                                          completion:^(NSError *error) {
                                              [self finishWifiConfig:nil error:error];
                                          }];
                            }
                            else
                            {
                                //fix
                                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请输入设备验证码" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                                alertView.alertViewStyle = UIAlertViewStyleSecureTextInput;
                                alertView.tag = 0xaa;
                                [alertView show];
                            }
                        }
                    }];
}

-(void)finishWifiConfig:(id)result1 error:(NSError *)error{
    NSLog(@"finishWifiConfig");
    [EZOpenSDK stopConfigWifi];
    if(!isConfig){
        return;
    }
    isConfig = NO;
    if(!error){
        NSLog(@"添加成功");
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"添加设备失败(错误码:%d)",code] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alertView show];
        
//        if(_isWifiConfig){
//            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 4] animated:YES];
//        }else{
//            [YSVideo ys:self.strSn bingingTH:_deviceNo success:^(int result, NSString *message) {
//                if(result == THUrlResposeSucess){
//                    NSMutableDictionary *ysCodeDict = [[[LocalData sharedInstance] getData:@"YSCode"] mutableCopy];
//                    if(ysCodeDict == nil){
//                        ysCodeDict = [[NSMutableDictionary alloc]init];
//                    }
//                    [ysCodeDict setObject:self.strVerify forKey:self.strSn];
//                    [[LocalData sharedInstance] insertData:ysCodeDict withKey:@"YSCode"];
//                    if(self.tabBarController.selectedIndex == 0)
//                        [self.navigationController popToRootViewControllerAnimated:YES];
//                    else
//                        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
//                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:[THLibStaticDB DPLocalizedString:@"AddDeviceSuccessTitle"] message:[THLibStaticDB DPLocalizedString:@"AddDeviceSuccessTips"] delegate:self cancelButtonTitle:[THLibStaticDB DPLocalizedString:@"OK"] otherButtonTitles:nil];
//                    [alert show];
//                }else{
//                    [connectImg stopAnimating];
//                    failView.hidden=NO;
//                    [connectImg setImage:[UIImage imageNamed:@"yswifi_fail.png"]];
//                    tipsLabel.text=[THLibStaticDB DPLocalizedString:@"ConnectWifiFail"];
//
//                    [THAlertData net_alert:result];
//                }
//            } fail:^(NSError *error) {
//                [self controllerUrlRetrunError:THUrlResposeErrorFail withMsg:@""];
//            }];
//        }
    }else{
//        if(_isWifiConfig){
//            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 4] animated:YES];
//        }else{
//            [connectImg stopAnimating];
//            failView.hidden=NO;
//            [connectImg setImage:[UIImage imageNamed:@"yswifi_fail.png"]];
//            tipsLabel.text=[THLibStaticDB DPLocalizedString:@"ConnectWifiFail"];
        
            int code = (int)[error code];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"添加设备失败(错误码:%d)",code] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
//        }
    }
}


//
//-(void)gotoYsvideo:(NSString *)str{
//    NSArray *arr=[str componentsSeparatedByString:@"\r"];
//    if([arr count] > 2){
//        [YSVideo ys:[arr objectAtIndex:1] checkProduct:^(int result, NSString *message) {
//            if(result == THUrlResposeSucess){
//                [THCoorAddHelper getCoorRegisterWay:[arr objectAtIndex:1] sucess:^(int result, NSDictionary *addInfoDict, NSString *message) {
//                    if(result == THUrlResposeSucess){
//                        YSWifiConfirmViewController *ysrvvc=[[YSWifiConfirmViewController alloc]init];
//                        ysrvvc.ysDeviceInfo=str;
//                        [self.navigationController pushViewController:ysrvvc animated:YES];
//                    }else
//                        [self showAlertView:result];
//                } fail:^(NSError *error) {
//                    [self showAlertView:THUrlResposeErrorFail];
//                }];
//            }else{
//                [self showAlertView:result];
//            }
//        } fail:^(NSError *error) {
//            [self showAlertView:THUrlResposeErrorFail];
//        }];
//    }
//}


- (NSString * )snFromQRcode: (NSString *) strQRcode
{
//    self.m_strDetectorSubType = nil;
    NSString * strSN = nil;
    NSArray * arrString = [strQRcode componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    //空字符串过滤
    NSMutableArray *rcodeMutAry = [NSMutableArray arrayWithArray:arrString];
    NSMutableArray *copyRcodeMutAry = [NSMutableArray arrayWithArray:arrString];
    for (NSString *strMge in copyRcodeMutAry)
    {
        if ([strMge length] <= 1)
        {
            [rcodeMutAry removeObject:strMge];
        }
    }
    
    NSUInteger nStringCount = [rcodeMutAry count];
    if (nStringCount == 1)
    {
        strSN = [NSString stringWithFormat:@"%@", [rcodeMutAry objectAtIndex:0]];
    }
    else if (nStringCount > 1)
    {
        strSN = [NSString stringWithFormat:@"%@", [rcodeMutAry objectAtIndex:1]];
    }
//    else
//    {
//        self.strVerifyCode = nil;
//        self.strModel = nil;
//        self.m_strDetectorSubType = nil;
//        return nil;
//    }
//
//    self.strVerifyCode = nil;
//    if (nStringCount > 2)
//    {
//        self.strVerifyCode = [rcodeMutAry objectAtIndex:2];
//        if ([self.strVerifyCode length] < 6)
//        {
//            self.strVerifyCode = nil;
//        }
//    }
//
//    self.strModel = nil;
//    if (nStringCount > 3)
//    {
//        self.strModel = [rcodeMutAry objectAtIndex:3];
//    }
//
//    self.m_strDetectorSubType = nil;
//    if (nStringCount > 4)
//    {
//        NSString *tmpstr = [rcodeMutAry objectAtIndex:4];
//        if (4 == [tmpstr length]) //探测器子型号为四个字节(T001/K002)
//        {
//            self.m_strDetectorSubType = tmpstr;
//        }
//
//    }
    
    return strSN;
}

#pragma mark   tableviewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _deviceList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DeviceListCell *cell = [[DeviceListCell alloc] cellWithTableView:tableView];
    EZDeviceInfo *info = [_deviceList objectAtIndex:indexPath.row];

//    cell.isShared = _isSharedDevice;
    [cell setDeviceInfo:info];
    cell.parentViewController = self;

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCREEN_HEIGHT - TitleHeight;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EZLivePlayViewController *vc = [EZLivePlayViewController new];
    vc.deviceInfo = [_deviceList objectAtIndex:indexPath.row];
    
//    [self presentViewController:vc animated:NO completion:^{
//
//    }];
    [self.navigationController pushViewController:vc animated:NO];
}

#pragma mark    set/get
-(NSMutableArray *)deviceList{
    if (!_deviceList) {
        _deviceList = [NSMutableArray array];
    }
    return _deviceList;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TitleHeight, self.view.frame.size.width, self.view.frame.size.height - TitleHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)handleTheError:(NSError *)error
{
    if (!error)
    {
//        [self performSegueWithIdentifier:@"go2WifiResult" sender:nil];
        return;
    }
    if (error.code == 105002)
    {
        NSLog(@"验证码错误");
//        UIAlertView *retryAlertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"device_verify_code_wrong", @"验证码错误") message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"cancel", @"取消") otherButtonTitles:NSLocalizedString(@"retry", @"重试"), nil];
//        retryAlertView.tag = 0xbb;
//        [retryAlertView show];
    }
    else if (error.code == 105000)
    {
        NSLog(@"您已添加过此设备");
//        [UIView dd_showMessage:NSLocalizedString(@"ad_already_added",@"您已添加过此设备")];
    }
    else if (error.code == 105001)
    {
        NSLog(@"此设备已被别人添加");
//        [UIView dd_showMessage:NSLocalizedString(@"ad_added_by_others",@"此设备已被别人添加")];
    }
    else
    {
        NSLog(@"添加失败");
//        [UIView dd_showMessage:NSLocalizedString(@"wifi_add_fail",@"添加失败")];
    }
}

@end
