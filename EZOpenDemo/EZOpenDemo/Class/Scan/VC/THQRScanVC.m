//
//  THQRScanVC.m
//  EZOpenDemo
//
//  Created by will on 2019/4/3.
//  Copyright © 2019 will. All rights reserved.
//

#import "THQRScanVC.h"
#import "QRScanToolView.h"
#import "UIFactory.h"
#import "MacroHeader.h"

@interface THQRScanVC ()<AVCaptureMetadataOutputObjectsDelegate,UIActionSheetDelegate>



@property (strong,nonatomic) UIImageView *backView;

@property (strong,nonatomic) UILabel *tips;

@property (strong,nonatomic) UIButton *lightButton;

@property (strong,nonatomic) QRScanToolView *toolView;

@end

@implementation THQRScanVC

-(instancetype)initWithBlock:(void(^)(NSString * returnStr))complete{
    self = [super init];
    if(self){
        self.blocks=complete;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
}

-(void)initView{
    [self.titleView.title setTitle:@"扫描二维码" forState:UIControlStateNormal];
    [self.titleView.leftButton setImage:[UIImage imageNamed:@"icon_nav_arrowleft"] forState:UIControlStateNormal];
    [self.titleView.rightButton setImage:[UIImage imageNamed:@"button_add.png"] forState:UIControlStateNormal];
    //    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:[THLibStaticDB DPLocalizedString:@"ScanButton"] style:UIBarButtonItemStyleBordered target:self action:@selector(toucheNext)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    [self.view addSubview:self.backView];
    [self.view addSubview:self.tips];
    [self.view addSubview:self.lightButton];
    [self.toolView startScan];
}

-(void)touchTitleRightButton{
    UIActionSheet *actionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"SmartLink",@"ScanButton",nil];
    [actionSheet showInView:self.view];
}

-(UIImageView *)backView{
    if(_backView == nil){
        _backView=[UIFactory imageWithFrame:self.view.bounds image:[UIImage imageNamed:@"smzz.png"] backColor:nil layerWidth:0 layerColor:nil];
    }
    return _backView;
}

-(UILabel *)tips{
    if(_tips == nil){
        _tips = [UIFactory labelWithFrame:CGRectMake(M_WIDTH/2-120, 280/(480/M_HEIGHT), 240, 80) title:@"二维码扫描" titleColor:[UIColor whiteColor] font:nil labelAlignment:NSTextAlignmentCenter];
        _tips.numberOfLines=2;
    }
    return _tips;
}

-(UIButton *)lightButton{
    if(_lightButton == nil){
        _lightButton = [UIFactory buttonWithFrame:CGRectMake(M_WIDTH/2-30, M_HEIGHT-100, 60, 60) title:@"" font:nil titleColor:nil image:[UIImage imageNamed:@"button_smsgd.png"] highLightImage:nil normalColor:[UIColor clearColor] highLightColor:[UIColor clearColor] handler:^(UIButton *sender) {
            if([self->_lightButton.imageView.image isEqual:[UIImage imageNamed:@"button_smsgd.png"]]){
                [self->_lightButton setImage:[UIImage imageNamed:@"button_smjs.png"] forState:UIControlStateNormal];
            }else{
                [self->_lightButton setImage:[UIImage imageNamed:@"button_smsgd.png"] forState:UIControlStateNormal];
            }
        }];
    }
    return _lightButton;
}

-(QRScanToolView *)toolView{
    if(_toolView == nil){
        _toolView = [[QRScanToolView alloc]init];
        [_toolView setupCamera:self];
        
        AVCaptureVideoPreviewLayer *preview =[AVCaptureVideoPreviewLayer layerWithSession:_toolView.session];
        preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
        preview.frame =CGRectMake(self.view.bounds.origin.x,self.view.bounds.origin.y,self.view.bounds.size.width,self.view.bounds.size.height);
        [self.view.layer insertSublayer:preview atIndex:0];
    }
    return _toolView;
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringValue;
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    [_toolView.session stopRunning];
//    [self.navigationController popViewControllerAnimated:NO];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    if (self.blocks) {
        self.blocks(stringValue);
    }
}

@end
