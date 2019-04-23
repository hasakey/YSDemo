//
//  UIButton+Expansion.m
//  ThinkHome
//
//  Created by ThinkHome on 15/11/2.
//  Copyright © 2015年 ThinkHome. All rights reserved.
//

#import "UIButton+Expansion.h"
#import <objc/runtime.h>

@implementation UIButton (Expansion)

static char strAddrHighlightKey = 'a';
static char strAddrNormalKey = 'b';
static char strAddrButtonKey = 'd';
//平常颜色的set get方法
- (UIColor *)normalColor{
    UIColor *color=objc_getAssociatedObject(self, &strAddrNormalKey);
    if(color == nil)
        color=self.backgroundColor;
    return color;
}

-(void)setNormalColor:(UIColor *)normalColor{
    objc_setAssociatedObject(self, &strAddrNormalKey, normalColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.backgroundColor=normalColor;
}
//高亮时颜色的 set get 方法
- (UIColor *)highlightColor{
    UIColor *color=objc_getAssociatedObject(self, &strAddrHighlightKey);
    if(color == nil)
        color=self.backgroundColor;
    return color;
}

- (void)setHighlightColor:(UIColor *)highlightColor{
    objc_setAssociatedObject(self, &strAddrHighlightKey, highlightColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(buttonHandler)handler{
    return objc_getAssociatedObject(self, &strAddrButtonKey);
}

-(void)setHandler:(buttonHandler)handler{
    objc_setAssociatedObject(self, &strAddrButtonKey, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

//设置按钮高亮时候的背景颜色
-(void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    if(highlighted){
        self.backgroundColor=[self highlightColor];
    }else{
        self.backgroundColor=[self normalColor];
    }
}

-(void)addButtonAction{
    [self addTarget:self action:@selector(touchButton) forControlEvents:UIControlEventTouchUpInside];
}

-(void)touchButton{
    if(self.handler){
        self.handler(self);
    }
}

-(void)setLayer:(float)layerWidth layerColor:(UIColor *)layerColor radius:(int)raduis{
    self.layer.borderWidth=layerWidth;
    self.layer.borderColor=layerColor.CGColor;
    if(raduis < 0)
        [self becomeRound];
    else
        [self.layer setCornerRadius:raduis];
}

-(void)becomeRound{
    [self.layer setCornerRadius:(self.frame.size.height/2)];
    [self.layer setMasksToBounds:YES];
    //[_portraitImageView setContentMode:UIViewContentModeScaleAspectFill];
    [self setClipsToBounds:YES];
}

@end
