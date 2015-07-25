//
//  JPQuestionListRefreshView.h
//  TemplateTest
//
//  Created by caijingpeng on 15/6/25.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "HWBaseRefreshView.h"
#import "JPQuestionCell.h"

@protocol JPQuestionListRefreshViewDelegate <NSObject>

- (void)didSelectedQuestion:(JPQuestionModel *)question;

@end

@interface JPQuestionListRefreshView : HWBaseRefreshView

@property (nonatomic, assign) id<JPQuestionListRefreshViewDelegate> delegate;

- (void)reloadListData:(NSMutableArray *)dataList;


@end
