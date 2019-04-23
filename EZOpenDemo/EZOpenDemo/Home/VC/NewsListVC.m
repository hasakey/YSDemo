//
//  NewsListVC.m
//  EZOpenDemo
//
//  Created by will on 2019/4/9.
//  Copyright © 2019 will. All rights reserved.
//

#import "NewsListVC.h"
#import "NewsCell.h"
#import <EZOpenSDKFramework/EZOpenSDKFramework.h>
#import "MacroHeader.h"
#import "THYSUrl.h"

@interface NewsListVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *newList;

@end

@implementation NewsListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.titleView];
    [self.titleView.title setTitle:@"消息列表" forState:UIControlStateNormal];
    [self.view addSubview:self.tableView];
    [self getData];

}

-(void)getData{
    THYSUrl *tool = [THYSUrl new];
    WS(weakSelf)
    [tool getAlarmList:@{} Success:^(id  _Nonnull responseObject) {
        weakSelf.newList = [responseObject[@"data"] copy];
        [weakSelf.tableView reloadData];
    }];
}


#pragma mark   tableviewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _newList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsCell *cell = [[NewsCell alloc] cellWithTableView:tableView];
    NSDictionary *info = [_newList objectAtIndex:indexPath.row];

    [cell setDeviceInfo:info];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    EZLivePlayViewController *vc = [EZLivePlayViewController new];
//    vc.deviceInfo = [_deviceList objectAtIndex:indexPath.row];
//
//    //    [self presentViewController:vc animated:NO completion:^{
//    //
//    //    }];
//    [self.navigationController pushViewController:vc animated:NO];
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TitleHeight, self.view.frame.size.width, self.view.frame.size.height - TitleHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(NSMutableArray *)newList{
    if (!_newList) {
        _newList = [NSMutableArray array];
    }
    return _newList;
}

@end
