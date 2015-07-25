//
//  JPQuestionListRefreshView.m
//  TemplateTest
//
//  Created by caijingpeng on 15/6/25.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "JPQuestionListRefreshView.h"

@implementation JPQuestionListRefreshView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {

    }
    return self;
}

#pragma mark -- Private Method --



#pragma mark -- Public Method --

- (void)reloadListData:(NSMutableArray *)dataList
{
    self.baseListArr = dataList;
    [self doneLoadingTableViewData];
    [self.baseTable reloadData];
}

#pragma mark -- UITableViewDeleagte DataSource --

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
    return self.baseListArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [JPQuestionCell getCellHeight:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JPQuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:[JPQuestionCell getCellIdentify]];
    if (cell == nil)
    {
        cell = [[JPQuestionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[JPQuestionCell getCellIdentify]];
    }
    
    [cell setQuestionModel:nil];
    
    [cell drawBottomLine];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (delegate && [delegate respondsToSelector:@selector(didSelectedQuestion:)])
    {
        [delegate didSelectedQuestion:nil];
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
