//
//  HWCustomActionSheet.m
//  Template-OC
//
//  Created by niedi on 15/4/7.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "HWCustomActionSheet.h"

@implementation HWCustomActionSheet

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//!!!!: 普通Picker类型
+ (id)actionSheetWithDelegate:(id<HWCustomActionSheetDelegate>)delegate titleArr:(NSArray *)titleArr otherTitleArr:(NSArray *)otherArrs, ...NS_REQUIRES_NIL_TERMINATION
{
    NSMutableArray* arrays = [NSMutableArray array];
    
    if (titleArr != nil)
    {
        [arrays addObject:titleArr];
    }
    
    va_list argList;
    
    if (otherArrs)
    {
        [arrays addObject:otherArrs];
        va_start(argList, otherArrs);
        
        NSArray *arg;
        while ((arg = va_arg(argList, NSArray *)))
        {
            if (arg)
            {
                [arrays addObject:arg];
            }
        }
        va_end(argList);
    }
    
    return [[self alloc] initWithDelegate:delegate titleArr:arrays];
}

- (id)initWithDelegate:(id<HWCustomActionSheetDelegate>)delegate titleArr:(NSArray *)titleArr
{
    if (self = [super init])
    {
        self.titleArr = titleArr;
        self.delegate = delegate;
        self.picker = [[UIPickerView alloc] init];
        self.picker.delegate = self;
        self.handleViewHeight = HigHeightForPicker;
        [self addOrientationChangedObserver];
    }
    
    return self;
}

//!!!!: DatePicker类型
+ (id)actionSheetWithDelegate:(id<HWCustomActionSheetDelegate>)delegate date:(NSDate *)date
{
    return [[self alloc] initWithDelegate:delegate date:date];
}

- (id)initWithDelegate:(id<HWCustomActionSheetDelegate>)delegate date:(NSDate *)date
{
    if (self = [super init])
    {
        self.delegate = delegate;
        if (date == nil)
        {
            date = [NSDate date];
        }
        self.datePicker = [[UIDatePicker alloc] init];
        self.datePicker.date = date;
        self.handleViewHeight = HigHeightForDatePicker;
        [self addOrientationChangedObserver];
    }
    
    return self;
}

//!!!!: 图标文字类型ActionSheet
+ (id)actionSheetWithDelegate:(id<HWCustomActionSheetDelegate>)delegate imageArray:(NSArray *)imgArr
{
    return [self actionSheetWithDelegate:delegate imageArray:imgArr titleArray:nil];
}

+ (id)actionSheetWithDelegate:(id<HWCustomActionSheetDelegate>)delegate imageArray:(NSArray *)imgArr titleArray:(NSArray *)titleArr
{
    return [[self alloc] initWithDelegate:delegate imageArray:imgArr titleArray:titleArr];
}

- (id)initWithDelegate:(id<HWCustomActionSheetDelegate>)delegate imageArray:(NSArray *)imgArr titleArray:(NSArray *)titleArr
{
    self = [super init];
    if (self)
    {
        self.delegate = delegate;
        self.imgArr = imgArr;
        self.titleArr = titleArr;
        
        if (self.imgArr.count <= 4)
        {
            self.handleViewHeight = LowHeight;
        }
        else
        {
            self.handleViewHeight = HigHeight;
        }
        [self addOrientationChangedObserver];
    }
    
    return self;
}

//!!!!: 添加旋转监听
- (void)addOrientationChangedObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(delay) name:UIDeviceOrientationDidChangeNotification object:nil];  //旋转通知
}

//!!!!: 旋转延迟
- (void)delay
{
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    resignResponseControl.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    resignResponseControl.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.0f];
    
    [UIView animateWithDuration:0.3f animations:^{
        self.handleView.frame = CGRectMake(0, self.frame.size.height, self.handleView.frame.size.width, self.handleView.frame.size.height);
    } completion:^(BOOL finished) {
        [self.handleView removeFromSuperview];
        [resignResponseControl removeFromSuperview];
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(changeFrames) object:nil];
        [self performSelector:@selector(changeFrames) withObject:nil afterDelay:0.1];
    }];
}

- (void)changeFrames
{
    if (self.super_View)
    {
        [self showInView:self.super_View];
    }
}

- (void)showInView:(UIView *)view   //启动\显示调用
{
    //改变实例方向
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [self loadUI];
    
    [view addSubview:self];
    self.super_View = view;
    
    @synchronized(self)
    {
        [UIView animateWithDuration:0.3f animations:^{
            resignResponseControl.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.3];
            CGFloat y = view.frame.size.height - self.handleView.frame.size.height;
            CGFloat width = view.frame.size.width;
            CGFloat hight = self.handleView.frame.size.height;
            self.handleView.frame = CGRectMake(0, y, width, hight);
        }];
    }
}

- (void)loadUI
{
    self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.0f];
    
    resignResponseControl = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    resignResponseControl.backgroundColor = [UIColor clearColor];
    [resignResponseControl addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:resignResponseControl];
    
    self.handleView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, self.handleViewHeight )];
    self.handleView.backgroundColor = ActionSheetHandleViewBackgroundColor;
    [self addSubview:self.handleView];
    
    if (_datePicker)
    {
        [self loadSubViewForDatePicker];
    }
    else if (_picker)
    {
        [self loadSubviewForPickerNormal];
    }
    else
    {
        [self loadSubViewForNormal];
    }
}

- (void)loadSubViewForNormal
{
    NSInteger count = self.imgArr.count;
    NSInteger countCase = count > 4 ? 4 : count;
    NSInteger firstViewX = self.frame.size.width/2 - ((countCase - 1) / 2.0f * Gap(self.frame.size.width) + countCase * SubViewWidth / 2.0f);
    for (int i = 0; i < count; i++)
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(firstViewX + i % 4 * (SubViewWidth + Gap(self.frame.size.width)), MarginTop + i/4 * (SubViewWidth + 45), SubViewWidth, SubViewWidth);
        [button setBackgroundImage:[UIImage imageNamed:self.imgArr[i]] forState:UIControlStateNormal];
        button.tag = 222 + i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.handleView addSubview:button];
        
        if (self.titleArr.count > i)
        {
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(button.center.x - SubViewWidth / 2 - Gap(self.frame.size.width) / 2.0, button.center.y + button.frame.size.height / 2 + 3, SubViewWidth + Gap(self.frame.size.width) / 2.0, 30)];
            CGPoint center = label.center;
            center.x = button.center.x;
            label.center = center;
            label.text = self.titleArr[i];
            label.font = [UIFont fontWithName:FONTNAME size:TF_SubTitle];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = TITLE_COLOR_33;
            label.tag = 333 + i;
            label.lineBreakMode = NSLineBreakByWordWrapping;
            label.numberOfLines = 0;
            label.textAlignment = NSTextAlignmentCenter;
            [self.handleView addSubview:label];
        }
    }
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtn.frame = CGRectMake(MarginLeft, self.handleView.frame.size.height - 70, self.frame.size.width - MarginLeft * 2, 45);
    self.cancelBtn.titleLabel.font = [UIFont fontWithName:FONTNAME size:TF_BigTitle];
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    self.cancelBtn.tag = 221;
    self.cancelBtn.layer.cornerRadius = 3.0f;
    self.cancelBtn.layer.masksToBounds = YES;
    [self.cancelBtn setBackgroundImage:[Utility imageWithColor:CancleBtnBackgroundColor andSize:self.cancelBtn.frame.size] forState:UIControlStateNormal];
    [self.cancelBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.handleView addSubview:self.cancelBtn];
}

- (void)loadSubViewForDatePicker
{
    CGPoint center = self.datePicker.center;
    center.x = self.handleView.center.x;
    self.datePicker.center = center;
    [self.handleView addSubview:self.datePicker];
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtn.frame = CGRectMake(MarginLeft, self.handleView.frame.size.height - 70, self.frame.size.width - MarginLeft * 2, 45);
    self.cancelBtn.titleLabel.font = [UIFont fontWithName:FONTNAME size:TF_BigTitle];
    [self.cancelBtn setTitle:@"确定" forState:UIControlStateNormal];
    self.cancelBtn.layer.cornerRadius = 3.0f;
    self.cancelBtn.layer.masksToBounds = YES;
    [self.cancelBtn setBackgroundImage:[Utility imageWithColor:CancleBtnBackgroundColor andSize:self.cancelBtn.frame.size] forState:UIControlStateNormal];
    [self.cancelBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.handleView addSubview:self.cancelBtn];
}

- (void)loadSubviewForPickerNormal
{
    self.picker.frame = CGRectMake(MarginLeft, 0, kScreenWidth - 2 * MarginLeft, HigHeightForPicker - 45 - 20);
    
    CGPoint center = self.picker.center;
    center.x = self.handleView.center.x;
    self.picker.center = center;
    [self.handleView addSubview:self.picker];
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtn.frame = CGRectMake(MarginLeft, self.handleView.frame.size.height - 70, self.frame.size.width - MarginLeft * 2, 45);
    self.cancelBtn.titleLabel.font = [UIFont fontWithName:FONTNAME size:TF_BigTitle];
    [self.cancelBtn setTitle:@"确定" forState:UIControlStateNormal];
    self.cancelBtn.layer.cornerRadius = 3.0f;
    self.cancelBtn.layer.masksToBounds = YES;
    [self.cancelBtn setBackgroundImage:[Utility imageWithColor:CancleBtnBackgroundColor andSize:self.cancelBtn.frame.size] forState:UIControlStateNormal];
    [self.cancelBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.handleView addSubview:self.cancelBtn];
}

- (void)buttonClick:(id)sender
{
    [self delegateAction:[(UIView *)sender tag] - 222];
}

- (void)delegateAction:(NSInteger)index
{
    if (self.datePicker)
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(actionSheet:selectDate:)])
        {
            [self.delegate actionSheet:self selectDate:self.datePicker.date];
        }
        [self cancle];
    }
    else if (self.picker)
    {
        [self cancle];
    }
    else
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(actionSheet:didClickBtnItemAtIndex:)])
        {
            [self.delegate actionSheet:self didClickBtnItemAtIndex:index];
        }
        [self cancle];
    }
}

//隐藏\结束
- (void)cancle
{
    [UIView animateWithDuration:0.3f animations:^{
        resignResponseControl.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.0f];
        self.handleView.frame = CGRectMake(0, self.frame.size.height, self.handleView.frame.size.width, self.handleView.frame.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

//!!!!: pickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.titleArr.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [[self.titleArr pObjectAtIndex:component] count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [[self.titleArr pObjectAtIndex:component] pObjectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(actionSheet:selectTitle:Row:imComponent:)])
    {
        [self.delegate actionSheet:self selectTitle:[[self.titleArr pObjectAtIndex:component] pObjectAtIndex:row] Row:row imComponent:component];
    }
}

@end
