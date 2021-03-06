//
//  EZLivePlayViewController.m
//  EZOpenSDKDemo
//
//  Created by DeJohn Dong on 15/10/28.
//  Copyright © 2015年 hikvision. All rights reserved.
//

#define EZOPENSDK [EZOpenSDK class]
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

#import "EZLivePlayViewController.h"
#import <sys/sysctl.h>
#import <mach/mach.h>
#import <Photos/Photos.h>
#import "UIViewController+EZBackPop.h"
#import <EZOpenSDKFramework/EZOpenSDKFramework.h>
//#import "EZPlayer.h"
#import "DDKit.h"
#import "Masonry.h"
#import "HIKLoadView.h"
#import "MBProgressHUD.h"
//#import "EZCameraInfo.h"
#import <AVFoundation/AVFoundation.h>
#import "Toast+UIView.h"
#import "GlobalKit.h"
//#import "EZLivePlayViewController.h"


@interface EZLivePlayViewController ()<EZPlayerDelegate, UIAlertViewDelegate>
{
    NSOperation *op;
    BOOL _isPressed;
}

@property (nonatomic) BOOL isOpenSound;
@property (nonatomic) BOOL isPlaying;
@property (nonatomic, strong) NSTimer *recordTimer;
@property (nonatomic) NSTimeInterval seconds;
@property (nonatomic, strong) CALayer *orangeLayer;
@property (nonatomic, copy) NSString *filePath;
@property (nonatomic, strong) EZPlayer *player;
@property (nonatomic, strong) EZPlayer *talkPlayer;
@property (nonatomic) BOOL isStartingTalk;

@property (nonatomic, strong) HIKLoadView *loadingView;
//中间播放的大的播放按钮
@property (nonatomic, strong) UIButton *playerPlayButton;
//左上角返回按钮
@property (nonatomic, strong) UIButton *largeBackButton;

@property (nonatomic, strong) UIView *playerView;

//下面的view
@property (nonatomic, strong) UIView *bottomView;
//萤石位置
@property (nonatomic, strong) UIButton *controlButton;
//对讲功能
@property (nonatomic, strong) UIButton *talkButton;
//截屏功能
@property (nonatomic, strong) UIButton *captureButton;
//录像功能
@property (nonatomic, strong) UIButton *localRecordButton;

//toolBar
@property (nonatomic, strong) UIView *toolBar;
@property (nonatomic, strong) UIButton *playButton;
@property (nonatomic, strong) UIButton *voiceButton;
//占位用的没有别的作用
@property (nonatomic, strong) UIButton *emptyButton;
@property (nonatomic, strong) UIButton *largeButton;
//视频质量
@property (nonatomic, strong) UIButton *qualityButton;
@property (nonatomic, strong) UIView *qualityView;
@property (nonatomic, strong) UIButton *highButton;
@property (nonatomic, strong) UIButton *middleButton;
@property (nonatomic, strong) UIButton *lowButton;


@property (nonatomic, strong) UIView *ptzView;
@property (nonatomic, strong) UIButton *ptzCloseButton;
@property (nonatomic, strong) UIButton *ptzControlButton;
@property (nonatomic, strong) UIButton *ptzUpButton;
@property (nonatomic, strong) UIButton *ptzLeftButton;
@property (nonatomic, strong) UIButton *ptzDownButton;
@property (nonatomic, strong) UIButton *ptzRightButton;

//对讲界面
@property (nonatomic, strong) UIView *talkView;
@property (nonatomic, strong) UIButton *talkCloseButton;
@property (nonatomic, strong) UIImageView *speakImageView;


//@property (nonatomic, weak) IBOutlet NSLayoutConstraint *ptzViewContraint;

@property (nonatomic, strong) UILabel *localRecordLabel;

//@property (nonatomic, weak) IBOutlet NSLayoutConstraint *talkViewContraint;

@property (nonatomic, strong) UILabel *largeTitleLabel;

//@property (nonatomic, weak) IBOutlet NSLayoutConstraint *localRecrodContraint;
@property (nonatomic, strong) UILabel *messageLabel;


@property (nonatomic, strong) NSMutableData *fileData;
@property (nonatomic, weak) MBProgressHUD *voiceHud;
@property (nonatomic, strong) EZCameraInfo *cameraInfo;



@end

@implementation EZLivePlayViewController

- (void)dealloc
{
    NSLog(@"%@ dealloc", self.class);
    [EZOPENSDK releasePlayer:_player];
    [EZOPENSDK releasePlayer:_talkPlayer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = _deviceInfo.deviceName;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.titleView.title setTitle:@"视频" forState:UIControlStateNormal];
    
    [self setUI];
    self.largeTitleLabel.text = self.title;
    
    self.isAutorotate = YES;
    self.isStartingTalk = NO;
    self.ptzView.hidden = YES;
    self.talkView.hidden = YES;
    
    self.talkButton.enabled = self.deviceInfo.isSupportTalk;
    self.controlButton.enabled = self.deviceInfo.isSupportPTZ;
    self.captureButton.enabled = NO;
    self.localRecordButton.enabled = NO;
    
    
//    _url = @"rtsp://183.136.184.33:8554/demo://544542032:1:1:1:0:183.136.184.7:6500";
    
//    _url = @"ysproto://122.225.228.217:8554/live?dev=501694318&chn=1&stream=2&cln=1&isp=0&biz=3";
    
    if (_url)
    {
        _player = [EZOPENSDK createPlayerWithUrl:_url];
    }
    else
    {
        _cameraInfo = [self.deviceInfo.cameraInfo dd_objectAtIndex:_cameraIndex];
        _player = [EZOPENSDK createPlayerWithDeviceSerial:_cameraInfo.deviceSerial cameraNo:_cameraInfo.cameraNo];
//        _player.backgroundModeByPlayer = NO;
        _talkPlayer = [EZOPENSDK createPlayerWithDeviceSerial:_cameraInfo.deviceSerial cameraNo:_cameraInfo.cameraNo];
//        _player = [EZOPENSDK createPlayerWithDeviceSerial:info.deviceSerial cameraNo:info.cameraNo streamType:1];
        if (_cameraInfo.videoLevel == 2)
        {
            [self.qualityButton setTitle:@"高清" forState:UIControlStateNormal];
        }
        else if (_cameraInfo.videoLevel == 1)
        {
            [self.qualityButton setTitle:@"均衡" forState:UIControlStateNormal];
        }
        else
        {
            [self.qualityButton setTitle:@"流畅" forState:UIControlStateNormal];
        }
    }
    
#if DEBUG
    if (!_url)
    {
        //抓图接口演示代码
        [EZOPENSDK captureCamera:_cameraInfo.deviceSerial cameraNo:_cameraInfo.cameraNo completion:^(NSString *url, NSError *error) {
            NSLog(@"[%@] capture cameraNo is [%d] url is %@, error is %@", _cameraInfo.deviceSerial, (int)_cameraInfo.cameraNo, url, error);
        }];
    }
#endif
    
    _player.delegate = self;
    _talkPlayer.delegate = self;
    //判断设备是否加密，加密就从demo的内存中获取设备验证码填入到播放器的验证码接口里，本demo只处理内存存储，本地持久化存储用户自行完成
    if (self.deviceInfo.isEncrypt)
    {
        NSString *verifyCode = [[GlobalKit shareKit].deviceVerifyCodeBySerial objectForKey:self.deviceInfo.deviceSerial];
        [_player setPlayVerifyCode:verifyCode];
        [_talkPlayer setPlayVerifyCode:verifyCode];
    }
    [_player setPlayerView:_playerView];
    [_player startRealPlay];
    
    if(!_loadingView)
        _loadingView = [[HIKLoadView alloc] initWithHIKLoadViewStyle:HIKLoadViewStyleSqureClockWise];
    [self.view insertSubview:_loadingView aboveSubview:self.playerView];
    [_loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(@14);
        make.centerX.mas_equalTo(self.playerView.mas_centerX);
        make.centerY.mas_equalTo(self.playerView.mas_centerY);
    }];
    [self.loadingView startSquareClcokwiseAnimation];
    
    self.largeBackButton.hidden = YES;
    _isOpenSound = YES;
    
    [self.controlButton dd_centerImageAndTitle];
    [self.talkButton dd_centerImageAndTitle];
    [self.captureButton dd_centerImageAndTitle];
    [self.localRecordButton dd_centerImageAndTitle];
    
    [self.voiceButton setImage:[UIImage imageNamed:@"preview_unvoice_btn_sel"] forState:UIControlStateHighlighted];
    [self addLine];
    
    self.localRecordLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    self.localRecordLabel.layer.cornerRadius = 12.0f;
    self.localRecordLabel.layer.borderWidth = 1.0f;
    self.localRecordLabel.clipsToBounds = YES;
    self.playButton.enabled = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideQualityView) object:nil];
    //结束本地录像
    if(self.localRecordButton.selected)
    {
        [_player stopLocalRecord];
        [self.fileData writeToFile:_filePath atomically:YES];
        self.localRecordLabel.hidden = YES;
        [_recordTimer invalidate];
        _recordTimer = nil;
        [self saveRecordToPhotosAlbum:_filePath];
    }
    

    NSLog(@"viewWillDisappear");
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"viewDidDisappear");
    [super viewDidDisappear:animated];
    [_player stopRealPlay];
    if (_talkPlayer)
    {
        [_talkPlayer stopVoiceTalk];
    }
}

#pragma mark    privateMethods
-(void)setUI{
    [self.view addSubview:self.playerView];
    [self.view addSubview:self.playerPlayButton];
    
    [self.view addSubview:self.toolBar];
    [self.toolBar addSubview:self.playButton];
    [self.toolBar addSubview:self.voiceButton];
    [self.toolBar addSubview:self.qualityButton];
    [self.toolBar addSubview:self.emptyButton];
    [self.toolBar addSubview:self.largeButton];
    [self.view addSubview:self.qualityView];
    [self.qualityView addSubview:self.highButton];
    [self.qualityView addSubview:self.middleButton];
    [self.qualityView addSubview:self.lowButton];
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.controlButton];
    [self.bottomView addSubview:self.talkButton];
    [self.bottomView addSubview:self.captureButton];
    [self.bottomView addSubview:self.localRecordButton];
    [self.bottomView addSubview:self.ptzView];
    [self.ptzView addSubview:self.ptzCloseButton];
    [self.ptzView addSubview:self.ptzControlButton];
    [self.ptzView addSubview:self.ptzUpButton];
    [self.ptzView addSubview:self.ptzLeftButton];
    [self.ptzView addSubview:self.ptzDownButton];
    [self.ptzView addSubview:self.ptzRightButton];
    [self.bottomView addSubview:self.talkView];
    [self.talkView addSubview:self.talkCloseButton];
    [self.talkView addSubview:self.speakImageView];
    
    [self.view addSubview:self.largeTitleLabel];
    [self.view addSubview:self.localRecordLabel];
    [self.view addSubview:self.messageLabel];
    [self.view addSubview:self.largeBackButton];
}


- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration
{
    self.navigationController.navigationBarHidden = NO;
    self.toolBar.hidden = NO;
    self.largeBackButton.hidden = YES;
    self.bottomView.hidden = NO;
    self.largeTitleLabel.hidden = YES;
//    self.localRecrodContraint.constant = 10;
    if(toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
       toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        self.navigationController.navigationBarHidden = YES;
//        self.localRecrodContraint.constant = 50;
        self.toolBar.hidden = YES;
        self.largeTitleLabel.hidden = NO;
        self.largeBackButton.hidden = NO;
        self.bottomView.hidden = YES;
    }
}


#pragma mark - UIAlertViewDelegate Methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.alertViewStyle == UIAlertViewStyleSecureTextInput)
    {
        if (buttonIndex == 1)
        {
            NSString *checkCode = [alertView textFieldAtIndex:0].text;
            [[GlobalKit shareKit].deviceVerifyCodeBySerial setValue:checkCode forKey:self.deviceInfo.deviceSerial];
            if (!self.isStartingTalk)
            {
                [self.player setPlayVerifyCode:checkCode];
                [self.player startRealPlay];
            }
            else
            {
                [self.talkPlayer setPlayVerifyCode:checkCode];
                [self.talkPlayer startVoiceTalk];
            }
        }
    }
    else
    {
        if (buttonIndex == 1)
        {
            [self showSetPassword];
            return;
        }
    }
}

#pragma mark - PlayerDelegate Methods

- (void)player:(EZPlayer *)player didReceivedDataLength:(NSInteger)dataLength
{
    CGFloat value = dataLength/1024.0;
    NSString *fromatStr = @"%.1f KB/s";
    if (value > 1024)
    {
        value = value/1024;
        fromatStr = @"%.1f MB/s";
    }

    [_emptyButton setTitle:[NSString stringWithFormat:fromatStr,value] forState:UIControlStateNormal];
}


- (void)player:(EZPlayer *)player didPlayFailed:(NSError *)error
{
    NSLog(@"player: %@, didPlayFailed: %@", player, error);
    //如果是需要验证码或者是验证码错误
    if (error.code == EZ_SDK_NEED_VALIDATECODE) {
        [self showSetPassword];
        return;
    } else if (error.code == EZ_SDK_VALIDATECODE_NOT_MATCH) {
        [self showRetry];
        return;
    } else if (error.code == EZ_SDK_NOT_SUPPORT_TALK) {
        [UIView dd_showDetailMessage:[NSString stringWithFormat:@"%d", (int)error.code]];
        [self.voiceHud hide:YES];
        return;
    }
    else
    {
        if ([player isEqual:_player])
        {
            [_player stopRealPlay];
        }
        else
        {
            [_talkPlayer stopVoiceTalk];
        }
    }
    
    [UIView dd_showDetailMessage:[NSString stringWithFormat:@"%d", (int)error.code]];
    [self.voiceHud hide:YES];
    [self.loadingView stopSquareClockwiseAnimation];
    self.messageLabel.text = [NSString stringWithFormat:@"%@(%d)",NSLocalizedString(@"device_play_fail", @"播放失败"), (int)error.code];
//    if (error.code > 370000)
    {
        self.messageLabel.hidden = NO;
    }
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.speakImageView.alpha = 0.0;
//                         self.talkViewContraint.constant = self.bottomView.frame.size.height;
                         [self.bottomView setNeedsUpdateConstraints];
                         [self.bottomView layoutIfNeeded];
                     }
                     completion:^(BOOL finished) {
                         self.speakImageView.alpha = 0;
                         self.talkView.hidden = YES;
                     }];
}

- (void)player:(EZPlayer *)player didReceivedMessage:(NSInteger)messageCode
{
    NSLog(@"player: %@, didReceivedMessage: %d", player, (int)messageCode);
    if (messageCode == PLAYER_REALPLAY_START)
    {
        self.captureButton.enabled = YES;
        self.localRecordButton.enabled = YES;
        [self.loadingView stopSquareClockwiseAnimation];
        self.playButton.enabled = YES;
        [self.playButton setImage:[UIImage imageNamed:@"preview_stopplay_btn_sel"] forState:UIControlStateHighlighted];
        [self.playButton setImage:[UIImage imageNamed:@"preview_stopplay_btn"] forState:UIControlStateNormal];
        _isPlaying = YES;
        
        if (!_isOpenSound)
        {
            [_player closeSound];
        }
        self.messageLabel.hidden = YES;
    }
    else if(messageCode == PLAYER_VOICE_TALK_START)
    {
        self.messageLabel.hidden = YES;
        [_player closeSound];
        self.isStartingTalk = NO;
        [self.voiceHud hide:YES];
        [self.bottomView bringSubviewToFront:self.talkView];
        self.talkView.hidden = NO;
        self.speakImageView.alpha = 0;
        self.speakImageView.highlighted = self.deviceInfo.isSupportTalk == 1;
        self.speakImageView.userInteractionEnabled = self.deviceInfo.isSupportTalk == 3;
        [UIView animateWithDuration:0.3
                         animations:^{
//                             self.talkViewContraint.constant = 0;
                             self.speakImageView.alpha = 1.0;
                             [self.bottomView setNeedsUpdateConstraints];
                             [self.bottomView layoutIfNeeded];
                         }
                         completion:^(BOOL finished) {
                         }];
    }
    else if (messageCode == PLAYER_VOICE_TALK_END)
    {
        //对讲结束开启声音
        [_player openSound];
    }
    else if (messageCode == PLAYER_NET_CHANGED)
    {
        [_player stopRealPlay];
        [_player startRealPlay];
    }
}

#pragma mark - ValidateCode Methods

- (void)showSetPassword
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"device_input_verify_code", @"请输入视频图片加密密码")
                                                        message:NSLocalizedString(@"device_verify_code_tip", @"您的视频已加密，请输入密码进行查看，初始密码为机身标签上的验证码，如果没有验证码，请输入ABCDEF（密码区分大小写)")
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"cancel", @"取消")
                                              otherButtonTitles:NSLocalizedString(@"done", @"确定"), nil];
    alertView.alertViewStyle = UIAlertViewStyleSecureTextInput;
    [alertView show];
}

- (void)showRetry
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"device_tip_title", @"温馨提示")
                                                        message:NSLocalizedString(@"device_verify_code_wrong", @"设备密码错误")
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"cancel", @"取消")
                                              otherButtonTitles:NSLocalizedString(@"retry", @"重试"), nil];
    [alertView show];
}

#pragma mark - Action Methods

- (void)large:(id)sender
{
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
}


- (void)largeBack:(id)sender
{
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
}

- (void)capture:(id)sender
{
    UIImage *image = [_player capturePicture:100];
    [self saveImageToPhotosAlbum:image];
}

- (void)talkButtonClicked:(id)sender
{
    if (self.deviceInfo.isSupportTalk != 1 && self.deviceInfo.isSupportTalk != 3)
    {
        [self.view makeToast:NSLocalizedString(@"not_support_talk", @"设备不支持对讲")
                    duration:1.5
                    position:@"center"];
        return;
    }
    
    __weak EZLivePlayViewController *weakSelf = self;
    [self checkMicPermissionResult:^(BOOL enable) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (enable)
            {
                if (!weakSelf.voiceHud) {
                    weakSelf.voiceHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                }
                weakSelf.voiceHud.labelText = NSLocalizedString(@"device_restart_talk", @"正在开启对讲，请稍候...");
                weakSelf.isStartingTalk = YES;
                NSString *verifyCode = [[GlobalKit shareKit].deviceVerifyCodeBySerial objectForKey:weakSelf.deviceInfo.deviceSerial];
                if (verifyCode)
                {
                    [weakSelf.talkPlayer setPlayVerifyCode:verifyCode];
                }
                [weakSelf.talkPlayer startVoiceTalk];
            }
            else
            {
                [weakSelf.view makeToast:NSLocalizedString(@"no_mic_permission", @"未开启麦克风权限")
                                duration:1.5
                                position:@"center"];
            }
        });
    }];
    
    

}

- (void)voiceButtonClicked:(id)sender
{
    if(_isOpenSound){
        [_player closeSound];
        [self.voiceButton setImage:[UIImage imageNamed:@"preview_unvoice_btn_sel"] forState:UIControlStateHighlighted];
        [self.voiceButton setImage:[UIImage imageNamed:@"preview_unvoice_btn"] forState:UIControlStateNormal];
    }
    else
    {
        [_player openSound];
        [self.voiceButton setImage:[UIImage imageNamed:@"preview_voice_btn_sel"] forState:UIControlStateHighlighted];
        [self.voiceButton setImage:[UIImage imageNamed:@"preview_voice_btn"] forState:UIControlStateNormal];
    }
    _isOpenSound = !_isOpenSound;
}


- (void)playButtonClicked:(id)sender
{
    if(_isPlaying)
    {
        [_player stopRealPlay];
        [_playerView setBackgroundColor:[UIColor blackColor]];
        [self.playButton setImage:[UIImage imageNamed:@"preview_play_btn_sel"] forState:UIControlStateHighlighted];
        [self.playButton setImage:[UIImage imageNamed:@"preview_play_btn"] forState:UIControlStateNormal];
        self.localRecordButton.enabled = NO;
        self.captureButton.enabled = NO;
        self.playerPlayButton.hidden = NO;
    }
    else
    {
        [_player startRealPlay];
        self.playerPlayButton.hidden = YES;
        [self.playButton setImage:[UIImage imageNamed:@"preview_stopplay_btn_sel"] forState:UIControlStateHighlighted];
        [self.playButton setImage:[UIImage imageNamed:@"preview_stopplay_btn"] forState:UIControlStateNormal];
        [self.loadingView startSquareClcokwiseAnimation];
    }
    _isPlaying = !_isPlaying;
}

- (void)qualityButtonClicked:(id)sender
{
    if(self.qualityButton.selected)
    {
        self.qualityView.hidden = YES;
    }
    else
    {
        self.qualityView.hidden = NO;
        //停留5s以后隐藏视频质量View.
        [self performSelector:@selector(hideQualityView) withObject:nil afterDelay:5.0f];
    }
    self.qualityButton.selected = !self.qualityButton.selected;
}

- (void)hideQualityView
{
    self.qualityButton.selected = NO;
    self.qualityView.hidden = YES;
}

- (void)qualitySelectedClicked:(id)sender
{
    BOOL result = NO;
    EZVideoLevelType type = EZVideoLevelLow;
    if (sender == self.highButton)
    {
        type = EZVideoLevelHigh;
    }
    else if (sender == self.middleButton)
    {
        type = EZVideoLevelMiddle;
    }
    else
    {
        type = EZVideoLevelLow;
    }
    [EZOPENSDK setVideoLevel:_cameraInfo.deviceSerial
                    cameraNo:_cameraInfo.cameraNo
                  videoLevel:type
                  completion:^(NSError *error) {
                      if (error)
                      {
                          return;
                      }
                      [_player stopRealPlay];
                      
                      _cameraInfo.videoLevel = type;
                      if (sender == self.highButton)
                      {
                          [self.qualityButton setTitle:NSLocalizedString(@"device_quality_high", @"高清") forState:UIControlStateNormal];
                      }
                      else if (sender == self.middleButton)
                      {
                          [self.qualityButton setTitle:NSLocalizedString(@"device_quality_median", @"均衡") forState:UIControlStateNormal];
                      }
                      else
                      {
                          [self.qualityButton setTitle:NSLocalizedString(@"device_quality_low", @"流畅") forState:UIControlStateNormal];
                      }
                      if (result)
                      {
                          [self.loadingView startSquareClcokwiseAnimation];
                      }
                      self.qualityView.hidden = YES;
                      [_player startRealPlay];
                  }];
}

- (void)ptzControlButtonTouchDown:(id)sender
{
    EZPTZCommand command;
    NSString *imageName = nil;
    if(sender == self.ptzLeftButton)
    {
        command = EZPTZCommandLeft;
        imageName = @"ptz_left_sel";
    }
    else if (sender == self.ptzDownButton)
    {
        command = EZPTZCommandDown;
        imageName = @"ptz_bottom_sel";
    }
    else if (sender == self.ptzRightButton)
    {
        command = EZPTZCommandRight;
        imageName = @"ptz_right_sel";
    }
    else {
        command = EZPTZCommandUp;
        imageName = @"ptz_up_sel";
    }
    [self.ptzControlButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateDisabled];
    EZCameraInfo *cameraInfo = [_deviceInfo.cameraInfo firstObject];
    [EZOPENSDK controlPTZ:cameraInfo.deviceSerial
                 cameraNo:cameraInfo.cameraNo
                  command:command
                   action:EZPTZActionStart
                    speed:2
                   result:^(NSError *error) {
                       NSLog(@"error is %@", error);
                   }];
}

- (void)ptzControlButtonTouchUpInside:(id)sender
{
    EZPTZCommand command;
    if(sender == self.ptzLeftButton)
    {
        command = EZPTZCommandLeft;
    }
    else if (sender == self.ptzDownButton)
    {
        command = EZPTZCommandDown;
    }
    else if (sender == self.ptzRightButton)
    {
        command = EZPTZCommandRight;
    }
    else {
        command = EZPTZCommandUp;
    }
    [self.ptzControlButton setImage:[UIImage imageNamed:@"ptz_bg"] forState:UIControlStateDisabled];
    EZCameraInfo *cameraInfo = [_deviceInfo.cameraInfo firstObject];
    [EZOPENSDK controlPTZ:cameraInfo.deviceSerial
                 cameraNo:cameraInfo.cameraNo
                  command:command
                   action:EZPTZActionStop
                    speed:3.0
                   result:^(NSError *error) {
                   }];
}

- (void)ptzViewShow:(id)sender
{
    self.ptzView.hidden = NO;
    [self.bottomView bringSubviewToFront:self.ptzView];
    self.ptzControlButton.alpha = 0;
    [UIView animateWithDuration:0.3
                     animations:^{
//                         self.ptzViewContraint.constant = 0;
                         self.ptzControlButton.alpha = 1.0;
                         [self.bottomView setNeedsUpdateConstraints];
                         [self.bottomView layoutIfNeeded];
                     }
                     completion:^(BOOL finished) {
                     }];
}

- (void)closePtzView:(id)sender
{
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.ptzControlButton.alpha = 0.0;
//                         self.ptzViewContraint.constant = self.bottomView.frame.size.height;
                         [self.bottomView setNeedsUpdateConstraints];
                         [self.bottomView layoutIfNeeded];
                     }
                     completion:^(BOOL finished) {
                         self.ptzControlButton.alpha = 0;
                         self.ptzView.hidden = YES;
                     }];
}

- (void)closeTalkView:(id)sender
{
    [_talkPlayer stopVoiceTalk];
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.speakImageView.alpha = 0.0;
//                         self.talkViewContraint.constant = self.bottomView.frame.size.height;
                         [self.bottomView setNeedsUpdateConstraints];
                         [self.bottomView layoutIfNeeded];
                     }
                     completion:^(BOOL finished) {
                         self.speakImageView.alpha = 0;
                         self.talkView.hidden = YES;
                     }];
}

- (void)localButtonClicked:(id)sender
{

    //结束本地录像
    if(self.localRecordButton.selected)
    {
        [_player stopLocalRecord];
        [_recordTimer invalidate];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            _recordTimer = nil;
            [_fileData writeToFile:_filePath atomically:YES];
            self.localRecordLabel.hidden = YES;
            [self saveRecordToPhotosAlbum:_filePath];
            _filePath = nil;
        });
    }
    else
    {
        //开始本地录像
        NSString *path = @"/OpenSDK/EzvizLocalRecord";
        
        NSArray * docdirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString * docdir = [docdirs objectAtIndex:0];
        
        NSString * configFilePath = [docdir stringByAppendingPathComponent:path];
        if(![[NSFileManager defaultManager] fileExistsAtPath:configFilePath]){
            NSError *error = nil;
            [[NSFileManager defaultManager] createDirectoryAtPath:configFilePath
                                      withIntermediateDirectories:YES
                                                       attributes:nil
                                                            error:&error];
        }
        NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
        dateformatter.dateFormat = @"yyyyMMddHHmmssSSS";
        _filePath = [NSString stringWithFormat:@"%@/%@.mov",configFilePath,[dateformatter stringFromDate:[NSDate date]]];
        _fileData = [NSMutableData new];
 
        self.localRecordLabel.text = @"  00:00";

        __weak __typeof(self) weakSelf = self;
        [_player startLocalRecord:^(NSData *data) {
            if (!_recordTimer)
            {
                _recordTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerStart:) userInfo:nil repeats:YES];
            }
            if (!data || !weakSelf.fileData) {
                return;
            }
            [weakSelf.fileData appendData:data];
        }];
        self.localRecordLabel.hidden = NO;
        _seconds = 0;
    }
    self.localRecordButton.selected = !self.localRecordButton.selected;
}

- (void)timerStart:(NSTimer *)timer
{
    NSInteger currentTime = ++_seconds;
    self.localRecordLabel.text = [NSString stringWithFormat:@"  %02d:%02d", (int)currentTime/60, (int)currentTime % 60];
    if (!_orangeLayer)
    {
        _orangeLayer = [CALayer layer];
        _orangeLayer.frame = CGRectMake(10.0, 8.0, 8.0, 8.0);
        _orangeLayer.backgroundColor = [UIColor dd_hexStringToColor:@"0xff6000"].CGColor;
        _orangeLayer.cornerRadius = 4.0f;
    }
    if(currentTime % 2 == 0)
    {
        [_orangeLayer removeFromSuperlayer];
    }
    else
    {
        [self.localRecordLabel.layer addSublayer:_orangeLayer];
    }
}

- (IBAction)talkPressed:(id)sender
{
    if (!_isPressed)
    {
        self.speakImageView.highlighted = YES;
        [self.talkPlayer audioTalkPressed:YES];
    }
    else
    {
        self.speakImageView.highlighted = NO;
        [self.talkPlayer audioTalkPressed:NO];
    }
    _isPressed = !_isPressed;
}

#pragma mark - Private Methods

- (void) checkMicPermissionResult:(void(^)(BOOL enable)) retCb
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    
    switch (authStatus)
    {
        case AVAuthorizationStatusNotDetermined://未决
        {
            AVAudioSession *avSession = [AVAudioSession sharedInstance];
            [avSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
                if (granted)
                {
                    if (retCb)
                    {
                        retCb(YES);
                    }
                }
                else
                {
                    if (retCb)
                    {
                        retCb(NO);
                    }
                }
            }];
        }
            break;
            
        case AVAuthorizationStatusRestricted://未授权，家长限制
        case AVAuthorizationStatusDenied://未授权
            if (retCb)
            {
                retCb(NO);
            }
            break;
            
        case AVAuthorizationStatusAuthorized://已授权
            if (retCb)
            {
                retCb(YES);
            }
            break;
            
        default:
            if (retCb)
            {
                retCb(NO);
            }
            break;
    }
}

- (void)saveImageToPhotosAlbum:(UIImage *)savedImage
{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusNotDetermined)
    {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if(status == PHAuthorizationStatusAuthorized)
            {
                UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), NULL);
            }
        }];
    }
    else
    {
        if (status == PHAuthorizationStatusAuthorized)
        {
            UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), NULL);
        }
    }
}

- (void)saveRecordToPhotosAlbum:(NSString *)path
{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusNotDetermined)
    {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if(status == PHAuthorizationStatusAuthorized)
            {
                UISaveVideoAtPathToSavedPhotosAlbum(path, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), NULL);
            }
        }];
    }
    else
    {
        if (status == PHAuthorizationStatusAuthorized)
        {
            UISaveVideoAtPathToSavedPhotosAlbum(path, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), NULL);
        }
    }
}

// 指定回调方法
- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *message = nil;
    if (!error) {
        message = NSLocalizedString(@"device_save_gallery", @"已保存至手机相册");
    }
    else
    {
        message = [error description];
    }
    [UIView dd_showMessage:message];
}

- (void)addLine
{
    for (UIView *view in self.toolBar.subviews) {
        if ([view isKindOfClass:[UIImageView class]])
        {
            [view removeFromSuperview];
        }
    }
    CGFloat averageWidth = [UIScreen mainScreen].bounds.size.width/5.0;
    UIImageView *lineImageView1 = [UIView dd_instanceVerticalLine:20 color:[UIColor grayColor]];
    lineImageView1.frame = CGRectMake(averageWidth, 7, lineImageView1.frame.size.width, lineImageView1.frame.size.height);
    [self.toolBar addSubview:lineImageView1];
    UIImageView *lineImageView2 = [UIView dd_instanceVerticalLine:20 color:[UIColor grayColor]];
    lineImageView2.frame = CGRectMake(averageWidth * 2, 7, lineImageView2.frame.size.width, lineImageView2.frame.size.height);
    [self.toolBar addSubview:lineImageView2];
    UIImageView *lineImageView3 = [UIView dd_instanceVerticalLine:20 color:[UIColor grayColor]];
    lineImageView3.frame = CGRectMake(averageWidth * 3, 7, lineImageView3.frame.size.width, lineImageView3.frame.size.height);
    [self.toolBar addSubview:lineImageView3];
    UIImageView *lineImageView4 = [UIView dd_instanceVerticalLine:20 color:[UIColor grayColor]];
    lineImageView4.frame = CGRectMake(averageWidth * 4, 7, lineImageView4.frame.size.width, lineImageView4.frame.size.height);
    [self.toolBar addSubview:lineImageView4];
}

#pragma mark    get/set
//播放界面
-(UIView *)playerView{
    if (!_playerView) {
        _playerView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleView.frame), SCREEN_WIDTH, SCREEN_WIDTH/16*9)];
    }
    return _playerView;
}
//播放界面中很大的播放按钮
-(UIButton *)playerPlayButton{
    if (!_playerPlayButton) {
        _playerPlayButton = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 54)/2, (SCREEN_WIDTH/16*9 - 54)/2, 54, 54)];
        [_playerPlayButton addTarget:self action:@selector(playButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playerPlayButton;
}

-(UIButton *)largeBackButton{
    if (!_largeBackButton) {
        _largeBackButton = [[UIButton alloc] initWithFrame:CGRectMake(40, 100, 200, 200)];
        [_largeBackButton addTarget:self action:@selector(largeBack:) forControlEvents:UIControlEventTouchUpInside];
        _largeBackButton.backgroundColor = [UIColor redColor];;
    }
    return _largeBackButton;
}


-(UIView *)toolBar{
    if (!_toolBar) {
        _toolBar = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_WIDTH/16*9 + 100, SCREEN_WIDTH, 37)];
        _toolBar.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _toolBar;
}


-(UIButton *)playButton{
    if (!_playButton) {
        _playButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/5,37)];
        [_playButton addTarget:self action:@selector(playButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playButton;
}

-(UIButton *)voiceButton{
    if (!_voiceButton) {
        _voiceButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/5, 0, SCREEN_WIDTH/5, 37)];
        [_voiceButton addTarget:self action:@selector(voiceButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_voiceButton setImage:[UIImage imageNamed:@"preview_voice_btn"] forState:UIControlStateNormal];
    }
    
    return _voiceButton;
}

-(UIButton *)qualityButton{
    if (!_qualityButton) {
        _qualityButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/5*2, 0, SCREEN_WIDTH/5, 37)];
        [_qualityButton addTarget:self action:@selector(qualityButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_qualityButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_qualityButton setTitle:@"高清" forState:UIControlStateNormal];
    }
    return _qualityButton;
}

-(UIButton *)emptyButton{
    if (!_emptyButton) {
        _emptyButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/5*3, 0, SCREEN_WIDTH/5, 37)];
        [_emptyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _emptyButton;
}


-(UIButton *)largeButton{
    if (!_largeButton) {
        _largeButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/5*4, 0, SCREEN_WIDTH/5, 37)];
        [_largeButton addTarget:self action:@selector(large:) forControlEvents:UIControlEventTouchUpInside];
        [_largeButton setImage:[UIImage imageNamed:@"preview_enlarge"] forState:UIControlStateNormal];
        
    }
    return _largeButton;
}


-(UIView *)qualityView{
    if (!_qualityView) {
        _qualityView = [[UIView alloc] initWithFrame:CGRectMake(160, 0, 61, 93)];
        _qualityView.hidden = YES;
    }
    return _qualityView;
}

-(UIButton *)highButton{
    if (!_highButton) {
        _highButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 61, 31)];
        [_highButton addTarget:self action:@selector(qualitySelectedClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _highButton;
}

-(UIButton *)middleButton{
    if (!_middleButton) {
        _middleButton = [[UIButton alloc] initWithFrame:CGRectMake(31, 0, 61, 31)];
        [_middleButton addTarget:self action:@selector(qualitySelectedClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _middleButton;
}

-(UIButton *)lowButton{
    if (!_lowButton) {
        _lowButton = [[UIButton alloc] initWithFrame:CGRectMake(62, 0, 61, 31)];
        [_lowButton addTarget:self action:@selector(qualitySelectedClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lowButton;
}

-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_WIDTH/16*9 + 100 + 37, SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(_toolBar.frame))];
    }
    return _bottomView;
}

-(UIButton *)controlButton{
    if (!_controlButton) {
        _controlButton= [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 100, 100)];
        [_controlButton addTarget:self action:@selector(ptzViewShow:) forControlEvents:UIControlEventTouchUpInside];
        [_controlButton setImage:[UIImage imageNamed:@"preview_barrel"] forState:UIControlStateNormal];
        [_controlButton setTitle:@"云台" forState:UIControlStateNormal];
        [_controlButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _controlButton;
}

-(UIButton *)talkButton{
    if (!_talkButton) {
        _talkButton = [[UIButton alloc] initWithFrame:CGRectMake(200, 20, 100, 100)];
        [_talkButton addTarget:self action:@selector(talkButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_talkButton setImage:[UIImage imageNamed:@"preview_talkback"] forState:UIControlStateNormal];
        [_talkButton setTitle:@"对讲" forState:UIControlStateNormal];
        [_talkButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _talkButton;
}

-(UIButton *)captureButton{
    if (!_captureButton) {
        _captureButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 150, 100, 100)];
        [_captureButton addTarget:self action:@selector(capture:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _captureButton;
}


-(UIButton *)localRecordButton{
    if (!_localRecordButton) {
        _localRecordButton = [[UIButton alloc] initWithFrame:CGRectMake(200, 150, 100, 100)];
        [_localRecordButton addTarget:self action:@selector(localButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _localRecordButton;
}

-(UIView *)ptzView{
    if (!_ptzView) {
        _ptzView = [[UIView alloc] initWithFrame:_bottomView.bounds];
        _ptzView.backgroundColor = [UIColor whiteColor];
    }
    return _ptzView;
}


-(UIButton *)ptzCloseButton{
    if (!_ptzCloseButton) {
        _ptzCloseButton = [[UIButton alloc] initWithFrame:CGRectMake(_bottomView.bounds.size.width - 50, 0, 50, 50)];
        [_ptzCloseButton addTarget:self action:@selector(closePtzView:) forControlEvents:UIControlEventTouchUpInside];
        [_ptzCloseButton setImage:[UIImage imageNamed:@"play_close"] forState:UIControlStateNormal];
    }
    return _ptzCloseButton;
}

-(UIButton *)ptzControlButton{
    if (!_ptzControlButton) {
        _ptzControlButton = [[UIButton alloc] initWithFrame:CGRectMake(400, 0, 154, 154)];
        _ptzControlButton.center = _ptzView.center;
        [_ptzControlButton setImage:[UIImage imageNamed:@"ptz_bg"] forState:UIControlStateNormal];
    }
    return _ptzControlButton;
}


-(UIButton *)ptzUpButton{
    if (!_ptzUpButton) {
        _ptzUpButton = [[UIButton alloc] initWithFrame:CGRectMake(400, CGRectGetMinY(_ptzControlButton.frame), 50, 50)];
        _ptzUpButton.center = CGPointMake(_ptzControlButton.center.x, _ptzUpButton.center.y);
        [_ptzUpButton addTarget:self action:@selector(ptzControlButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [_ptzUpButton addTarget:self action:@selector(ptzControlButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
    }
    return _ptzUpButton;
}

-(UIButton *)ptzLeftButton{
    if (!_ptzLeftButton) {
        _ptzLeftButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(_ptzControlButton.frame), 0, 50, 50)];
        _ptzLeftButton.center = CGPointMake(_ptzLeftButton.center.x, _ptzControlButton.center.y);
        [_ptzLeftButton addTarget:self action:@selector(ptzControlButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [_ptzLeftButton addTarget:self action:@selector(ptzControlButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
    }
    return _ptzLeftButton;
}


-(UIButton *)ptzDownButton{
    if (!_ptzDownButton) {
        _ptzDownButton = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_ptzControlButton.frame) - 50, 50, 50)];
        _ptzDownButton.center = CGPointMake(_ptzControlButton.center.x, _ptzDownButton.center.y);
        [_ptzDownButton addTarget:self action:@selector(ptzControlButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [_ptzDownButton addTarget:self action:@selector(ptzControlButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
    }
    return _ptzDownButton;
}


-(UIButton *)ptzRightButton{
    if (!_ptzRightButton) {
        _ptzRightButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_ptzControlButton.frame) - 50, _bottomView.bounds.size.height - 50, 50, 50)];
        _ptzRightButton.center = CGPointMake(_ptzRightButton.center.x, _ptzControlButton.center.y);
        [_ptzRightButton addTarget:self action:@selector(ptzControlButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [_ptzRightButton addTarget:self action:@selector(ptzControlButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
    }
    return _ptzRightButton;
}

-(UIView *)talkView{
    if (!_talkView) {
        _talkView = [[UIView alloc] initWithFrame: _bottomView.bounds];
        _talkView.backgroundColor = [UIColor whiteColor];
    }
    return _talkView;
}

-(UIButton *)talkCloseButton{
    if (!_talkCloseButton) {
        _talkCloseButton = [[UIButton alloc] initWithFrame:CGRectMake(_bottomView.bounds.size.width - 50, _bottomView.bounds.size.height - 50, 50, 50)];
        _talkCloseButton.backgroundColor = [UIColor redColor];
        [_talkCloseButton addTarget:self action:@selector(closeTalkView:) forControlEvents:UIControlEventTouchUpInside];
        [_talkCloseButton setImage:[UIImage imageNamed:@"play_close"] forState:UIControlStateNormal];
    }
    return _talkCloseButton;
}

-(UIImageView *)speakImageView{
    if (!_speakImageView) {
        _speakImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 65, 65)];
        _speakImageView.center = _talkView.center;
        //添加长按手势
        UILongPressGestureRecognizer * longPressGesture =[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(talkPressed:)];
        longPressGesture.minimumPressDuration=1.5f;//设置长按 时间
        [_speakImageView addGestureRecognizer:longPressGesture];
        _speakImageView.image = [UIImage imageNamed:@"preview_talkback"];
    }
    return _speakImageView;
}


-(UILabel *)largeTitleLabel{
    if (!_largeTitleLabel) {
        _largeTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMinY(_playerView.frame) + 20, SCREEN_WIDTH, 40)];
        _largeTitleLabel.text = @"largeTitleLabel";
    }
    return _largeTitleLabel;
}

//时间长度
-(UILabel *)localRecordLabel{
    if (!_localRecordLabel) {
        _localRecordLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(_playerView.frame) + 20, SCREEN_WIDTH, 40)];
        _localRecordLabel.textColor = [UIColor blackColor];
        _localRecordLabel.text = @"片段时间片段时间片段时间片段时间";
        _localRecordLabel.hidden = YES;
    }
    return _localRecordLabel;
}

-(UILabel *)messageLabel{
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] initWithFrame:_playerView.bounds];
        _messageLabel.hidden = YES;
        _messageLabel.text =  @"播放失败";
    }
    return _messageLabel;
}


@end
