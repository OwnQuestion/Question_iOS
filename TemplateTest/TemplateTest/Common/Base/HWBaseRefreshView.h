//
//  HWBaseRefreshView.h
//  Template-OC
//
//  Created by hw500028 on 4/15/15.
//  Copyright (c) 2015 caijingpeng.haowu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWBaseRefreshView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign) BOOL                isHeadLoading;
@property (nonatomic, assign) BOOL                isTailLoading;
@property (nonatomic, assign) BOOL                isNeedHeadRefresh;
@property (nonatomic, strong) UITableView *       baseTable;
@property (nonatomic, strong) NSMutableArray *    baseListArr;
@property (nonatomic, assign) NSInteger                 currentPage;
@property (nonatomic, assign) BOOL                isLastPage;

- (void)doneLoadingTableViewData;
- (void)showMBProgress;
- (void)hideProgress;

@end
