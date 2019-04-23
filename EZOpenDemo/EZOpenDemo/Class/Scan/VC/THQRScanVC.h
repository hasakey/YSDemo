//
//  THQRScanVC.h
//  EZOpenDemo
//
//  Created by will on 2019/4/3.
//  Copyright © 2019 will. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THViewController.h"

typedef void (^CoorQRBlock) (NSString * returnStr);

@interface THQRScanVC : THViewController

-(instancetype)initWithBlock:(void(^)(NSString * returnStr))complete;

@property (copy,nonatomic) CoorQRBlock blocks;

@end


