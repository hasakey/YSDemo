//
//  UIFactory.m
//  ThinkHome
//
//  Created by ThinkHome on 15/11/2.
//  Copyright © 2015年 ThinkHome. All rights reserved.
//

#import "UIFactory.h"

@implementation UIFactory

+(id)buttonWithFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)titleColor image:(UIImage *)image highLightImage:(UIImage *)highImage normalColor:(UIColor *)backColor highLightColor:(UIColor *)highLightColor handler:(buttonHandler)handler{
    UIButton *bt=[[UIButton alloc]initWithFrame:frame];
    [bt setTitle:title forState:UIControlStateNormal];
    bt.titleLabel.font=font;
    bt.titleLabel.textColor=titleColor;
    [bt setTitleColor:titleColor forState:UIControlStateNormal];
    [bt setImage:image forState:UIControlStateNormal];
    [bt setImage:highImage forState:UIControlStateHighlighted];
    bt.normalColor=backColor;
    bt.highlightColor=highLightColor;
    bt.handler=handler;
    [bt addButtonAction];
    return bt;
}

+(id)viewWithFrame:(CGRect)frame backColor:(UIColor *)backColor radius:(int)radius alpha:(float)alpha{
    UIView *view=[[UIView alloc]initWithFrame:frame];
    view.backgroundColor=backColor;
    view.layer.cornerRadius=radius;
    view.alpha=alpha;
    return view;
}

+(id)labelWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font labelAlignment:(NSTextAlignment)textAlignment{
    UILabel *label=[[UILabel alloc]initWithFrame:frame];
    label.text=title;
    label.textColor=titleColor;
    label.font=font;
    label.textAlignment=textAlignment;
    return label;
}

+(id)imageWithFrame:(CGRect)frame image:(UIImage *)image backColor:(UIColor *)backColor layerWidth:(float)layerWidth layerColor:(UIColor *)layerColor{
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:frame];
    imageView.image=image;
    imageView.backgroundColor=backColor;
    imageView.layer.borderWidth=layerWidth;
    imageView.layer.borderColor=layerColor.CGColor;
    return imageView;
}

+(id)tableViewWithFrame:(CGRect)frame delegateView:(UIViewController<UITableViewDelegate,UITableViewDataSource> *)vc backColor:(UIColor *)backColor style:(UITableViewStyle)style{
    UITableView *tb=[[UITableView alloc]initWithFrame:frame style:style];
    tb.delegate=vc;
    tb.dataSource=vc;
    if(backColor == nil)
        tb.backgroundColor=[UIColor whiteColor];
    else
        tb.backgroundColor=backColor;
    return tb;
}

+(id)tableCellWithFrame:(UITableView *)tableView{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cells"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

+(id)textFieldWithFrame:(CGRect)frame borderStyle:(UITextBorderStyle)style font:(UIFont *)font text:(NSString *)text placeholder:(NSString *)placeholder{
    UITextField *textField=[[UITextField alloc]initWithFrame:frame];
    textField.borderStyle=style;
    textField.font=font;
    textField.text=text;
    textField.placeholder = placeholder;
    return textField;
}

+(id)switchWithFrame:(CGRect)frame isOn:(BOOL)isOn target:(id)target action:(SEL)action{
    UISwitch *sw=[[UISwitch alloc]initWithFrame:frame];
    [sw setOn:isOn animated:NO];
//    sw.onTintColor = [THLibStaticDB getAppColor:0];
    sw.onTintColor = [UIColor redColor];
    [sw addTarget:target action:action forControlEvents:UIControlEventValueChanged];
    return sw;
}

+(id)barItemWithFrame:(CGRect)frame image:(UIImage *)image highlightImage:(UIImage *)highlightImage alignment:(UIControlContentHorizontalAlignment)alignment target:(id)target action:(SEL)action{
    UIButton *button=[[UIButton alloc]initWithFrame:frame];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:highlightImage forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.contentHorizontalAlignment=alignment;
    
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}

+(id)barItemWithFrame:(CGRect)frame text:(NSString *)text alignment:(UIControlContentHorizontalAlignment)alignment target:(id)target action:(SEL)action{
    UIButton *button=[[UIButton alloc]initWithFrame:frame];
    [button setTitle:text forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.contentHorizontalAlignment=alignment;
    
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}

+(id)actionsheetWithArr:(NSArray *)arr title:(NSString *)title redButtonIndex:(int)index target:(id)target{
    UIActionSheet *actionsheet=[[UIActionSheet alloc]initWithTitle:title delegate:target cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil];
    for(int i =0 ; i<[arr count];i++){
        [actionsheet addButtonWithTitle:arr[i]];
    }
    if(index != -1)
        actionsheet.destructiveButtonIndex=index;
    return actionsheet;
}

@end
