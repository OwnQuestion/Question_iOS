//
//  UIButton+Utils.h
//  Template-OC
//
//  Created by wuxiaohong on 15/4/2.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Utils)

// 设置激活状态
- (void)setActiveState;
// 设置未激活状态
- (void)setInactiveState;
//圆角，颜色自定、
-(void)setBtnStyle:(UIColor *)color;
//带阴影的按钮
-(void)setButtonBackgroundShadowHighlight:(UIColor * )color;

@end
