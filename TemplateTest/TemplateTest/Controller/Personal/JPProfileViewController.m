//
//  JPPersonalViewController.m
//  TemplateTest
//
//  Created by caijingpeng on 15/6/26.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "JPProfileViewController.h"
#import "JPProfileCubeView.h"
#import "JPEditViewController.h"

#define CUBE_WIDTH      kScreenWidth / 3.0f
#define CUBE_HEIGHT     70 * kScreenRate
#define IMAGE_HEIGHT    (kScreenHeight - CUBE_HEIGHT * 2)

#define PHOTO_SIZE          ceilf(IMAGE_HEIGHT * 0.2)

@interface JPProfileViewController () <UINavigationControllerDelegate>
{
    UIView *_firstRowView;
    UIView *_secondRowView;
    UIButton *_followButton;
}
@end

@implementation JPProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [Utility navTitleView:@"Profile"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(toEdit:) title:@"Edit"];
    
    self.navigationController.delegate = self;
    
    UIScrollView *_mainSV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -64, kScreenWidth, kScreenHeight)];
    _mainSV.backgroundColor = [UIColor whiteColor];
    _mainSV.contentSize = CGSizeMake(kScreenWidth, CONTENT_HEIGHT + 1);
    [self.view addSubview:_mainSV];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIImageView *backImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, IMAGE_HEIGHT)];
    backImgV.contentMode = UIViewContentModeScaleAspectFill;
    backImgV.image = IMAGE(@"tempImage.png");
    [_mainSV addSubview:backImgV];
    
    UIImageView *gradientImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, backImgV.frame.size.height * 0.5, kScreenWidth, backImgV.frame.size.height * 0.5)];
    gradientImgV.image = IMAGE(@"gradient.png");
    [backImgV addSubview:gradientImgV];
    
    
    UIImageView *photoImgV = [[UIImageView alloc] initWithFrame:CGRectMake(30, backImgV.frame.size.height * 0.7, PHOTO_SIZE, PHOTO_SIZE)];
    photoImgV.image = IMAGE(@"head.jpg");
    photoImgV.layer.cornerRadius = PHOTO_SIZE / 2.0f;
    photoImgV.layer.borderColor = CD_YELLOW.CGColor;
    photoImgV.layer.masksToBounds = YES;
    photoImgV.layer.borderWidth = PHOTO_SIZE * 0.02;
    [backImgV addSubview:photoImgV];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(photoImgV.frame) + 30, CGRectGetMidY(photoImgV.frame) - 30 - 5, kScreenWidth - (CGRectGetMaxX(photoImgV.frame) + 30) - 15, 30)];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.font = FONT(TF_BigTitle);
    nameLabel.text = @"GAIUS";
    [backImgV addSubview:nameLabel];
    
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(photoImgV.frame) + 30, CGRectGetMidY(photoImgV.frame) - 5, kScreenWidth - (CGRectGetMaxX(photoImgV.frame) + 30) - 15, 40)];
    infoLabel.textColor = [UIColor whiteColor];
    infoLabel.textAlignment = NSTextAlignmentLeft;
    infoLabel.numberOfLines = 2;
    infoLabel.font = FONT(TF_Title);
    infoLabel.text = @"Do one thing at a time, and do well.";
    [backImgV addSubview:infoLabel];
    
    
    
    [self setFollowMode];
    
    
}

#pragma mark -- Action Method --

- (void)toEdit:(id)sender
{
    JPEditViewController *editVC = [[JPEditViewController alloc] init];
    [self.navigationController pushViewController:editVC animated:YES];
}

#pragma mark -- Public Method --

- (void)setFollowMode
{
    _followButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _followButton.frame = CGRectMake(0, CONTENT_HEIGHT - CUBE_HEIGHT * 2, kScreenWidth, CUBE_HEIGHT * 0.8);
    [_followButton setBackgroundImage:[Utility imageWithColor:CD_YELLOW andSize:_followButton.frame.size] forState:UIControlStateNormal];
    _followButton.titleLabel.font = FONT(24.0f);
    [_followButton setTitle:@"Follow" forState:UIControlStateNormal];
    [self.view addSubview:_followButton];
    
    _firstRowView = [[UIView alloc] initWithFrame:CGRectMake(0, CONTENT_HEIGHT - 1.2 * CUBE_HEIGHT, kScreenWidth, CUBE_HEIGHT * 1.2)];
    [self.view addSubview:_firstRowView];
    [self initialFirstRowView];
}

- (void)setNormalMode
{
    _firstRowView = [[UIView alloc] initWithFrame:CGRectMake(0, CONTENT_HEIGHT - 2 * CUBE_HEIGHT, kScreenWidth, CUBE_HEIGHT)];
    [self.view addSubview:_firstRowView];
    
    _secondRowView = [[UIView alloc] initWithFrame:CGRectMake(0, CONTENT_HEIGHT - 1 * CUBE_HEIGHT, kScreenWidth, CUBE_HEIGHT)];
    [self.view addSubview:_secondRowView];
    
    [self initialFirstRowView];
    [self initialSecondRowView];
    
    [_firstRowView drawBottomLine];
}

#pragma mark -- Build View --

- (void)initialFirstRowView
{
    for (int i = 0; i < 3; i++)
    {
        JPProfileCubeView *view = [[JPProfileCubeView alloc] initWithFrame:CGRectMake(i * CUBE_WIDTH, 0, CUBE_WIDTH, _firstRowView.frame.size.height)];
        [_firstRowView addSubview:view];
        
        if (i == 0)
        {
            view.upLabel.text = @"231";
            view.downLabel.text = @"Questions";
        }
        else if (i == 1)
        {
            view.upLabel.text = @"13,123";
            view.downLabel.text = @"Followers";
            [_firstRowView addSubview:[Utility drawVerticalLine:CGPointMake(view.frame.origin.x, 0) height:_firstRowView.frame.size.height]];
        }
        else
        {
            view.upLabel.text = @"13";
            view.downLabel.text = @"Fans";
            [_firstRowView addSubview:[Utility drawVerticalLine:CGPointMake(view.frame.origin.x, 0) height:_firstRowView.frame.size.height]];
        }
        
    }
}

- (void)initialSecondRowView
{
    for (int i = 0; i < 3; i++)
    {
        JPProfileCubeView *view = [[JPProfileCubeView alloc] initWithFrame:CGRectMake(i * CUBE_WIDTH, 0, CUBE_WIDTH, CUBE_HEIGHT)];
        [_secondRowView addSubview:view];
        
        if (i == 0)
        {
            view.upLabel.text = @"231";
            view.downLabel.text = @"Questions";
        }
        else if (i == 1)
        {
            view.upLabel.text = @"123,123";
            view.downLabel.text = @"Followers";
            [_secondRowView addSubview:[Utility drawVerticalLine:CGPointMake(view.frame.origin.x, 0) height:CUBE_HEIGHT]];
        }
        else
        {
            view.upLabel.text = @"13";
            view.downLabel.text = @"Fans";
            [_secondRowView addSubview:[Utility drawVerticalLine:CGPointMake(view.frame.origin.x, 0) height:CUBE_HEIGHT]];
        }
        
    }
}

#pragma mark -- UINavigationController Delegate --

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self)
    {
        HWBaseNavigationController *nav = (HWBaseNavigationController *)navigationController;
        [nav setNavigationBarClearColor];
    }
    else
    {
        HWBaseNavigationController *nav = (HWBaseNavigationController *)navigationController;
        [nav setNavigationBarMainColor];
    }
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
