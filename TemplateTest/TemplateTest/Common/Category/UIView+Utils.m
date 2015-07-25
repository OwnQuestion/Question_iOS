//
//  UIView+Utils.m
//  Template-OC
//
//  Created by wuxiaohong on 15/4/3.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "UIView+Utils.h"
#import <ALView+PureLayout.h>
int  topLineTag = 1000000;
int bottomLineTag = 1000001;

@implementation UIView (Utils)
/**
 * 画顶部的线
 */
-(void)drawTopLine
{
    if ([self viewWithTag:topLineTag] != nil) {
        [[self viewWithTag:topLineTag] removeFromSuperview];
        
    }
    UIImageView * line =[UIImageView newAutoLayoutView];
    line.tag = topLineTag;
    [self addSubview:line];
    line.layer.masksToBounds = true;
    [line autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeBottom];
    [line autoSetDimension:ALDimensionHeight toSize:0.5];
    CGSize size = CGSizeMake(1, 0.5);
    line.image = [Utility imageWithColor:CDLineColor andSize:size];
    
}
//画底部的线
-(void)drawBottomLine
{
    if ([self viewWithTag:bottomLineTag] != nil) {
        [[self viewWithTag:bottomLineTag] removeFromSuperview];
        
    }
    UIImageView * line = [UIImageView newAutoLayoutView];
    line.tag = bottomLineTag;
    [self addSubview:line];
    line.layer.masksToBounds = true;
    [line autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];
    [line autoSetDimension:ALDimensionHeight toSize:0.5];
    CGSize size = CGSizeMake(1, 0.5);
    line.image = [Utility imageWithColor:CDLineColor andSize:size];
    

}
@end
