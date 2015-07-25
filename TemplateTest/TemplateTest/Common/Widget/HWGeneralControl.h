//
//  HWGeneralControl.h
//  TestOne
//
//  Created by gusheng on 14-12-8.
//  Copyright (c) 2014年 gusheng. All rights reserved.
//
//  功能描述：创建控件的通用方法
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-04-15           修改文件
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HWGeneralControl : NSObject

//创建通用的UILabel
+(UILabel *)createLabel:(CGRect)generalRect font:(CGFloat)fontSize textAligment:(NSTextAlignment)textAligment labelColor:(UIColor *)labelColor;

//创建通用的UITableView
+(UIImageView *)createImageView:(CGRect)generalRect image:(NSString *)ImageStr;

//创建通用的UITextField
+(UITextField *)createTextFieldView:(CGRect)generalRect delegate:(id)delegate textAligment:(NSTextAlignment)textAligment font:(CGFloat)fontSize textColor:(UIColor *)textColor tag:(NSInteger)tag;

//创建通用的UIButton
+(UIButton *)createButton:(CGRect)generalRect font:(CGFloat)fontSize buttonTitleColor: (UIColor *)buttonColor imageStr:(NSString *)imageStr backImage:(NSString *)backImageStr title:(NSString *)titleStr;

//创建UIView
+(UIView *)createView:(CGRect)generalRect;

//创建UITextview
+(UITextView *)createTextView:(CGRect)generalRect font:(CGFloat )fontSize textColor:(UIColor *)textColor delegate:(id)delegate textAligment:(NSTextAlignment)textAligment;

//创建UITableView
+(UITableView *)createTableView:(CGRect)generalRect dataSource:(id)dataSourceDelegate delegate:(id)delegateTemp;


@end
