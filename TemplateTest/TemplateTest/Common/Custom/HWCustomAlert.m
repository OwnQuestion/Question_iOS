//
//  HWCustomAlert.m
//  Template-OC
//
//  Created by niedi on 15/4/9.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "HWCustomAlert.h"

@implementation HWCustomAlert

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark -
#pragma mark - Normal类型
+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message delegate:(id<HWCustomAlertDelegate>)delegate cancelButtonTitle:(NSString *)cancleButtonTitle otherButtonTitle:(NSString *)otherButtonTitle style:(HWCustomAlertStyle)style
{
    return [[self alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancleButtonTitle otherButtonTitle:otherButtonTitle style:style];
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id<HWCustomAlertDelegate>)delegate cancelButtonTitle:(NSString *)cancleButtonTitle otherButtonTitle:(NSString *)otherButtonTitle style:(HWCustomAlertStyle)style;
{
    if (self = [super init])
    {
        _style = style;
        self.title = title;
        self.message = message;
        self.delegate = delegate;
        self.cancleButtonTitle = cancleButtonTitle;
        self.otherButtonTitle = otherButtonTitle;
        
        [self addOrientationChangedObserver];
        [self loadUI];
    }
    return self;
}


#pragma mark -
#pragma mark - 旋转监听
- (void)addOrientationChangedObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(delay) name:UIDeviceOrientationDidChangeNotification object:nil];  //旋转通知
}

//旋转延迟
- (void)delay
{
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    CGPoint center = self.center;
    _handleView.center = center;
}


#pragma mark -
#pragma mark - UI
- (void)loadUI
{
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.backgroundColor = [UIColor clearColor];
    
    CGFloat width = IPHONE6PLUS ? 300 : 230;
    CGFloat heightTitle = [Utility calculateStringSize:self.title font:[UIFont fontWithName:FONTNAME size:TitleFont] constrainedSize:CGSizeMake(width - 2 * 15, 10000)].height;
    CGFloat heightMessage = [Utility calculateStringSize:self.message font:[UIFont fontWithName:FONTNAME size:MessageFont] constrainedSize:CGSizeMake(width - 2 * 15, 10000)].height;
    
    CGFloat subWidth1 = [Utility calculateStringSize:self.cancleButtonTitle font:[UIFont fontWithName:FONTNAME size:30] constrainedSize:CGSizeMake(10000, 35)].width;
    CGFloat subWidth2 = [Utility calculateStringSize:self.otherButtonTitle font:[UIFont fontWithName:FONTNAME size:30] constrainedSize:CGSizeMake(10000, 35)].width;
    CGFloat subWidth = MAX(subWidth1, subWidth2);
    
    if (subWidth >= width / 2.0f - 2 * 15)
    {
        if (self.otherButtonTitle == nil || self.otherButtonTitle.length == 0)
        {
            _handleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 40 + 8 + heightTitle + heightMessage + 45)];
        }
        else
        {
            _handleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 40 + 8 + heightTitle + heightMessage + 45 * 2)];
        }
    }
    else
    {
        _handleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 40 + 8 + heightTitle + heightMessage + 45)];
    }
    
    CGPoint center = self.center;
    _handleView.center = center;
    _handleView.backgroundColor = AlertHandleViewBackgroundColor;
    _handleView.layer.cornerRadius = 8.0f;
    _handleView.layer.masksToBounds = true;
    [self addSubview:_handleView];
    
    if (_style == HWCustomAlertStyleDefault)
    {
        [self loadSubViewForDefault];
    }
    else if(_style == HWCustomAlertStyleTextInput)
    {
        [self loadSubViewForTextInput];
    }
    else
    {
        
    }
}

- (void)loadSubViewForDefault
{
    CGFloat hight = [Utility calculateStringSize:self.title font:[UIFont fontWithName:FONTNAME size:TitleFont] constrainedSize:CGSizeMake(_handleView.frame.size.width - 2 * 15, 10000)].height;
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, _handleView.frame.size.width - 2 * 15, hight)];
    titleLab.backgroundColor = [UIColor clearColor];
    titleLab.font = [UIFont fontWithName:FONTNAME size:TitleFont];
    titleLab.textColor = UIColorFromRGB(0x000000);
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.numberOfLines = 0;
    titleLab.text = self.title;
    [_handleView addSubview:titleLab];
    
    hight = [Utility calculateStringSize:self.message font:[UIFont fontWithName:FONTNAME size:MessageFont] constrainedSize:CGSizeMake(_handleView.frame.size.width - 2 * 15, 10000)].height;
    UILabel *messageLab = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(titleLab.frame) + 5, _handleView.frame.size.width - 2 * 15, hight)];
    messageLab.backgroundColor = [UIColor clearColor];
    messageLab.font = [UIFont fontWithName:FONTNAME size:MessageFont];
    messageLab.textColor = UIColorFromRGB(0x444444);
    messageLab.textAlignment = NSTextAlignmentCenter;
    messageLab.numberOfLines = 0;
    messageLab.text = self.message;
    [_handleView addSubview:messageLab];
    
    [_handleView addSubview:[Utility drawLine:CGPointMake(0, CGRectGetMaxY(messageLab.frame) + 20 - 0.3) width:_handleView.frame.size.width]];
    
    CGFloat subWidth1 = [Utility calculateStringSize:self.cancleButtonTitle font:[UIFont fontWithName:FONTNAME size:30] constrainedSize:CGSizeMake(10000, 35)].width;
    CGFloat subWidth2 = [Utility calculateStringSize:self.otherButtonTitle font:[UIFont fontWithName:FONTNAME size:30] constrainedSize:CGSizeMake(10000, 35)].width;
    CGFloat subWidth = MAX(subWidth1, subWidth2);
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (subWidth >= _handleView.frame.size.width / 2.0f - 2 * 15)
    {
        cancleBtn.frame = CGRectMake(0, CGRectGetMaxY(messageLab.frame) + 20, _handleView.frame.size.width, 45);
        
        if (self.otherButtonTitle == nil || self.otherButtonTitle.length == 0)
        {
            confirmBtn.hidden = true;
        }
        else
        {
            [_handleView addSubview:[Utility drawLine:CGPointMake(0, CGRectGetMaxY(cancleBtn.frame) - 0.3) width:_handleView.frame.size.width]];
            confirmBtn.frame = CGRectMake(0, CGRectGetMaxY(cancleBtn.frame), CGRectGetWidth(cancleBtn.frame), 48);
        }
    }
    else
    {
        if (self.otherButtonTitle == nil || self.otherButtonTitle.length == 0)
        {
            cancleBtn.frame = CGRectMake(0, CGRectGetMaxY(messageLab.frame) + 20, _handleView.frame.size.width, 48);
        }
        else
        {
            cancleBtn.frame = CGRectMake(0, CGRectGetMaxY(messageLab.frame) + 20, _handleView.frame.size.width / 2.0f - 0.3, 48);
            [_handleView addSubview:[Utility drawVerticalLine:CGPointMake(CGRectGetWidth(cancleBtn.frame), CGRectGetMinY(cancleBtn.frame)) height:48]];
            confirmBtn.frame = CGRectMake(CGRectGetWidth(cancleBtn.frame) + 0.5, CGRectGetMinY(cancleBtn.frame), CGRectGetWidth(cancleBtn.frame), 48);
        }
    }
    cancleBtn.titleLabel.font = [UIFont fontWithName:FONTNAME size:BtnFont];
    [cancleBtn setTitleColor:UIColorFromRGB(0x308afa) forState:UIControlStateNormal];
    [cancleBtn setTitle:self.cancleButtonTitle forState:UIControlStateNormal];
    [cancleBtn setBackgroundImage:[Utility imageWithColor:[UIColor whiteColor] andSize:cancleBtn.frame.size] forState:UIControlStateNormal];
    [cancleBtn setBackgroundImage:[Utility imageWithColor:UIColorFromRGB(0xe6e6e6) andSize:cancleBtn.frame.size] forState:UIControlStateHighlighted];
    [cancleBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    cancleBtn.tag = 1101;
    [_handleView addSubview:cancleBtn];
    
    confirmBtn.titleLabel.font = [UIFont fontWithName:FONTNAME size:BtnFont];
    [confirmBtn setTitleColor:UIColorFromRGB(0x308afa) forState:UIControlStateNormal];
    [confirmBtn setTitle:self.otherButtonTitle forState:UIControlStateNormal];
    [confirmBtn setBackgroundImage:[Utility imageWithColor:[UIColor whiteColor] andSize:cancleBtn.frame.size] forState:UIControlStateNormal];
    [confirmBtn setBackgroundImage:[Utility imageWithColor:UIColorFromRGB(0xe6e6e6) andSize:cancleBtn.frame.size] forState:UIControlStateHighlighted];
    [confirmBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    confirmBtn.tag = 1102;
    [_handleView addSubview:confirmBtn];
    
}

- (void)loadSubViewForTextInput
{
    
}

#pragma mark -
#pragma mark - BtnClick
- (void)btnClick:(UIView *)view
{
    if (view.tag == 1101)
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(alert:didClickBtnItemAtIndex:)])
        {
            [self.delegate alert:self didClickBtnItemAtIndex:0];
        }
    }
    else
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(alert:didClickBtnItemAtIndex:)])
        {
            [self.delegate alert:self didClickBtnItemAtIndex:1];
        }
    }
    [self hide];
}


#pragma mark -
#pragma mark - 显示
- (void)show
{
    [[UIApplication sharedApplication].delegate.window addSubview:self];
    
    CABasicAnimation *scale=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    scale.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    scale.duration = 0.25;
    scale.fromValue = [NSNumber numberWithFloat:2];
    scale.toValue = [NSNumber numberWithFloat:1];
    
    CABasicAnimation *opacity=[CABasicAnimation animationWithKeyPath:@"opacity"];
    
    opacity.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    opacity.duration = 0.25;
    opacity.fromValue = [NSNumber numberWithFloat:0];
    opacity.toValue = [NSNumber numberWithFloat:1];
    
    
    [_handleView.layer addAnimation:scale forKey:@"sc"];
    [_handleView.layer addAnimation:opacity forKey:@"op"];
    
    [UIView animateWithDuration:0.3f animations:^{
        self.backgroundColor = AlertBackControlColor;
    }];
}

- (void)hide
{
    CABasicAnimation *scale=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    scale.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    scale.duration =0.25;
    scale.fromValue = [NSNumber numberWithFloat:1];
    scale.toValue = [NSNumber numberWithFloat:0.8];
    
    CABasicAnimation *opacity=[CABasicAnimation animationWithKeyPath:@"opacity"];
    
    opacity.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    opacity.duration = 0.25;
    opacity.fromValue = [NSNumber numberWithFloat:1];
    opacity.toValue = [NSNumber numberWithFloat:0];
    
    
    [_handleView.layer addAnimation:scale forKey:@"sc"];
    [_handleView.layer addAnimation:opacity forKey:@"op"];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.backgroundColor = [UIColor clearColor];
        
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}


#pragma mark -
#pragma mark - 封装的TouchID
+ (instancetype)alertWithReason:(NSString *)message
{
    return [[self alloc] initWithReason:message];
}

- (instancetype)initWithReason:(NSString *)message;
{
    if (self = [super init])
    {
        // 初始化验证上下文
        LAContext *context = [[LAContext alloc] init];
        NSError *error = nil;
        // 验证的原因, 应该会显示在会话窗中
        NSString *reason = message;
        // 判断是否能够进行验证
        if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error])
        {
            [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:reason reply:^(BOOL succes, NSError *error)
             {
                 if (succes)
                 {
                     if (self.delegate && [self.delegate respondsToSelector:@selector(alertTouchIDSuccessed:didClickBtnItemIndex:)])
                     {
                         [self.delegate alertTouchIDSuccessed:succes didClickBtnItemIndex:-1];
                     }
                 }
                 else
                 {
                     if (error.code == kLAErrorUserFallback)
                     {
                         if (self.delegate && [self.delegate respondsToSelector:@selector(alertTouchIDSuccessed:didClickBtnItemIndex:)])
                         {
                             [self.delegate alertTouchIDSuccessed:succes didClickBtnItemIndex:0];
                         }
                     }
                     else if (error.code == kLAErrorUserCancel)
                     {
                         if (self.delegate && [self.delegate respondsToSelector:@selector(alertTouchIDSuccessed:didClickBtnItemIndex:)])
                         {
                             [self.delegate alertTouchIDSuccessed:succes didClickBtnItemIndex:1];
                         }
                     }
                     else
                     {
                         NSLog(@"Authenticated failed.");
                     }
                 }
             }];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的设备不支持TouchID" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
        }
    }
    
    return self;
}

@end
