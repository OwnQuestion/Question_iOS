//
//  JPQuestionCell.h
//  TemplateTest
//
//  Created by caijingpeng on 15/6/25.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "HWBaseTableViewCell.h"
#import "JPTagView.h"
#import "JPIconLabel.h"
#import "JPQuestionModel.h"

@interface JPQuestionCell : HWBaseTableViewCell

@property (nonatomic, strong) UIImageView *headImgV;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *questionLabel;
@property (nonatomic, strong) JPIconLabel *commentLabel;
@property (nonatomic, strong) JPIconLabel *praiseLabel;
@property (nonatomic, strong) NSMutableArray *tagArray;

- (void)setQuestionModel:(JPQuestionModel *)model;

+ (NSString *)getCellIdentify;
+ (CGFloat)getCellHeight:(JPQuestionModel *)model;

@end
