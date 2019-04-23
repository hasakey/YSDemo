//
//  NewsCell.h
//  EZOpenDemo
//
//  Created by will on 2019/4/9.
//  Copyright © 2019 will. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewsCell : UITableViewCell

- (void)setDeviceInfo:(NSDictionary *)deviceInfo;

-(instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
