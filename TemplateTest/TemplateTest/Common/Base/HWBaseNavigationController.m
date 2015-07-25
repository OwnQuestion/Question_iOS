//
//  HWBaseNavigationController.m
//  Community
//
//  Created by caijingpeng.haowu on 14-8-27.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWBaseNavigationController.h"

@interface HWBaseNavigationController ()

@end

@implementation HWBaseNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    if (IOS7)
//    {
//        self.edgesForExtendedLayout = UIRectEdgeTop;
//    }
    
    [self setNavigationBarMainColor];
    
    
//    [self.navigationController.navigationBar setBackgroundImage:[Utility imageWithColor:[UIColor whiteColor] andSize:CGSizeMake(kScreenWidth, (IOS7 ? 64 : 44))] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
//    [self.navigationBar setBarTintColor:[UIColor whiteColor]];
//    [[UINavigationBar appearance] setAlpha:0.5f];
//    UIColorFromRGB(0x20c0f8)
//    [[UINavigationBar appearance] setTranslucent:YES];
//    [self.navigationBar setBarStyle:UIBarStyleBlack];
    // Do any additional setup after loading the view.
    
//    self.navigationBar.tintColor = UIColorFromRGB(0x20c0f8);
//    self.navigationBar.alpha = 0.3f;
//    self.navigationBar.translucent = YES;
    
//    [self.navigationBar setTintColor:[UIColor whiteColor]];
    
    
    
}

- (void)setNavigationBarMainColor
{
    [self.navigationBar setBackgroundImage:[Utility imageWithColor:[UIColor colorWithRed:32/255.0f green:192/255.0f blue:248/255.0f alpha:1.0f] andSize:CGSizeMake(kScreenWidth, (IOS7 ? 64 : 44))] forBarMetrics:UIBarMetricsDefault];
}

- (void)setNavigationBarClearColor
{
    [self.navigationBar setBackgroundImage:[Utility imageWithColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3f] andSize:CGSizeMake(kScreenWidth, (IOS7 ? 64 : 44))] forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
