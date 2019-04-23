//
//  THTitleView.m
//  ThinkHome
//
//  Created by ThinkHome on 15/11/16.
//  Copyright © 2015年 ThinkHome. All rights reserved.
//

#import "THTitleView.h"
#import "MacroHeader.h"
#import "UIFactory.h"

@interface THTitleView()

@property (copy,nonatomic) LeftButtonBlock leftBlock;

@property (copy,nonatomic) RightButtonBlock rightBlock;

@end

@implementation THTitleView

-(instancetype)initWithLeftBlock:(LeftButtonBlock)leftBlock rightBlock:(RightButtonBlock)rightBlock{
    self = [super initWithFrame:CGRectMake(0, 0, M_WIDTH, TitleHeight)];
    if(self){
        self.leftBlock = leftBlock;
        self.rightBlock = rightBlock;
        [self addSubview:self.backView];
        [self addSubview:self.leftButton];
        [self addSubview:self.rightButton];
        [self addSubview:self.title];
        [self addSubview:self.activity];
    }
    return self;
}

#pragma set/get
-(UIView *)backView{
    if(!_backView){
        _backView = [UIFactory viewWithFrame:CGRectMake(0, 0, M_WIDTH, TitleHeight) backColor:[UIColor blackColor] radius:0 alpha:1];
    }
    return _backView;
}

-(UIButton *)leftButton{
    if(!_leftButton){
        WS(weakSelf);
        _leftButton = [UIFactory buttonWithFrame:CGRectMake(5, TitleHeight - 44, 60, 44) title:@"" font:nil titleColor:[UIColor whiteColor] image:nil highLightImage:nil normalColor:[UIColor clearColor] highLightColor:[UIColor clearColor] handler:^(UIButton *sender) {
            if(weakSelf.leftBlock)
                weakSelf.leftBlock();
        }];
    }
    return _leftButton;
}

-(UIButton *)title{
    if(!_title){
        _title = [UIFactory buttonWithFrame:CGRectMake(CGRectGetMaxX(self.leftButton.frame), TitleHeight - 44, self.rightButton.frame.origin.x - CGRectGetMaxX(self.leftButton.frame), 44) title:@"" font:[UIFont systemFontOfSize:20] titleColor:[UIColor whiteColor] image:nil highLightImage:nil normalColor:[UIColor clearColor] highLightColor:[UIColor clearColor] handler:^(UIButton *sender) {
            if(_midBlock)
                _midBlock();
        }];
    }
    return _title;
}

-(UIButton *)rightButton{
    if(!_rightButton){
        WS(weakSelf);
        _rightButton = [UIFactory buttonWithFrame:CGRectMake(M_WIDTH-60-5, TitleHeight - 44, 60, 44) title:nil font:nil titleColor:[UIColor whiteColor] image:nil highLightImage:nil normalColor:[UIColor clearColor] highLightColor:[UIColor clearColor] handler:^(UIButton *sender) {
            if(weakSelf.rightBlock)
                weakSelf.rightBlock();
        }];
    }
    return _rightButton;
}
-(UIActivityIndicatorView *)activity{
    if(!_activity){
        _activity=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _activity.frame=CGRectMake(_title.center.x - 93, TitleHeight - 47, 50, 50);
        [_activity stopAnimating];
        _activity.hidden =YES;
    }
    return _activity;
}


//self.backgroundColor = [THLibStaticDB getAppColor:0];
@end
