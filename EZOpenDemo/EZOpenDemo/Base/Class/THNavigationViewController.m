//
//  THNavigationViewController.m
//  ThinkHome
//
//  Created by ThinkHome on 2018/12/21.
//  Copyright © 2018 ThinkHome. All rights reserved.
//

#import "THNavigationViewController.h"

@interface THNavigationViewController ()

@end

@implementation THNavigationViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationBarHidden:YES animated:YES];
}


#pragma mark - Public Method
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if(self.viewControllers.count > 0 ){
        viewController.hidesBottomBarWhenPushed=YES;
    }
    [super pushViewController:viewController animated:animated];
}


@end
