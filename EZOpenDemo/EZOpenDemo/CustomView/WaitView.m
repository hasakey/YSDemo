//
//  WaitView.m
//  ThinkHome
//
//  Created by ThinkHome on 15/11/16.
//  Copyright © 2015年 ThinkHome. All rights reserved.
//

#import "WaitView.h"
#import "NSString+Expansion.h"
#import "MacroHeader.h"
#import "UIFactory.h"

@interface WaitView(){
    int waitTime;
    NSString *showText;
    NSTimer *waitTimer;
}

@property (strong,nonatomic) UIView *backView;

@property (strong,nonatomic) UILabel *showLabel;

@end

@implementation WaitView

+(instancetype)sharedInstance{
    static WaitView *waitView=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        waitView = [[WaitView alloc]initWithFrame:CGRectMake(0, TitleHeight, M_WIDTH, M_HEIGHT-TitleHeight-49)];
    });
    return waitView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self addSubview:self.backView];
        //初始化菊花
        UIActivityIndicatorView *activity=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        activity.frame=CGRectMake(30, 0, 80, 60);
        [activity startAnimating];
        [_backView addSubview:activity];
        
        [_backView addSubview:self.showLabel];
    }
    return self;
}

-(UIView *)backView{
    if(_backView == nil){
        _backView=[UIFactory viewWithFrame:CGRectMake(M_WIDTH/2-70, M_HEIGHT/2-50-TitleHeight, 140, 100) backColor:[UIColor blackColor] radius:5 alpha:0.8];
    }
    return _backView;
}

-(UILabel *)showLabel{
    if(_showLabel == nil){
        _showLabel = [UIFactory labelWithFrame:CGRectMake(0, 50, 140, 40) title:@"请稍候" titleColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:16] labelAlignment:NSTextAlignmentCenter];
        _showLabel.numberOfLines = 2;
    }
    return _showLabel;
}

-(void)showWaitView:(id)target title:(NSString *)text time:(int)time{
    if([text isEqualToString:@""])
        text = @"请稍候";
    CGSize size = [text getStrSize:[UIFont systemFontOfSize:16] width:M_WIDTH];
    if(size.width > 80){
        _showLabel.font = [UIFont systemFontOfSize:14];
    }else{
        _showLabel.font = [UIFont systemFontOfSize:16];
    }
    
    waitTime=time;
    showText=text;
    //当传入时间不为0 时 启动倒计时
    if(time != 0){
        [waitTimer invalidate];
        waitTimer = nil;
        _showLabel.text=[text stringByAppendingString:[NSString stringWithFormat:@"(%ds)",time]];
        waitTimer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeGo) userInfo:nil repeats:YES];
        //        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }else{
        _showLabel.text=text;
        //        [self add];
        //延迟.1秒出现 如果不延迟 会出现之前文字闪一下在替换为新文字
        //        [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(add) userInfo:nil repeats:NO];
    }
    if([target isKindOfClass:[UIViewController class]])
        [[(UIViewController *)target view] addSubview:self];
    else
        [target addSubview:self];
}

-(void)add{
    //    [NSThread detachNewThreadSelector:@selector(showWaitView:) toTarget:self withObject:nil];
    [self showWaitView:self];
}

-(void)showWaitView:(id)target{
    if([target isKindOfClass:[UIViewController class]])
        [[(UIViewController *)target view] addSubview:self];
    else
        [target addSubview:self];
}
//延迟一秒删除 减少因为网速快时候一闪而过。
-(void)removeWaitView{
    [self remove];
}

-(void)removeWaitViewNow{
    [self remove];
}

-(void)remove{
    [waitTimer invalidate];
    waitTimer = nil;
    [self removeFromSuperview];
}
//定时器
-(void)timeGo{
    waitTime--;
    if(waitTime <= 0){
        [self removeFromSuperview];
        [waitTimer invalidate];
        waitTimer=nil;
    }else{
        _showLabel.text=[showText stringByAppendingString:[NSString stringWithFormat:@"(%ds)",waitTime]];
    }
}

-(void)setShowWaitViewText:(NSString *)text{
    showText=text;
    if(waitTime <= 0){
        _showLabel.text = text;
    }else{
        _showLabel.text =  _showLabel.text=[text stringByAppendingString:[NSString stringWithFormat:@"(%ds)",(int)waitTime]];
    }
}

@end
