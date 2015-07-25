//
//  JPTagView.m
//  TemplateTest
//
//  Created by caijingpeng on 15/6/25.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "JPTagView.h"

#define IconWidth    15
#define Gap          5
#define MIN_Width    40
#define MAX_Width    200

@implementation JPTagView
@synthesize tagModel;

- (id)initWithTag:(JPTagModel *)model
{
    CGSize size = [Utility calculateStringSize:model.tagName font:FONT(TF_Small) constrainedSize:CGSizeMake(1000, 20)];
    
    CGFloat width = MIN(MAX_Width, MAX(size.width, MIN_Width));
    
    self = [super initWithFrame:CGRectMake(0, 0, width + Gap + IconWidth, 20)];
    if (self)
    {
        self.tagModel = model;
        
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        imgV.image = IMAGE(@"");
        [self addSubview:imgV];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgV.frame) + Gap, 0, width, 20)];
        label.text = model.tagName;
        label.font = FONT(TF_Small);
        label.textColor = CD_Text;
        [self addSubview:label];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toTap:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)setTagModel:(JPTagModel *)model
{
    tagModel = model;
    
}

- (void)toTap:(id)sender
{
    NSLog(@"tap  tag");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
