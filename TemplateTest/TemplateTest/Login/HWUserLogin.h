//
//  HWUserLogin.h
//  Template-OC
//
//  Created by niedi on 15/4/3.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWUserLogin : NSObject

@property (nonatomic, strong) NSString *username;//用户名称
@property (nonatomic, strong) NSString *password;//用户密码
@property (nonatomic, strong) NSString *nickname;//用户昵称
@property (nonatomic, strong) NSString *avatar;//头像
@property (nonatomic, strong) NSString *gender;//性别
@property (nonatomic, strong) NSString *telephoneNum;//电话号码
@property (nonatomic, strong) NSString *userId;//用户ID
@property (nonatomic, strong) NSString *key;//key


+ (HWUserLogin *)currentUserLogin;

// 注销
- (void)userLogout;



@end
