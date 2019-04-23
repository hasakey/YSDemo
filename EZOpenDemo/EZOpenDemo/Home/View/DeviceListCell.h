//
//  CameraListCell.h
//  EZOpenSDKDemo
//
//  Created by DeJohn Dong on 15/10/27.
//  Copyright © 2015年 hikvision. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EZOpenSDKFramework/EZOpenSDKFramework.h>

@interface DeviceListCell : UITableViewCell
{
    EZDeviceInfo *_deviceInfo;
}

@property (nonatomic, strong) UIImageView *cameraImageView;
@property (nonatomic, strong)UIButton *playButton;
@property (nonatomic, strong)UIButton *recordButton;
@property (nonatomic, strong)UIButton *messageButton;
@property (nonatomic, strong)UIButton *settingButton;
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UIImageView *offlineIcon;

@property (nonatomic, weak) UIViewController *parentViewController;

@property (nonatomic) BOOL isShared;

-(instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setDeviceInfo:(EZDeviceInfo *)deviceInfo;

@end
