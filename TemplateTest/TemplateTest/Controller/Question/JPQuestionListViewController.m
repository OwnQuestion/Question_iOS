//
//  JPQuestionListViewController.m
//  TemplateTest
//
//  Created by caijingpeng on 15/6/24.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "JPQuestionListViewController.h"
#import "JPQuestionListRefreshView.h"

@interface JPQuestionListViewController () <JPQuestionListRefreshViewDelegate>

@end

@implementation JPQuestionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.titleView = [Utility navTitleView:@"Question"];
    
    JPQuestionListRefreshView *qlistView = [[JPQuestionListRefreshView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    qlistView.delegate = self;
//    qlistView.layer.masksToBounds = NO;
    [self.view addSubview:qlistView];
    
//    self.extendedLayoutIncludesOpaqueBars = YES;
//    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didSelectedQuestion:(JPQuestionModel *)question
{
    
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
