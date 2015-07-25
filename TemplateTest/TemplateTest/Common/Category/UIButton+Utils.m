//
//  UIButton+Utils.m
//  Template-OC
//
//  Created by wuxiaohong on 15/4/2.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "UIButton+Utils.h"

@implementation UIButton (Utils)
- (void)setActiveState
{
    self.userInteractionEnabled = YES;
    self.titleLabel.alpha = 1.0f;
}

- (void)setInactiveState
{
    self.userInteractionEnabled = NO;
    self.titleLabel.alpha = 0.5f;
}
-(void)setBtnStyle:(UIColor *)color
{
    [self setBackgroundImage:[Utility imageWithColor:color andSize:self.frame.size] forState:UIControlStateNormal];
    [self setBackgroundImage:[Utility imageWithColor:color andSize:self.frame.size] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.layer.cornerRadius = 3.0f;
    self.layer.masksToBounds = YES;

}
-(void)setButtonBackgroundShadowHighlight:(UIColor *)color
{
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 2);
    self.layer.shadowRadius = 3;
    self.layer.shadowOpacity = 0.3;
    self.backgroundColor = color;
}

@end
