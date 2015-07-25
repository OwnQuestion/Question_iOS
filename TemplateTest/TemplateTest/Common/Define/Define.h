//
//  Define.h
//  Template-OC
//
//  Created by niedi on 15/4/2.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#ifndef Template_OC_Define_h
#define Template_OC_Define_h

/* 
 AppDelegate
 */
#define SHARED_APP_DELEGATE             (AppDelegate *)[UIApplication sharedApplication].delegate


/*  UIColor
 */
#define UIColorFromRGB(rgbValue)	    UIColorFromRGBA(rgbValue,1.0)

#define UIColorFromRGBA(rgbValue,a)	    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]


/*  DocumentPath
 */
#define DocumentPath                    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]


/*  iOS版本
 */
#define IOS7                            ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)
#define IOS7Dot0                        ([[[UIDevice currentDevice] systemVersion] floatValue] == 7.0 ? YES : NO)
#define IOS8                            ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? YES : NO)


/*  屏幕尺寸
 */
#define IPHONE4                         ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define IPHONE5                         ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define IPHONE6                         ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define IPHONE6PLUS                         ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)


/*  设备方向
 */
#define Portrait            ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortrait ? YES : NO)
#define PortraitUpsideDown  ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortraitUpsideDown ? YES : NO)
#define LandscapeLeft       ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeLeft ? YES : NO)
#define LandscapeRight      ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeRight ? YES : NO)


/*  宽高
 */
#define CONTENT_HEIGHT                  ([UIScreen mainScreen].bounds.size.height - 64)
#define kScreenHeight                   [UIScreen mainScreen].bounds.size.height
#define kScreenWidth                    [UIScreen mainScreen].bounds.size.width

#define kx3Rate                              (IPHONE6PLUS ? 1.5 : 1)
#define kLineHeight                          (0.5 * kx3Rate)

/*  较iPhone4屏宽比例
 */
#define kScreenRate                     ([UIScreen mainScreen].bounds.size.width / 320.0f)


/*  颜色
 CD For Color Define
 */

#define CD_YELLOW                       UIColorFromRGB(0xffe15b)
#define CDBACKGROUND                    UIColorFromRGB(0xefefef)
#define CDLineColor                     UIColorFromRGB(0x7c7c7c)   //线条颜色,画线
#define CD_Btn_MainColor                UIColorFromRGB(0xff6600)
#define CD_Text                         UIColorFromRGB(0x0a0b0b)
#define CD_TextMidLight                 UIColorFromRGB(0x4e4e4e)
#define CD_TextLight                    UIColorFromRGB(0xbababa)

/*  字体
 TF For Text Font
 */
#define FONTNAME                    @"Helvetica Neue"
#define FONT(fontSize)              [UIFont fontWithName:@"Montserrat-Regular" size:fontSize]
#define IMAGE(imageName)            [UIImage imageNamed:imageName]

#define TF_BigTitle                             19.0f
#define TF_Title                                15.0f
#define TF_SubTitle                             13.0f
#define TF_Small                                11.0f


/*  存储命名
 UD For userdefaults
 */
#define UDFirstLanunch                  @"firstLaunch"          // 首次启动



/*  定义
 DF For Define
 */
#define DFSHARE_TITLE                   @"和我一起做一只懒懒的考拉"



/*  key
 K For Key
 */

#define KUMENG                                  @""



/*  通知
 NT For Notification
 */
#define NTPAY_SUCCESS                                     @"pay_success"

#define kLocationSuccessNotification            @"kLocationSuccessNotification"
#define kLocationFailNotification               @"kLocationFailNotification"
/*
 各种key值
 */

//友盟key
#define UmengAppkey @"5211818556240bc9ee01db2f"

#endif

