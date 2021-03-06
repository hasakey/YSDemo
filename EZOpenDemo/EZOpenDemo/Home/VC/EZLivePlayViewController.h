//
//  EZLivePlayViewController.h
//  EZOpenSDKDemo
//
//  Created by DeJohn Dong on 15/10/28.
//  Copyright © 2015年 hikvision. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EZOpenSDKFramework/EZOpenSDKFramework.h>
#import "THViewController.h"

@interface EZLivePlayViewController : THViewController

@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) EZDeviceInfo *deviceInfo;
@property (nonatomic) NSInteger cameraIndex;

- (void)imageSavedToPhotosAlbum:(UIImage *)image
       didFinishSavingWithError:(NSError *)error
                    contextInfo:(void *)contextInfo;

@end
