//
//  CloudVdeoVC.h
//  EZOpenDemo
//
//  Created by will on 2019/4/9.
//  Copyright © 2019 will. All rights reserved.
//

#import "THViewController.h"
#import <EZOpenSDKFramework/EZOpenSDKFramework.h>



@interface CloudVdeoVC : THViewController

@property (nonatomic, strong) EZDeviceInfo *deviceInfo;

@property (nonatomic) NSInteger cameraIndex;

@end


