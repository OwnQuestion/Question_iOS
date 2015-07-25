//
//  HWUserLogin.m
//  Template-OC
//
//  Created by niedi on 15/4/3.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "HWUserLogin.h"

@implementation HWUserLogin

static HWUserLogin *userLogin = nil;

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.username = nil;
        self.password = nil;
        self.nickname = nil;
        self.avatar = nil;
        self.gender = nil;
        self.telephoneNum = nil;
        self.userId = nil;
        self.key = nil;
    }
    
    return self;
}

+ (HWUserLogin *)currentUserLogin
{
    static dispatch_once_t onceToken;
    static HWUserLogin *userLogin = nil;
    dispatch_once(&onceToken, ^{
        if (userLogin == nil)
        {
            userLogin = [[HWUserLogin alloc] init];
        }
    });
    
    return userLogin;
}

- (void)userLogout
{
    self.username = nil;
    self.password = nil;
    self.nickname = nil;
    self.avatar = nil;
    self.gender = nil;
    self.telephoneNum = nil;
    self.userId = nil;
    self.key = nil;
}

@end
