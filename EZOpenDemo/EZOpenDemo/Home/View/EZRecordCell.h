//
//  EZRecordCell.h
//  EZOpenSDKDemo
//
//  Created by DeJohn Dong on 15/11/3.
//  Copyright © 2015年 hikvision. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EZOpenSDKFramework/EZOpenSDKFramework.h>

//@class EZCloudRecordFile;
//@class EZDeviceRecordFile;

@interface EZRecordCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, copy) NSString *deviceSerial;

- (void)setCloudRecord:(EZCloudRecordFile *)cloudFile selected:(BOOL)selected;

- (void)setDeviceRecord:(EZCloudRecordFile *)deviceFile selected:(BOOL)selected;

@end
