//
//  CameraListCell.m
//  EZOpenSDKDemo
//
//  Created by DeJohn Dong on 15/10/27.
//  Copyright © 2015年 hikvision. All rights reserved.
//

#import "DeviceListCell.h"
//#import "DDKit.h"

#import <UIImageView+WebCache.h>
#import "THYSUrl.h"
#import "CloudVdeoVC.h"

//#import "EZLivePlayViewController.h"

@interface DeviceListCell()

@property (nonatomic, strong)UIButton *auditoryLocalization;

@property (nonatomic, strong)UIButton *movementRecorderButton;

@property (nonatomic, strong)UIButton *microphoneButton;

@property (nonatomic, strong)UIButton *cloudVdeoButton;



@end


@implementation DeviceListCell

-(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *CellIdentifier = @"Cellss";
    DeviceListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cellss"];
    if (cell == nil) {
        cell = [[DeviceListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self setupSubviews];
//        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

-(void)setupSubviews{
    [self addSubview:self.cameraImageView];
    [self addSubview:self.auditoryLocalization];
    [self addSubview:self.movementRecorderButton];
    [self addSubview:self.microphoneButton];
    [self addSubview:self.cloudVdeoButton];
}

- (void)setDeviceInfo:(EZDeviceInfo *)deviceInfo
{
    NSLog(@"deviceInfo is %@", deviceInfo);
    _deviceInfo = deviceInfo;
    
    if (_deviceInfo.status == 1)
    {
        self.offlineIcon.hidden = YES;
    }
    else
    {
        self.offlineIcon.hidden = NO;
    }
    self.nameLabel.text = [NSString stringWithFormat:@"%@",deviceInfo.deviceName];
    [self.cameraImageView sd_setImageWithURL:[NSURL URLWithString:deviceInfo.deviceCover] placeholderImage:nil];
//    [EZOPENSDK capturePicture:cameraInfo.deviceSerial channelNo:cameraInfo.channelNo completion:^(NSString *url, NSError *error) {
//        if(!error){
//            [self.cameraImageView sd_setImageWithURL:[NSURL URLWithString:url]];
//        }
//    }];
    
    self.messageButton.hidden = NO;
    self.settingButton.hidden = NO;
    if (self.isShared)
    {
        self.messageButton.hidden = YES;
        self.settingButton.hidden = YES;
    }
//    [self.contentView dd_addSeparatorWithType:ViewSeparatorTypeBottom];
}

//- (void)go2Play:(id)sender
//{
//    EZLivePlayViewController *vc = [EZLivePlayViewController new];
//    [self.parentViewController.navigationController pushViewController:vc animated:NO];
//    [self.parentViewController performSelector:@selector(go2Play:) withObject:_deviceInfo];
//}
//
//- (IBAction)go2Record:(id)sender
//{
//    [self.parentViewController performSelector:@selector(go2Record:) withObject:_deviceInfo];
//}
//
//- (IBAction)go2Setting:(id)sender
//{
//    [self.parentViewController performSelector:@selector(go2Setting:) withObject:_deviceInfo];
//}
//
//- (IBAction)go2Message:(id)sender
//{
//    [self.parentViewController performSelector:@selector(go2Message:) withObject:_deviceInfo];
//}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"touches = %@, event = %@", touches, event);
//}

-(void)localizationNetWork{
    THYSUrl *tool = [THYSUrl new];
    NSDictionary *urlDict = @{
                              @"enable":@"0"
                              };
    [tool setSSLStatusParam:urlDict Success:^(id  _Nonnull responseObject) {
        NSLog(@"SSLStatus : %@",responseObject);
    }];
}


-(void)movementRecorderAction{
    THYSUrl *tool = [THYSUrl new];
    NSDictionary *urlDict = @{
                              @"enable":@"0"
                              };
    [tool setMobileStatusParam:urlDict Success:^(id  _Nonnull responseObject) {
        NSLog(@"SSLStatus : %@",responseObject);
    }];
}


-(void)microphoneAction{
    THYSUrl *tool = [THYSUrl new];
    NSDictionary *urlDict = @{
                              @"enable":@"0"
                              };
    [tool setMicrophoneParam:urlDict Success:^(id  _Nonnull responseObject) {
        NSLog(@"SSLStatus : %@",responseObject);
    }];
}

-(void)cloudVdeoAction{
    CloudVdeoVC * vc = [CloudVdeoVC new];
    [self.parentViewController.navigationController pushViewController:vc animated:YES];
    
}



#pragma mark    set/get
-(UIImageView *)cameraImageView{
    if (!_cameraImageView) {
        _cameraImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 100, 60)];
        _cameraImageView.userInteractionEnabled = YES;
        //点击手势
//        UITapGestureRecognizer *r5 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(go2Play:)];
//        r5.numberOfTapsRequired = 1;
//        [_cameraImageView addGestureRecognizer:r5];
    }
    return _cameraImageView;
}

-(UIButton *)recordButton{
    if (!_recordButton) {
        _recordButton = [UIButton new];
    }
    return _recordButton;
}

-(UIButton *)playButton{
    if (!_playButton) {
        _playButton = [UIButton new];
    }
    return _playButton;
}

-(UIButton *)messageButton{
    if (!_messageButton) {
        _messageButton = [UIButton new];
    }
    return _messageButton;
}

-(UIButton *)settingButton{
    if (!_settingButton) {
        _settingButton = [UIButton new];
    }
    return _settingButton;
}


-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
    }
    return _nameLabel;
}


-(UIImageView *)offlineIcon{
    if (!_offlineIcon) {
        _offlineIcon = [UIImageView new];
    }
    return _offlineIcon;
}

-(UIButton *)auditoryLocalization{
    if (!_auditoryLocalization) {
        _auditoryLocalization = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_cameraImageView.frame) + 10,200 , 40)];
        [_auditoryLocalization setTitle:@"设置声源定位" forState:UIControlStateNormal];
        [_auditoryLocalization addTarget:self action:@selector(localizationNetWork) forControlEvents:UIControlEventTouchUpInside];
        _auditoryLocalization.backgroundColor = [UIColor redColor];
    }
    return _auditoryLocalization;
}

-(UIButton *)movementRecorderButton{
    if (!_movementRecorderButton) {
        _movementRecorderButton = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_auditoryLocalization.frame) + 10,200 , 40)];
        [_movementRecorderButton setTitle:@"设置设备移动跟踪开关" forState:UIControlStateNormal];
        [_movementRecorderButton addTarget:self action:@selector(movementRecorderAction) forControlEvents:UIControlEventTouchUpInside];
        _movementRecorderButton.backgroundColor = [UIColor redColor];
    }
    return _movementRecorderButton;
}

-(UIButton *)microphoneButton{
    if (!_microphoneButton) {
        _microphoneButton = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_movementRecorderButton.frame) + 10,200 , 40)];
        [_microphoneButton setTitle:@"设置麦克风开关" forState:UIControlStateNormal];
        [_microphoneButton addTarget:self action:@selector(microphoneAction) forControlEvents:UIControlEventTouchUpInside];
        _microphoneButton.backgroundColor = [UIColor redColor];
    }
    return _microphoneButton;
}

-(UIButton *)cloudVdeoButton{
    if (!_cloudVdeoButton) {
        _cloudVdeoButton = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_microphoneButton.frame) + 10,200 , 40)];
        [_cloudVdeoButton setTitle:@"云视频播放" forState:UIControlStateNormal];
        [_cloudVdeoButton addTarget:self action:@selector(microphoneAction) forControlEvents:UIControlEventTouchUpInside];
        _cloudVdeoButton.backgroundColor = [UIColor redColor];
    }
    return _cloudVdeoButton;
}

@end
