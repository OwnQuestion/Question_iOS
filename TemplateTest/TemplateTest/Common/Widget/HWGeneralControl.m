//
//  HWGeneralControl.m
//  TestOne
//
//  Created by gusheng on 14-12-8.
//  Copyright (c) 2014年 gusheng. All rights reserved.
//

#import "HWGeneralControl.h"

@implementation HWGeneralControl

//创建通用的UILabel
+(UILabel *)createLabel:(CGRect)generalRect font:(CGFloat)fontSize textAligment:(NSTextAlignment)textAligment labelColor:(UIColor *)labelColor
{
    UILabel *generalLabel = [[UILabel alloc]initWithFrame:generalRect];
    generalLabel.font = [UIFont fontWithName:FONTNAME size:fontSize];
    generalLabel.backgroundColor = [UIColor clearColor];
    generalLabel.textAlignment = textAligment;
    generalLabel.textColor = labelColor;
    return generalLabel;
}
//创建通用的UIImageview
+(UIImageView *)createImageView:(CGRect)generalRect image:(NSString *)ImageStr
{
    UIImageView *generalImage = [[UIImageView alloc]initWithFrame:generalRect];
    generalImage.backgroundColor = [UIColor clearColor];
    generalImage.image = [UIImage imageNamed:ImageStr];
    return generalImage;
}
//创建通用的UITextField
+(UITextField *)createTextFieldView:(CGRect)generalRect delegate:(id)delegate textAligment:(NSTextAlignment)textAligment font:(CGFloat)fontSize textColor:(UIColor *)textColor tag:(NSInteger)tag
{
    UITextField *generalTextField = [[UITextField alloc]initWithFrame:generalRect];
    generalTextField.font = [UIFont fontWithName:FONTNAME size:fontSize];
    generalTextField.tag = tag;
    generalTextField.backgroundColor = [UIColor clearColor];
    generalTextField.textAlignment = textAligment;
    generalTextField.textColor = textColor;
    generalTextField.delegate = delegate;
    generalTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    return generalTextField;
}
//创建通用的UIButton
+(UIButton *)createButton:(CGRect)generalRect font:(CGFloat)fontSize buttonTitleColor: (UIColor *)buttonColor imageStr:(NSString *)imageStr backImage:(NSString *)backImageStr title:(NSString *)titleStr
{
    UIButton *generalButton = [[UIButton alloc]initWithFrame:generalRect];
    [generalButton setBackgroundImage:[UIImage imageNamed:backImageStr] forState:UIControlStateNormal];
    [generalButton.titleLabel setFont:[UIFont fontWithName:FONTNAME size:fontSize]];
    [generalButton setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    [generalButton setTitleColor:buttonColor forState:UIControlStateNormal];
    [generalButton setTitle:titleStr forState:UIControlStateNormal];
    generalButton.backgroundColor = [UIColor clearColor];
    return generalButton;
    
}
//创建UIView
+(UIView *)createView:(CGRect)generalRect
{
    UIView *generalView = [[UIView alloc]initWithFrame:generalRect];
    return generalView;
}
//创建通用的UITextview
+(UITextView *)createTextView:(CGRect)generalRect font:(CGFloat )fontSize textColor:(UIColor *)textColor delegate:(id)delegate textAligment:(NSTextAlignment)textAligment
{
    UITextView *generalTextView = [[UITextView alloc]initWithFrame:generalRect];
    generalTextView.font = [UIFont fontWithName:FONTNAME size:fontSize];
    generalTextView.backgroundColor = [UIColor clearColor];
    generalTextView.textAlignment = textAligment;
    generalTextView.textColor = textColor;
    generalTextView.delegate = delegate;
    return generalTextView;
}
//创建UITableView
+(UITableView *)createTableView:(CGRect)generalRect dataSource:(id)dataSourceDelegate delegate:(id)delegateTemp
{
    UITableView *generalTableView = [[UITableView alloc]initWithFrame:generalRect style:UITableViewStyleGrouped];
    generalTableView.delegate = delegateTemp;
    generalTableView.dataSource = dataSourceDelegate;
    generalTableView.backgroundColor = [UIColor clearColor];
    generalTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return generalTableView;
}


@end