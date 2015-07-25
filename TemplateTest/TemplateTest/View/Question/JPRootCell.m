//
//  JPRootCell.m
//  TemplateTest
//
//  Created by caijingpeng on 15/6/25.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "JPRootCell.h"

@implementation JPRootCell

@synthesize iconImgV;
@synthesize titleLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.iconImgV = [[UIImageView alloc] initWithFrame:CGRectMake(30, ([JPRootCell getCellHeight] - 20) / 2.0f, 20, 20)];
        self.iconImgV.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.iconImgV];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImgV.frame) + 30, 0, kScreenWidth, [JPRootCell getCellHeight])];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = FONT(TF_BigTitle);
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

+ (NSString *)getCellIdentify
{
    return @"rootcell";
}

+ (CGFloat)getCellHeight
{
    return ceilf(kScreenHeight * 2 * 0.05);
}

- (void)setRootCellSelected:(BOOL)isSelected
{
    if (isSelected)
    {
        
    }
    else
    {
        
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
