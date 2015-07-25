//
//  JPRootCell.h
//  TemplateTest
//
//  Created by caijingpeng on 15/6/25.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "HWBaseTableViewCell.h"

@interface JPRootCell : HWBaseTableViewCell

@property (nonatomic, strong) UIImageView *iconImgV;
@property (nonatomic, strong) UILabel *titleLabel;

- (void)setRootCellSelected:(BOOL)isSelected;

+ (CGFloat)getCellHeight;
+ (NSString *)getCellIdentify;

@end
