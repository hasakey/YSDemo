//
//  UIFactory.h
//  ThinkHome
//
//  Created by ThinkHome on 15/11/2.
//  Copyright © 2015年 ThinkHome. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+Expansion.h"
@interface UIFactory : UIView

+(id)buttonWithFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)titleColor image:(UIImage *)image highLightImage:(UIImage *)highImage normalColor:(UIColor *)backColor highLightColor:(UIColor *)highLightColor handler:(buttonHandler)handler;

+(id)viewWithFrame:(CGRect)frame backColor:(UIColor *)backColor radius:(int)radius alpha:(float)alpha;

+(id)labelWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font labelAlignment:(NSTextAlignment)textAlignment;

+(id)imageWithFrame:(CGRect)frame image:(UIImage *)image backColor:(UIColor *)backColor layerWidth:(float)layerWidth layerColor:(UIColor *)layerColor;

+(id)tableViewWithFrame:(CGRect)frame delegateView:(UIViewController<UITableViewDelegate,UITableViewDataSource> *)vc backColor:(UIColor *)backColor style:(UITableViewStyle)style;

+(id)tableCellWithFrame:(UITableView *)tableView;

+(id)textFieldWithFrame:(CGRect)frame borderStyle:(UITextBorderStyle)style font:(UIFont *)font text:(NSString *)text placeholder:(NSString *)placeholder;

+(id)switchWithFrame:(CGRect)frame isOn:(BOOL)isOn target:(id)target action:(SEL)action;

+(id)barItemWithFrame:(CGRect)frame image:(UIImage *)image highlightImage:(UIImage *)highlightImage alignment:(UIControlContentHorizontalAlignment)alignment target:(id)target action:(SEL)action;

+(id)barItemWithFrame:(CGRect)frame text:(NSString *)text alignment:(UIControlContentHorizontalAlignment)alignment target:(id)target action:(SEL)action;

+(id)actionsheetWithArr:(NSArray *)arr title:(NSString *)title redButtonIndex:(int)index target:(id)target;

@end
