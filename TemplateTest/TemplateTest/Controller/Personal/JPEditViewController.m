//
//  JPEditViewController.m
//  TemplateTest
//
//  Created by caijingpeng on 15/6/26.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "JPEditViewController.h"

@interface JPEditViewController ()

@end

@implementation JPEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.titleView = [Utility navTitleView:@"Edit"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
