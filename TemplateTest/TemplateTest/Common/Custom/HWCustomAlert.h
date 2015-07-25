//
//  HWCustomAlert.h
//  Template-OC
//
//  Created by niedi on 15/4/9.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LocalAuthentication/LocalAuthentication.h>

typedef NS_ENUM(NSInteger, HWCustomAlertStyle)
{
    HWCustomAlertStyleDefault = 0,
    HWCustomAlertStyleTextInput
};



@class HWCustomAlert;

@protocol HWCustomAlertDelegate <NSObject>

@optional
- (void)alert:(HWCustomAlert *)alert didClickBtnItemAtIndex:(NSInteger)index;
- (void)alert:(HWCustomAlert *)alert didClickBtnItemAtIndex:(NSInteger)index text:(NSString *)str;
- (void)alertTouchIDSuccessed:(BOOL)isSucced didClickBtnItemIndex:(NSInteger)index;

@end



#define AlertBackControlColor                       [UIColor colorWithWhite:0.0f alpha:0.3f]    //背景色
#define AlertHandleViewBackgroundColor              UIColorFromRGB(0xffffff)        //操作视图背景色

#define TitleFont                           18.0f                            //标题字体大小
#define MessageFont                         15.0f                            //内容字体大小
#define BtnFont                             18.0f                            //buttton字体大小


@interface HWCustomAlert : UIView
{
    HWCustomAlertStyle _style;
    UIView *_handleView;                //操作视图
    UIDeviceOrientation _orientation;   //记录上一次方向
}
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *cancleButtonTitle;
@property (nonatomic, copy) NSString *otherButtonTitle;
@property (nonatomic, weak) id<HWCustomAlertDelegate> delegate;

/**
 *	@brief  初始化Alert         封装的TouchID.
 *
 *  @param  message            提示信息 touchId提示
 *
 *	@return	返回实例.
 */
+ (instancetype)alertWithReason:(NSString *)message;


/**
 *	@brief  初始化Alert.
 *
 *	@param 	cancelButtonTitle  默认取消title.
 *	@param 	otherButtonTitle   其它title: 若传nil 则只显示cancelButtonTitle.
 *  @param  message            提示信息 style为TextInput: 是placeholder; Default: 是提示内容
 *  @param  title              标题
 *
 *	@return	返回实例.
 */
+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message delegate:(id<HWCustomAlertDelegate>)delegate cancelButtonTitle:(NSString *)cancleButtonTitle otherButtonTitle:(NSString *)otherButtonTitle style:(HWCustomAlertStyle)style;


/**
 *	@brief  显示Alert在Window上.
 */
- (void)show;


@end
