//
//  StreamLabelView.m
//  TestProject
//
//  Created by caijingpeng.haowu on 15/3/10.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "JPStreamLabelView.h"

//#define FONTNAME                        @"Helvetica Neue"
//#define IOS7                            ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)

@implementation JPStreamLabelView

@synthesize titleArray;
@synthesize colorArray;
@synthesize fontSize;

- (id)initWithTitleArray:(NSArray *)titles borderColors:(NSArray *)colors fontSize:(float)size constrainFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleArray = titles;
        self.colorArray = colors;
        self.fontSize = size;
        
        [self createLabel];
    }
    return self;
}

- (void)createLabel
{
    UIFont *font = FONT(fontSize);
    float labelHeight = fontSize * 3 / 2.0f;
    float distance = 5;
    
    int x = 0; // 标记当前插入位置.
    int y = 0;
    
    for (int i = 0; i < titleArray.count; i++)
    {
        int originX;
        int originY;
        int width; /*按钮宽度*/
        
        NSString *title = [titleArray objectAtIndex:i];
        CGSize titleSize = [JPStreamLabelView calculateStringWidth:title font:font constrainedSize:CGSizeMake(10000, 20)];
        width = titleSize.width + (fontSize * 3 / 2.0f - fontSize) * 2;
        
        if (self.frame.size.width >= x + width + distance)
        {
            originX = x;
            originY = y;
            
            x = originX + width + distance;
        }
        else
        {
            originX = 0;
            originY = y + distance + labelHeight;
            x = originX + width + distance;  //
            y = originY;
        }
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(originX, originY, width, labelHeight)];
        label.backgroundColor = [UIColor whiteColor];
        label.layer.borderColor = ((UIColor *)[self.colorArray objectAtIndex:(i % self.colorArray.count)]).CGColor;
        label.layer.borderWidth = 1.0f;
        label.text = title;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = font;
        [self addSubview:label];
    }
    
    CGRect frame = self.frame;
    frame.size.height = y + labelHeight;
    self.frame = frame;
}

+ (CGSize)calculateStringWidth:(NSString *)string font:(UIFont *)font constrainedSize:(CGSize)cSize
{
    if (IOS7)
    {
        NSDictionary *attribute = @{NSFontAttributeName: font};
        CGRect rect = [string boundingRectWithSize:cSize options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil];
        return rect.size;
    }
    else
    {
        CGSize size = [string sizeWithFont:font constrainedToSize:cSize lineBreakMode:NSLineBreakByCharWrapping];
        return size;
    }
    return CGSizeZero;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
