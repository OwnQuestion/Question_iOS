//
//  JPIconLabel.h
//  TemplateTest
//
//  Created by caijingpeng.haowu on 15/5/29.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    JPContentAlignmentLeft      = 0,    // Visually left aligned
    JPContentAlignmentCenter    = 1,    // Visually centered
    JPContentAlignmentRight     = 2
}JPContentAlignment;

@interface JPIconLabel : UIView
{
    UIView *_contentView;
}

@property (nonatomic, strong) UIButton *iconButton;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, assign) JPContentAlignment contentAlignment;
@property (nonatomic, assign) CGFloat betweenGap;

- (id)initWithFrame:(CGRect)frame headIcon:(UIImage *)image labelText:(NSString *)text font:(UIFont *)font gap:(CGFloat)gap;

- (void)setText:(NSString *)text;

@end
