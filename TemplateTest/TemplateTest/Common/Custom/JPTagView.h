//
//  JPTagView.h
//  TemplateTest
//
//  Created by caijingpeng on 15/6/25.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JPTagModel.h"

@interface JPTagView : UIView

@property (nonatomic, strong) JPTagModel *tagModel;

- (id)initWithTag:(JPTagModel *)model;

@end
