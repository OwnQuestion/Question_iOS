//
//  UILabel+Utils.m
//  Template-OC
//
//  Created by wuxiaohong on 15/4/3.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "UILabel+Utils.h"

@implementation UILabel (Utils)
/**
 *  计算行间距
 *
 *  @param space 位置
 */
-(void)setLineSpacing:(CGFloat)space
{
    if (self.text == nil)
    {
        return;
    }
    NSMutableAttributedString*attributedString = [[NSMutableAttributedString alloc]initWithString:self.text];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paragraphStyle.lineSpacing = space;
    NSRange range = NSMakeRange(0, [[NSString alloc]initWithString:self.text].length);
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    self.attributedText = attributedString;
}

@end
