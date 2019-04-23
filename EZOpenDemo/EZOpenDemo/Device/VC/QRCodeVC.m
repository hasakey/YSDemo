//
//  QRCodeViewViewController.m
//  ThinkHome
//
//  Created by ThinkHome on 15/1/4.
//  Copyright (c) 2015年 ThinkHome. All rights reserved.
//

#import "QRCodeVC.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
//#import "ImportViewController.h"
//#import "SmartLinkStep2ViewController.h"
//#import "APStep2ViewController.h"
//#import "LineStep1ViewController.h"
//#import "THCoorAddHelper.h"
//#import "YSVideo.h"
//#import "YSWifiConfirmViewController.h"
#import "MacroHeader.h"

@interface QRCodeVC ()<UIActionSheetDelegate>{
    UIButton *lightButton;
    BOOL isScaning;
    BOOL isEnter;
}

@end

@implementation QRCodeVC

-(void)dealloc{
    NSLog(@"dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    self.view.backgroundColor = [UIColor blackColor];
    isEnter = YES;
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    isScaning = NO;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
    if(isEnter){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self checkAVAuthorizationStatus];
        });
        isEnter = NO;
    }else{
        [_session startRunning];
    }
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    isLight = NO;
    [self setLightButtonShow];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [_session stopRunning];
}

-(void)touchTitleRightButton{
    UIActionSheet *actionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"SmartLink",@"SmartAP",@"ScanButton",nil];
    [actionSheet showInView:self.view];
}

-(void)initView{
    [self.titleView.title setTitle:@"扫描二维码" forState:UIControlStateNormal];
    [self.titleView.leftButton setImage:[UIImage imageNamed:@"icon_nav_arrowleft"] forState:UIControlStateNormal];

    if(_canImport){
        [self.titleView.rightButton setImage:[UIImage imageNamed:@"button_add"] forState:UIControlStateNormal];
    }
    
    UIImageView *backImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, M_WIDTH, M_HEIGHT)];
    [backImage setImage:[UIImage imageNamed:@"smzz.png"]];
    [self.view insertSubview:backImage belowSubview:self.titleView];
    
    UILabel *tips=[[UILabel alloc]initWithFrame:CGRectMake(M_WIDTH/2-120, 280/(480/M_HEIGHT), 240, 80)];
    tips.numberOfLines=2;
    tips.textColor=[UIColor whiteColor];
    tips.textAlignment=NSTextAlignmentCenter;
    tips.text=@"请扫描产品序列号二维码";
    [self.view addSubview:tips];
    
    lightButton=[[UIButton alloc]initWithFrame:CGRectMake(M_WIDTH/2-30, M_HEIGHT-100, 60, 60)];
    [lightButton setImage:[UIImage imageNamed:@"button_smsgd.png"] forState:UIControlStateNormal];
    [lightButton addTarget:self action:@selector(touchLight:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lightButton];
}

-(void)setupCamera{
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetPhoto];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
//    _preview.frame =CGRectMake(self.view.bounds.origin.x,self.view.bounds.origin.y,self.view.bounds.size.width,self.view.bounds.size.height);
    _preview.frame=CGRectMake(0, 64, M_WIDTH, M_HEIGHT-64);
    [self.view.layer insertSublayer:self.preview atIndex:0];
    //self.view.alpha = 0.5;
    if(!_device.torchAvailable){
        lightButton.hidden = YES;
    }
    
    // Start
    [_session startRunning];
}

- (void)checkAVAuthorizationStatus
{
    [self doesCameraSupportTakingPhotos];
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(status == AVAuthorizationStatusAuthorized)
    {
        [self setupCamera];
    }
    else if(status == AVAuthorizationStatusNotDetermined){
        // Explicit user permission is required for media capture, but the user has not yet granted or denied such permission.
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if(granted){//点击允许访问时调用
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self setupCamera];
                });
            }
        }];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"摄像头不可用" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if(isScaning)
        return;
    isScaning = YES;
    NSString *stringValue = @"";
    
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    isLight = NO;
    [self setLightButtonShow];
    if(_isYsDevice){
        _blocks([NSMutableDictionary dictionaryWithObject:stringValue forKey:@"FValue"]);
    }else{
        NSString *str=stringValue;
        if([str containsString:@"\r"]){
            [self gotoYsvideo:str];
        }else if([str containsString:@"http"]){
            NSRange range = [str rangeOfString:@"id="];
            if(range.length > 0){
                NSString *str1 = [str substringFromIndex:range.location+range.length];
                if([str1 isEqualToString:@"3"]){
//                    SmartLinkStep2ViewController *sls2vc=[[SmartLinkStep2ViewController alloc]init];
//                    sls2vc.typeStr=@"3";
//                    sls2vc.returnPageNum = _returnPageNum;
//                    [self.navigationController pushViewController:sls2vc animated:NO];
                }
            }else
                isScaning = NO;
        }else{
//            NSString *tempStr;
//            if(str.length >5)
//                tempStr=[str substringToIndex:5];
//            if([tempStr isEqualToString:@"0117C"]){
//                NSArray *arr=[str componentsSeparatedByString:@"|"];
//                tempStr=[NSString stringWithFormat:@"%@%@",[arr objectAtIndex:0],[arr objectAtIndex:2]];
//                NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithObjects:@[@"6",tempStr,@"YZS-010A"] forKeys:@[@"regWay",@"value",@"productModel"]];
//                LineStep1ViewController *ls1vc=[[LineStep1ViewController alloc]init];
//                ls1vc.coorDict=dict;
//                ls1vc.returnPageNum = _returnPageNum;
//                [self.navigationController pushViewController:ls1vc animated:YES];
//            }else{
//                BOOL isold;
//                if([str length] == 19)
//                    isold = YES;
//                else
//                    isold = NO;
//                [THCoorAddHelper getCoorRegisterWay:str sucess:^(int result, NSDictionary *addInfoDict, NSString *message) {
//                    NSMutableDictionary *dict=[addInfoDict mutableCopy];
//                    if(result == THUrlResposeSucess){
//                        LineStep1ViewController *ls1vc=[[LineStep1ViewController alloc]init];
//                        ls1vc.coorDict=dict;
//                        ls1vc.isOld=isold;
//                        ls1vc.codeStr =str;
//                        ls1vc.returnPageNum = _returnPageNum;
//                        [self.navigationController pushViewController:ls1vc animated:YES];
//                    }else{
//                        [self showAlertView:result];
//                    }
//                } fail:^(NSError *error) {
//                    [self showAlertView:THUrlResposeErrorFail];
//                }];
//            }
        }
    }
}

-(void)touchLight:(UIButton *)bt{
//    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    isLight=!isLight;
    [self setLightButtonShow];
}

-(void)setLightButtonShow{
    if(isLight){
        [_device lockForConfiguration:nil];
        if([_device isTorchModeSupported:AVCaptureTorchModeOn]){
            [_device setTorchMode: AVCaptureTorchModeOn];
        }
        [_device lockForConfiguration:nil];
        [lightButton setImage:[UIImage imageNamed:@"button_smjs"] forState:UIControlStateNormal];
        [lightButton setImage:[UIImage imageNamed:@"button_smjs"] forState:UIControlStateHighlighted];
        [_device unlockForConfiguration];
    }else{
        [_device lockForConfiguration:nil];
        if([_device isTorchModeSupported:AVCaptureTorchModeOff]){
            [_device setTorchMode: AVCaptureTorchModeOff];
        }
        [_device lockForConfiguration:nil];
        [lightButton setImage:[UIImage imageNamed:@"button_smsgd"] forState:UIControlStateNormal];
        [lightButton setImage:[UIImage imageNamed:@"button_smsgd"] forState:UIControlStateHighlighted];
        [_device unlockForConfiguration];
    }
}


- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}

-(void)setRoomNo:(NSString *)roomNo{
//    [UserDataOperate setCoorAddRoom:roomNo];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *title=[actionSheet buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"SmartLink"]){
//        SmartLinkStep2ViewController *sls2vc=[[SmartLinkStep2ViewController alloc]init];
//        sls2vc.returnPageNum = _returnPageNum;
//        [self.navigationController pushViewController:sls2vc animated:YES];
    }else if([title isEqualToString:@"SmartAP"]){
//        APStep2ViewController *ap = [[APStep2ViewController alloc]init];
//        ap.returnPageNum = _returnPageNum;
//        [self.navigationController pushViewController:ap animated:YES];
    }else if([title isEqualToString:@"手动输入"]){
        //手动输入
//        ImportViewController *ivc=[[ImportViewController alloc]init];
//        ivc.returnPageNum  = _returnPageNum;
//        [self.navigationController pushViewController:ivc animated:YES];
    }
}

#pragma mark ---------pravite method
-(void)gotoYsvideo:(NSString *)str{
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
}

-(void)showAlertView:(int)result{
//    NSString *errorInfo=[THLibStaticDB DPLocalizedString:[NSString stringWithFormat:@"NetError_%d",result]];
     NSString *errorInfo=@"网络错误";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:errorInfo preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        isScaning = NO;
    }];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}



@end
