//
//  NewsCell.m
//  EZOpenDemo
//
//  Created by will on 2019/4/9.
//  Copyright © 2019 will. All rights reserved.
//

#import "NewsCell.h"
#import "MacroHeader.h"

@interface NewsCell()

@property (nonatomic, strong)UILabel *nameLabel;


@end


@implementation NewsCell

-(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *CellIdentifier = @"NewsCell";
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell"];
    if (cell == nil) {
        cell = [[NewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self setupSubviews];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)setupSubviews{
    [self addSubview:self.nameLabel];
}

- (void)setDeviceInfo:(NSDictionary *)deviceInfo
{
    _nameLabel.text = deviceInfo[@"alarmName"];
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel  = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, M_WIDTH, 60)];
        _nameLabel.textColor = [UIColor blackColor];
    }
    return _nameLabel;
}


@end
