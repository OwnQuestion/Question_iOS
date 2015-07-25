//
//  HWCustomActionSheet.h
//  Template-OC
//
//  Created by niedi on 15/4/7.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HigHeightForPicker              240                 //操作视图默认高度(NormalPicker)
#define HigHeightForDatePicker          285                 //操作视图默认高度(DatePicker)
#define HigHeight                       285                 //操作视图默认高度(两行)
#define LowHeight                       178                 //操作视图默认高度(一行)

#define MarginTop                       20                  //操作视图子控件距上边缘距离
#define MarginLeft                 (Portrait||PortraitUpsideDown ? 17.0f : 97.0f)  //操作视图子控件距距左边缘距离
#define SubViewWidth                       55                 //操作视图子控件大小
#define Gap(HandleViewWidth)       (HandleViewWidth - 2 * MarginLeft - 4 * SubViewWidth) / 3.0f                                                     //操作视图子控件间间距

#define ActionSheetBackControlColor                    [UIColor colorWithWhite:0.0f alpha:0.0f]    //Control背景色
#define ActionSheetHandleViewBackgroundColor           UIColorFromRGB(0xeaeaea)    //操作视图背景色
#define CancleBtnBackgroundColor                       UIColorFromRGB(0xff8000)    //确定按钮背景色

#define TITLE_COLOR_33                      UIColorFromRGB(0x333333)
#define THEME_COLOR_LINE                    UIColorFromRGB(0xd6d6d6)


@class HWCustomActionSheet;

@protocol HWCustomActionSheetDelegate <NSObject>

@optional
- (void)actionSheet:(HWCustomActionSheet *)actionSheet didClickBtnItemAtIndex:(NSInteger)index;
- (void)actionSheet:(HWCustomActionSheet *)actionSheet selectDate:(NSDate *)date;
- (void)actionSheet:(HWCustomActionSheet *)actionSheet selectTitle:(NSString *)str Row:(NSInteger)row imComponent:(NSInteger)component;

@end


@interface HWCustomActionSheet : UIView <UIPickerViewDataSource, UIPickerViewDelegate>
{
    UIControl *resignResponseControl; //control背景
    UIView *_handleView;           //操作视图
    UIButton *_cancelBtn;          //取消按钮
    NSInteger _handleViewHeight;    //操作视图高度
    
    UIDatePicker *_datePicker;     //时间选择器
    
    UIPickerView *_pickerView;      //普通选择器
}

@property (nonatomic, strong) UIView *handleView;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, readwrite) NSInteger handleViewHeight;

@property (nonatomic, strong) UIDatePicker *datePicker;

@property (nonatomic, strong) UIPickerView *picker;

@property (nonatomic, weak) id<HWCustomActionSheetDelegate> delegate;
@property (nonatomic, strong) NSArray *imgArr;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, weak) UIView *super_View;

/**
 *	@brief  初始化action sheet.
 *
 *	@param 	titleArr  默认title
 *
 *	@return	返回实例.
 */
+ (id)actionSheetWithDelegate:(id<HWCustomActionSheetDelegate>)delegate titleArr:(NSArray *)titleArr otherTitleArr:(NSArray *)otherArrs, ...NS_REQUIRES_NIL_TERMINATION;

/**
 *	@brief  初始化action sheet.
 *
 *	@param 	date  默认时间 若传nil默认当前时间
 *
 *	@return	返回实例.
 */
+ (id)actionSheetWithDelegate:(id<HWCustomActionSheetDelegate>)delegate date:(NSDate *)date;

/**
 *	@brief  初始化action sheet.
 *
 *	@param 	imageArray      按钮图片列表.
 *	@param 	titleArray      名字列表.
 *
 *	@return	返回实例.
 */
+ (id)actionSheetWithDelegate:(id<HWCustomActionSheetDelegate>)delegate imageArray:(NSArray *)imgArr;

+ (id)actionSheetWithDelegate:(id<HWCustomActionSheetDelegate>)delegate imageArray:(NSArray *)imgArr titleArray:(NSArray *)titleArr;

/**
 *	@brief  指定显示在某个view上.
 *
 *	@param 	view 	显示的view.
 */
- (void)showInView:(UIView *)view;

@end
