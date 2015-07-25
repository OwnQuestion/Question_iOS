//
//  JPRootViewController.m
//  TemplateTest
//
//  Created by caijingpeng on 15/6/24.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "JPRootViewController.h"
#import "JPRootRefreshView.h"
#import "JPQuestionListViewController.h"
#import "AppDelegate.h"
#import "JPMessageViewController.h"
#import "JPFollowersViewController.h"
#import "JPDiscoveryViewController.h"
#import "JPProfileViewController.h"

@interface JPRootViewController () <JPRootRefreshViewDelegate>
{
    HWBaseNavigationController *_questionNavigation;
    HWBaseNavigationController *_messageNavigation;
    HWBaseNavigationController *_followersNavigation;
    HWBaseNavigationController *_discoveryNavigation;
    HWBaseNavigationController *_profileNavigation;
    
    CGPoint _startPoint;
    BOOL _statusHidden;
    UIView *_coverView;
    UIView *_transitionView;
}
@end

@implementation JPRootViewController

//- (BOOL)prefersStatusBarHidden
//{
//    return _statusHidden;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColorFromRGB(0x4e4e4e);
    
    JPRootRefreshView *backView = [[JPRootRefreshView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    backView.backgroundColor = [UIColor clearColor];
    backView.delegate = self;
    [self.view addSubview:backView];
    
    UIImageView *turnImgV = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 27, 160)];
    turnImgV.image = IMAGE(@"TurnOn.png");
    [self.view addSubview:turnImgV];
    
    _transitionView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _transitionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_transitionView];
    
    _statusHidden = NO;
    
    [self showQuestionViewController];

}

- (void)transitionAnimateByIndex:(NSInteger)index
{
    [UIView animateWithDuration:0.2f animations:^{
        
        CGRect frame = _transitionView.frame;
        frame.origin.x = kScreenWidth;
        _transitionView.frame = frame;
        
    } completion:^(BOOL finished) {
        switch (index)
        {
            case 0:
            {
                [self showQuestionViewController];
                break;
            }
            case 1:
            {
                [self showMessageViewController];
                break;
            }
            case 2:
            {
                [self showFollowersViewController];
                break;
            }
            case 3:
            {
                [self showDiscoveryViewController];
                break;
            }
            case 4:
            {
                [self showProfileViewController];
                break;
            }
                
            default:
                break;
        }
        
        [UIView animateWithDuration:0.3f animations:^{
            CGRect frame = _transitionView.frame;
            frame.origin.x = 0;
            _transitionView.frame = frame;
        }];
        
        
    }];
}

- (void)showQuestionViewController
{
    if (_questionNavigation == nil)
    {
        JPQuestionListViewController *qlistVC = [[JPQuestionListViewController alloc] init];
        _questionNavigation = [[HWBaseNavigationController alloc] initWithRootViewController:qlistVC];
        [self addChildViewController:_questionNavigation];
        [_transitionView addSubview:_questionNavigation.view];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(toPan:)];
        [qlistVC.view addGestureRecognizer:pan];
    }
    else
    {
        [_transitionView bringSubviewToFront:_questionNavigation.view];
    }
    _messageNavigation.view.hidden = YES;
    _followersNavigation.view.hidden = YES;
    _discoveryNavigation.view.hidden = YES;
    _profileNavigation.view.hidden = YES;
    _questionNavigation.view.hidden = NO;
    
}

- (void)showMessageViewController
{
    if (_messageNavigation == nil)
    {
        JPMessageViewController *qlistVC = [[JPMessageViewController alloc] init];
        _messageNavigation = [[HWBaseNavigationController alloc] initWithRootViewController:qlistVC];
        [self addChildViewController:_messageNavigation];
        [_transitionView addSubview:_messageNavigation.view];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(toPan:)];
        [qlistVC.view addGestureRecognizer:pan];
    }
    else
    {
        [_transitionView bringSubviewToFront:_messageNavigation.view];
    }
    
    _messageNavigation.view.hidden = NO;
    _followersNavigation.view.hidden = YES;
    _discoveryNavigation.view.hidden = YES;
    _profileNavigation.view.hidden = YES;
    _questionNavigation.view.hidden = YES;
}

- (void)showFollowersViewController
{
    if (_followersNavigation == nil)
    {
        JPFollowersViewController *qlistVC = [[JPFollowersViewController alloc] init];
        _followersNavigation = [[HWBaseNavigationController alloc] initWithRootViewController:qlistVC];
        [self addChildViewController:_followersNavigation];
        [_transitionView addSubview:_followersNavigation.view];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(toPan:)];
        [qlistVC.view addGestureRecognizer:pan];
    }
    else
    {
        [_transitionView bringSubviewToFront:_followersNavigation.view];
    }
    _messageNavigation.view.hidden = YES;
    _followersNavigation.view.hidden = NO;
    _discoveryNavigation.view.hidden = YES;
    _profileNavigation.view.hidden = YES;
    _questionNavigation.view.hidden = YES;
}

- (void)showDiscoveryViewController
{
    if (_discoveryNavigation == nil)
    {
        JPDiscoveryViewController *qlistVC = [[JPDiscoveryViewController alloc] init];
        _discoveryNavigation = [[HWBaseNavigationController alloc] initWithRootViewController:qlistVC];
        [self addChildViewController:_discoveryNavigation];
        [_transitionView addSubview:_discoveryNavigation.view];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(toPan:)];
        [qlistVC.view addGestureRecognizer:pan];
    }
    else
    {
        [_transitionView bringSubviewToFront:_discoveryNavigation.view];
    }
    _messageNavigation.view.hidden = YES;
    _followersNavigation.view.hidden = YES;
    _discoveryNavigation.view.hidden = NO;
    _profileNavigation.view.hidden = YES;
    _questionNavigation.view.hidden = YES;
}

- (void)showProfileViewController
{
    if (_profileNavigation == nil)
    {
        JPProfileViewController *qlistVC = [[JPProfileViewController alloc] init];
        _profileNavigation = [[HWBaseNavigationController alloc] initWithRootViewController:qlistVC];
        [self addChildViewController:_profileNavigation];
        [_transitionView addSubview:_profileNavigation.view];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(toPan:)];
        [qlistVC.view addGestureRecognizer:pan];
    }
    else
    {
        [_transitionView bringSubviewToFront:_profileNavigation.view];
    }
    
    _messageNavigation.view.hidden = YES;
    _followersNavigation.view.hidden = YES;
    _discoveryNavigation.view.hidden = YES;
    _profileNavigation.view.hidden = NO;
    _questionNavigation.view.hidden = YES;
}

#pragma mark -- JPRootRefreshView Delegate --

- (void)didSelectRootIndex:(NSInteger)index
{
    [self transitionAnimateByIndex:index];
}

- (void)addCoverView
{
//    if (_coverView == nil)
//    {
//        AppDelegate *appDel = SHARED_APP_DELEGATE;
//        
//        _coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
//        _coverView.backgroundColor = [UIColor cyanColor];
//        _coverView.layer.masksToBounds = YES;
//        
//        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
//        UIImage *image = [Utility getScreenShotWithView:appDel.window];
//        imgV.image = image;
//        [_coverView addSubview:imgV];
//        
//        [_transitionView addSubview:_coverView];
//    }
}

- (void)removeCoverView
{
//    if (_coverView != nil)
//    {
//        [_coverView removeFromSuperview];
//        _coverView = nil;
//    }
}

- (void)reloadStatusBar
{
//    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)])
//    {
//        [self prefersStatusBarHidden];
//        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
//    }
}

- (void)toPan:(UIGestureRecognizer *)sender
{
    AppDelegate *appDel = SHARED_APP_DELEGATE;
    
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        [self addCoverView];
        _startPoint = [sender locationInView:appDel.window];
        
        _statusHidden = YES;
        [self reloadStatusBar];
        
    }
    else if (sender.state == UIGestureRecognizerStateChanged)
    {
        CGPoint newPoint = [sender locationInView:appDel.window];
        
        CGFloat deltaX = newPoint.x - _startPoint.x;
        
        CGFloat targetX = _transitionView.center.x + deltaX;
        
        NSLog(@"%f %f", targetX, _transitionView.center.x);
        
        _transitionView.center = CGPointMake(MAX(kScreenWidth / 2.0f, _transitionView.center.x + deltaX), _transitionView.center.y);
        _startPoint = newPoint;
        
    }
    else if (sender.state == UIGestureRecognizerStateEnded)
    {
        CGPoint newPoint = [sender locationInView:appDel.window];
        CGFloat deltaX = newPoint.x - _startPoint.x;
        
        CGFloat targetX = _transitionView.center.x + deltaX;
        
        if (targetX - kScreenWidth / 2.0f > kScreenWidth / 3.0f)
        {
            [UIView animateWithDuration:0.4f animations:^{
                _transitionView.center = CGPointMake(kScreenWidth + kScreenWidth / 2.0f - 100, _transitionView.center.y);
            }];
        }
        else
        {
            [UIView animateWithDuration:0.4f animations:^{
                _transitionView.center = CGPointMake(kScreenWidth / 2.0f, _transitionView.center.y);
                
            }completion:^(BOOL finished) {
                
                [self removeCoverView];
                _statusHidden = NO;
                [self reloadStatusBar];
                
            }];
        }
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
