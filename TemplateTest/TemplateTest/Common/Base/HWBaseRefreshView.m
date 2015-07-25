//
//  HWBaseRefreshView.m
//  Template-OC
//
//  Created by hw500028 on 4/15/15.
//  Copyright (c) 2015 caijingpeng.haowu. All rights reserved.
//

#import "HWBaseRefreshView.h"
#import "EGORefreshTableFooterView.h"
#import "EGORefreshTableHeaderView.h"
#import "EGOViewCommon.h"
#import <SRRefreshView.h>

@interface HWBaseRefreshView()<SRRefreshDelegate,EGORefreshTableDelegate>
@property (nonatomic, strong) SRRefreshView             * slimeView;
@property (nonatomic, strong) EGORefreshTableFooterView * refreshFooterView;
@property (nonatomic, strong) EGORefreshTableHeaderView * refreshHeadView;
@property (nonatomic, strong) UIView                    * endView;
@property (nonatomic, assign) EGORefreshPos             pulldownState;



@end

@implementation HWBaseRefreshView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = CDBACKGROUND;
        [self addSubview:self.baseTable];
        [self.baseTable addSubview:self.slimeView];
        [self.baseTable addSubview:self.refreshFooterView];

    }
    return self;
}

#pragma mark - 初始化视图

- (UITableView *)baseTable
{
    if (_baseTable == nil)
    {
        _baseTable = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        _baseTable.delegate = self;
        _baseTable.dataSource = self;
        _baseTable.backgroundColor = [UIColor clearColor];
        _baseTable.backgroundView = nil;
        [_baseTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _baseTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _baseTable.showsVerticalScrollIndicator = NO;
    }
    return _baseTable;
}

- (SRRefreshView *)slimeView
{
    if (_slimeView == nil)
    {
        _slimeView = [[SRRefreshView alloc]init];
        _slimeView.slimeMissWhenGoingBack = YES;
        _slimeView.slime.bodyColor = CD_Btn_MainColor;
        _slimeView.slime.skinColor = [UIColor whiteColor];
        _slimeView.slime.lineWith = 1.0f;
        _slimeView.backgroundColor = [UIColor clearColor];
        _slimeView.delegate = self;
    }
    return _slimeView;

}

- (EGORefreshTableFooterView *)refreshFooterView
{
    CGFloat height = MAX(self.baseTable.contentSize.height, self.baseTable.frame.size.height);
    CGRect footerFrame = CGRectMake(0, height, self.baseTable.frame.size.width, self.bounds.size.height);
    
    if (_refreshFooterView == nil)
    {
        _refreshFooterView = [[EGORefreshTableFooterView alloc]initWithFrame:footerFrame];
        _refreshFooterView.backgroundColor = [UIColor clearColor];
        _refreshFooterView.delegate = self;
    }
    else
    {
        _refreshFooterView.frame = footerFrame;
    }
    
    if (self.isLastPage)
    {
        _refreshFooterView.hidden = YES;
    }
    else
    {
        _refreshFooterView.hidden = NO;
    }
    
    
    [_refreshFooterView refreshLastUpdatedDate];



    return _refreshFooterView;
}

#pragma mark - ScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (self.isNeedHeadRefresh)
    {
        [self.slimeView scrollViewDidScroll];
    }
    [self.refreshFooterView egoRefreshScrollViewDidScroll:scrollView];

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.isNeedHeadRefresh)
    {
        [self.slimeView scrollViewDidEndDraging];
    }
    if (!self.isHeadLoading && !self.isLastPage)
    {
        [self.refreshFooterView egoRefreshScrollViewDidEndDragging:scrollView];;
    }


}

#pragma mark - EGORefreshTableHeaderDelegate Methods

- (BOOL)egoRefreshTableDataSourceIsLoading:(UIView *)view
{
    return self.isHeadLoading;
}

- (void)slimeRefreshStartRefresh:(SRRefreshView *)refreshView
{
    [self beginToReloadData:EGORefreshHeader];
}

- (void)egoRefreshTableDidTriggerRefresh:(EGORefreshPos)aRefreshPos
{

    [self beginToReloadData:aRefreshPos];
    
}

- (void)beginToReloadData:(EGORefreshPos)aRefreshPos
{
    self.isHeadLoading = YES;
    if (aRefreshPos == EGORefreshHeader)
    {
        self.currentPage = 1;
    }
    else if (aRefreshPos == EGORefreshFooter && !self.isLastPage)
    {
        self.currentPage++;
    }
    [self reloadTableViewDataSource];

}

#pragma mark - 数据源

- (NSMutableArray *)baseListArr
{
    if (_baseListArr == nil)
    {
        _baseListArr = [[NSMutableArray alloc]init];
    }
    return _baseListArr;
}

#pragma mark - function

- (void)doneLoadingTableViewData
{

    [self finishedLoadData];
    [self refreshFooterView];
}
- (void)queryListData
{
    dispatch_after(10.0f, dispatch_get_main_queue(), ^{
       
        [self doneLoadingTableViewData];
    });
    
    
}

- (void)showMBProgress
{
    
}

- (void)hideProgress
{
    
}


//主动调用下拉刷新

- (void)refreshData
{
    if (self.isNeedHeadRefresh)
    {
        [self queryListData];
    }

}

- (NSDate *)egoRefreshTableDataSourceLastUpdated:(UIView *)view
{
    NSDate * date = [NSDate dateWithTimeIntervalSinceNow:0];
    return date;
    
}

- (void)finishedLoadData
{
    self.isHeadLoading = NO;
    [self.slimeView endRefresh];
    [self.refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:self.baseTable];
    [self refreshFooterView];
}

- (void)reloadTableViewDataSource
{
    self.isHeadLoading = YES;
    [self queryListData];
}

#pragma mark - set方法

- (void)setIsNeedHeadRefresh:(BOOL)isNeedHeadRefresh
{
    _isNeedHeadRefresh = isNeedHeadRefresh;
    if (_isNeedHeadRefresh) {
        self.slimeView.hidden = NO;
    }
    else
    {
        self.slimeView.hidden = YES;
    }

}


#pragma mark - tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identify = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    return cell;
}


@end
