//
//  JPIconLabel.m
//  TemplateTest
//
//  Created by caijingpeng.haowu on 15/5/29.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "JPIconLabel.h"

@implementation JPIconLabel
@synthesize betweenGap;
@synthesize contentAlignment;

- (id)initWithFrame:(CGRect)frame headIcon:(UIImage *)image labelText:(NSString *)text font:(UIFont *)font gap:(CGFloat)gap
{
    self = [super initWithFrame:frame];
    if (self)
    {
        betweenGap = gap;
        
        
        self.backgroundColor = [UIColor clearColor];
        
        CGSize iconSize = CGSizeMake(image.size.width / 2.0f, image.size.height / 2.0f);
        
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
        _contentView.backgroundColor = [UIColor clearColor];
        [self addSubview:_contentView];
        
        self.iconButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.iconButton.frame = CGRectMake(0, 0, iconSize.width, iconSize.height);
        [self.iconButton setImage:image forState:UIControlStateNormal];
        [self.iconButton addTarget:self action:@selector(toSelect:) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:self.iconButton];
        
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.text = text;
        self.textLabel.font = font;
        self.textLabel.textColor = CD_Text;
        [_contentView addSubview:self.textLabel];
        
        [self.textLabel sizeToFit];
        
        [self reloadPosition];
        
        _contentView.center = CGPointMake(CGRectGetWidth(_contentView.frame) / 2.0f, CGRectGetHeight(self.frame) / 2.0f);
    }
    return self;
}

- (void)reloadPosition
{
    _contentView.frame = CGRectMake(0, 0, CGRectGetWidth(self.iconButton.frame) + betweenGap + CGRectGetWidth(self.textLabel.frame), MAX(CGRectGetHeight(self.iconButton.frame), CGRectGetHeight(self.textLabel.frame)));
    self.iconButton.frame = CGRectMake(0, (CGRectGetHeight(_contentView.frame) - self.self.iconButton.frame.size.height) / 2.0f, self.iconButton.frame.size.width, self.iconButton.frame.size.height);
    self.textLabel.frame = CGRectMake(CGRectGetMaxX(self.iconButton.frame) + betweenGap,
                                      CGRectGetMidY(self.iconButton.frame) - self.textLabel.frame.size.height / 2.0f - 1,
                                      self.textLabel.frame.size.width,
                                      self.textLabel.frame.size.height);
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, _contentView.frame.size.width, self.frame.size.height);
}

- (void)reloadAligment
{
    if (contentAlignment == JPContentAlignmentLeft)
    {
        _contentView.center = CGPointMake(CGRectGetWidth(_contentView.frame) / 2.0f, CGRectGetHeight(self.frame) / 2.0f);
    }
    else if (contentAlignment == JPContentAlignmentRight)
    {
        _contentView.center = CGPointMake(CGRectGetWidth(self.frame) - CGRectGetWidth(_contentView.frame) / 2.0f, CGRectGetHeight(self.frame) / 2.0f);
    }
    else if (contentAlignment == JPContentAlignmentCenter)
    {
        _contentView.center = CGPointMake(CGRectGetWidth(self.frame) / 2.0f, CGRectGetHeight(self.frame) / 2.0f);
    }
}

- (void)setContentAlignment:(JPContentAlignment)alignment
{
    contentAlignment = alignment;
    [self reloadAligment];
}

- (void)setText:(NSString *)text
{
    self.textLabel.text = text;
    [self.textLabel sizeToFit];
    [self reloadPosition];
    [self reloadAligment];
}

- (void)toSelect:(id)sender
{
    
}


@end
