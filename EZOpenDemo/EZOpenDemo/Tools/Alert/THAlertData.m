//
//  THAlertData.m
//  ThinkHomeLib
//
//  Created by ThinkHome on 15/11/16.
//  Copyright © 2015年 ThinkHome. All rights reserved.
//

#import "THAlertData.h"
@implementation THAlertData

//本地错误异常
+(void)local_alert:(int)errNo{
    
    NSString *errorInfo= [NSString stringWithFormat:@"LocalError_%d",errNo];

    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:errorInfo delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alert show];
}

+(void)local_alert_new:(int)errNo target:(id)target{
    NSString *errorInfo=[NSString stringWithFormat:@"LocalError_%d",errNo];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:errorInfo preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:action];
    [target presentViewController:alertController animated:YES completion:nil];
}

//网络错误异常
+(void)net_alert:(int)errNo
{
    if (errNo == 200) {
        return;
    }
    NSString *errorInfo = [NSString stringWithFormat:@"NetError_%d",errNo];
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:errorInfo delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

+(void)net_alert_new:(int)errNo target:(id)target{
    NSString *errorInfo=[NSString stringWithFormat:@"NetError_%d",errNo];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:errorInfo preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:action];
    [target presentViewController:alertController animated:YES completion:nil];
}

+(void)alertWithText:(NSString *)text target:(id)target block:(void (^)())blocks{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:text preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if(blocks){
            blocks();
        }
    }];
    [alertController addAction:action];
    [target presentViewController:alertController animated:YES completion:nil];
}

@end
