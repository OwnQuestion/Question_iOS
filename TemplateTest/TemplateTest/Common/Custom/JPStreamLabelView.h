//
//  StreamLabelView.h
//  TestProject
//
//  Created by caijingpeng.haowu on 15/3/10.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JPStreamLabelView : UIView

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *colorArray;
@property (nonatomic, assign) float fontSize;

- (id)initWithTitleArray:(NSArray *)titles borderColors:(NSArray *)colors fontSize:(float)size constrainFrame:(CGRect)frame;

@end
