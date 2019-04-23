//
//  QRCodeViewViewController.h
//  ThinkHome
//
//  Created by ThinkHome on 15/1/4.
//  Copyright (c) 2015年 ThinkHome. All rights reserved.
//  二维码界面
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "THViewController.h"
typedef void(^QRScanBlock) (NSMutableDictionary * dict1);
@interface QRCodeVC : THViewController<AVCaptureMetadataOutputObjectsDelegate>{
    BOOL isLight;
}


@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;
@property (nonatomic, retain) UIImageView * line;
@property (nonatomic,assign) BOOL canImport;
@property (nonatomic,assign) int returnPageNum;
@property (retain,nonatomic) NSString* roomNo;
@property (assign,nonatomic) BOOL isYsDevice;
@property (nonatomic,copy)QRScanBlock blocks;
@end
