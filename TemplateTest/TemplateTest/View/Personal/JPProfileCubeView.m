//
//  JPProfileCubeView.m
//  TemplateTest
//
//  Created by caijingpeng on 15/6/26.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "JPProfileCubeView.h"

@implementation JPProfileCubeView
@synthesize upLabel;
@synthesize downLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.upLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height / 2.0f - 20, frame.size.width, 20)];
        self.upLabel.textColor = CD_Text;
        self.upLabel.font = FONT(TF_Title);
        self.upLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.upLabel];
        
        self.downLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height / 2.0f, frame.size.width, 20)];
        self.downLabel.textColor = CD_TextLight;
        self.downLabel.font = FONT(TF_SubTitle);
        self.downLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.downLabel];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
