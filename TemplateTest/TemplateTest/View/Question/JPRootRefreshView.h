//
//  JPRootRefreshView.h
//  TemplateTest
//
//  Created by caijingpeng on 15/6/24.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "HWBaseRefreshView.h"

@protocol JPRootRefreshViewDelegate <NSObject>

- (void)didSelectRootIndex:(NSInteger)index;

@end

@interface JPRootRefreshView : HWBaseRefreshView

@property (nonatomic, assign) id<JPRootRefreshViewDelegate> delegate;

@end
