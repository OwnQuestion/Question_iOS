//
//  JPRootRefreshView.m
//  TemplateTest
//
//  Created by caijingpeng on 15/6/24.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "JPRootRefreshView.h"
#import "JPRootCell.h"

#define HEADER_HEIGHT       ceilf(kScreenHeight * 2 * 0.15)
#define PHOTO_SIZE          ceilf(HEADER_HEIGHT * 0.5)

@implementation JPRootRefreshView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.isNeedHeadRefresh = NO;
        self.isLastPage = YES;
        [self initialHeaderView];
        [self initialFooterView];
        
    }
    return self;
}

- (void)initialHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HEADER_HEIGHT)];
    [headerView drawBottomLine];
    self.baseTable.tableHeaderView = headerView;
    
    UIView *assView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 100, ceilf(HEADER_HEIGHT * 0.7))];
    assView.backgroundColor = [UIColor clearColor];
    [headerView addSubview:assView];
    
    UIImageView *photoImgV = [[UIImageView alloc] initWithFrame:CGRectMake((assView.frame.size.width - PHOTO_SIZE) / 2.0f, 0, PHOTO_SIZE, PHOTO_SIZE)];
    photoImgV.image = IMAGE(@"head.jpg");
    photoImgV.layer.cornerRadius = PHOTO_SIZE / 2.0f;
    photoImgV.layer.borderColor = CD_YELLOW.CGColor;
    photoImgV.layer.masksToBounds = YES;
    photoImgV.layer.borderWidth = PHOTO_SIZE * 0.05;
    [assView addSubview:photoImgV];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(photoImgV.frame), CGRectGetWidth(assView.frame), CGRectGetHeight(assView.frame) - CGRectGetHeight(photoImgV.frame))];
    nameLabel.textColor = CD_YELLOW;
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.font = FONT(TF_BigTitle);
    nameLabel.text = @"GAIUS";
    [assView addSubview:nameLabel];
    
    assView.center = CGPointMake((kScreenWidth - 100) / 2.0f, HEADER_HEIGHT / 2.0f + 10);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTap:)];
    [headerView addGestureRecognizer:tap];
}

- (void)doTap:(id)sender
{
    if (delegate && [delegate respondsToSelector:@selector(didSelectRootIndex:)])
    {
        [delegate didSelectRootIndex:4];
    }
}

- (void)initialFooterView
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 100, kScreenHeight - HEADER_HEIGHT - 4 * [JPRootCell getCellHeight])];
    [footerView drawTopLine];
    self.baseTable.tableFooterView = footerView;
    
    CGFloat width = (kScreenWidth - 100) / 3.0f;
    for (int i = 0; i < 3; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake((width - 50) / 2.0f + i * width, (CGRectGetHeight(footerView.frame) - 50) / 2.0f, 50, 50)];
//        button.backgroundColor = CD_YELLOW;
        [footerView addSubview:button];
        
        button.titleLabel.font = FONT(TF_SubTitle);
        if (i == 0)
        {
            [button setTitle:@"Setting" forState:UIControlStateNormal];
        }
        else if (i == 1)
        {
            [button setTitle:@"Share" forState:UIControlStateNormal];
        }
        else if (i == 2)
        {
            [button setTitle:@"Logout" forState:UIControlStateNormal];
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [JPRootCell getCellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identify = @"cell1";
    JPRootCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[JPRootCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    switch (indexPath.row)
    {
        case 0:
        {
            cell.titleLabel.text = @"Question";
            break;
        }
        case 1:
        {
            cell.titleLabel.text = @"Message";
            break;
        }
        case 2:
        {
            cell.titleLabel.text = @"Follows";
            break;
        }
        case 3:
        {
            cell.titleLabel.text = @"Discovery";
            break;
        }
            
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (delegate && [delegate respondsToSelector:@selector(didSelectRootIndex:)])
    {
        [delegate didSelectRootIndex:indexPath.row];
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
