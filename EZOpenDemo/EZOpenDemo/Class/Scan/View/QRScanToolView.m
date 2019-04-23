//
//  QRScanToolView.m
//  ThinkHome
//
//  Created by ThinkHome on 16/1/4.
//  Copyright © 2016年 ThinkHome. All rights reserved.
//

#import "QRScanToolView.h"

@interface QRScanToolView ()

@end

@implementation QRScanToolView

-(BOOL)setupCamera:(id)target{
    self.session = [[AVCaptureSession alloc]init];
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    // Device
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    if ([_session canAddInput:input])
    {
        [_session addInput:input];
    }else
        return NO;
    // Output
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc]init];
    [output setMetadataObjectsDelegate:target queue:dispatch_queue_create("com.VideoQueue", NULL)];
    if ([_session canAddOutput:output])
    {
        [_session addOutput:output];
    }else
        return NO;
    // 条码类型 AVMetadataObjectTypeQRCode
    output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
    return YES;
}

-(void)startScan{
    if(![_session isRunning]){
        dispatch_async(dispatch_queue_create("com.VideoQueue", NULL), ^{
            [_session startRunning];
        });
    }
}

-(void)stopScan{
    if([_session isRunning])
       [_session stopRunning];
}

@end
