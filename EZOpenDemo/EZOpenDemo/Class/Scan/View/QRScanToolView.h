//
//  QRScanToolView.h
//  ThinkHome
//
//  Created by ThinkHome on 16/1/4.
//  Copyright © 2016年 ThinkHome. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface QRScanToolView : UIView

@property (nonatomic,strong) AVCaptureSession *session;

-(BOOL)setupCamera:(id)target;

-(void)startScan;

-(void)stopScan;

@end
