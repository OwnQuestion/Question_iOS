//
//  JPQuestionCell.m
//  TemplateTest
//
//  Created by caijingpeng on 15/6/25.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "JPQuestionCell.h"

#define MARGIN_TOP      10
#define MARGIN_LEFT     10

#define HEAD_IMAGE_SIZE  40

@implementation JPQuestionCell

@synthesize headImgV;
@synthesize nameLabel;
@synthesize dateLabel;
@synthesize questionLabel;
@synthesize commentLabel;
@synthesize praiseLabel;
@synthesize tagArray;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.headImgV = [[UIImageView alloc] initWithFrame:CGRectMake(MARGIN_LEFT, MARGIN_TOP, HEAD_IMAGE_SIZE, HEAD_IMAGE_SIZE)];
        self.headImgV.backgroundColor = [UIColor redColor];
        self.headImgV.layer.cornerRadius = 3;
        self.headImgV.layer.masksToBounds = YES;
        [self.contentView addSubview:self.headImgV];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headImgV.frame) + 10,
                                                                   MARGIN_TOP,
                                                                   kScreenWidth - (CGRectGetMaxX(self.headImgV.frame) + 10) - MARGIN_LEFT - 80 - 5,
                                                                   18)];
        self.nameLabel.backgroundColor = [UIColor clearColor];
        self.nameLabel.font = FONT(TF_Title);
        self.nameLabel.textColor = CD_Text;
        [self.contentView addSubview:self.nameLabel];
        
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - MARGIN_LEFT - 80,
                                                                  MARGIN_TOP,
                                                                  80,
                                                                  18)];
        self.dateLabel.backgroundColor = [UIColor clearColor];
        self.dateLabel.font = FONT(TF_Small);
        self.dateLabel.textColor = CD_TextLight;
        self.dateLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.dateLabel];
        
        self.questionLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.nameLabel.frame),
                                                                      CGRectGetMaxY(self.nameLabel.frame) + 5,
                                                                      CGRectGetWidth(self.nameLabel.frame),
                                                                      0)];
        self.questionLabel.backgroundColor = [UIColor clearColor];
        self.questionLabel.numberOfLines = 0;
        self.questionLabel.font = FONT(TF_SubTitle);
        self.questionLabel.textColor = CD_TextMidLight;
        self.questionLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self.contentView addSubview:self.questionLabel];
        
        self.commentLabel = [[JPIconLabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.nameLabel.frame), 0, 100, 20) headIcon:IMAGE(@"comment_cell.png") labelText:@"" font:FONT(TF_Small) gap:5];
        self.commentLabel.backgroundColor = [UIColor clearColor];
        self.commentLabel.textLabel.textColor = CD_TextLight;
        [self.contentView addSubview:self.commentLabel];
        
        self.praiseLabel = [[JPIconLabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.nameLabel.frame) + 120, 0, 100, 20) headIcon:IMAGE(@"praise_cell.png") labelText:@"" font:FONT(TF_Small) gap:5];
        self.praiseLabel.backgroundColor = [UIColor clearColor];
        self.praiseLabel.textLabel.textColor = CD_TextLight;
        [self.contentView addSubview:self.praiseLabel];
        
        self.tagArray = [NSMutableArray array];
        for (int i = 0; i < 5; i++)
        {
            JPIconLabel *tagLabel = [[JPIconLabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.nameLabel.frame) + 120, 0, 100, 20) headIcon:IMAGE(@"praise_cell.png") labelText:@"" font:FONT(TF_Small) gap:5];
            tagLabel.tag = 1001 + i;
            tagLabel.textLabel.textColor = CD_TextLight;
            [self.contentView addSubview:tagLabel];
            [self.tagArray addObject:tagLabel];
        }
        
    }
    return self;
}

+ (NSString *)getCellIdentify
{
    return @"questioncell";
}

+ (CGFloat)getCellHeight:(JPQuestionModel *)model
{
//    NSLog(@"%@", [UIFont familyNames]);
    
    NSString *question = @"Chinadaily.com.cn is the largest English portal in China, providing news, business information, BBS, learning materials. The Website has channels as China萨芬的爱疯萨芬的爱疯萨芬的爱疯萨芬的爱疯萨芬的爱疯萨芬的爱疯萨芬的爱疯萨芬的爱疯萨芬的爱疯萨芬的爱疯萨芬的爱疯萨芬的爱疯萨芬的爱疯萨芬的爱疯萨芬的爱疯萨芬的爱疯";
    
    CGSize size = [Utility calculateStringSize:question font:FONT(TF_SubTitle) constrainedSize:CGSizeMake(kScreenWidth - (10 + HEAD_IMAGE_SIZE + 10) - MARGIN_LEFT, 10000)];
    
    //****
    
    CGFloat originX = 0;
    CGFloat height = 0;
    
    // tags 的 总数
    for (int i = 0; i < 5; i++)
    {
        NSString *string;
        if (i == 0)
        {
            string = @"swift";
        }
        else
        {
            string = @"objective-c";
        }
        
        CGSize size = [Utility calculateStringSize:string font:FONT(TF_Small) constrainedSize:CGSizeMake(100000, 20)];
        CGFloat width = size.width + 17.5;
        
        originX += width + 15;
        
        if (originX + HEAD_IMAGE_SIZE + 2 * MARGIN_LEFT > kScreenWidth - 15)
        {
            // 越界
            height += 20;
            originX = 0;
            originX += width + 15;
        }
    }
    height += 20;
    //****
    
    return MIN(size.height, 100) + MARGIN_TOP * 2 + 18 + 5 + 20 + height + 5;
}

- (void)setQuestionModel:(JPQuestionModel *)model
{
    NSString *name = @"David James";
    NSString *question = @"Chinadaily.com.cn is the largest English portal in China, providing news, business information, BBS, learning materials. The Website has channels as China萨芬的爱疯萨芬的爱疯萨芬的爱疯萨芬的爱疯萨芬的爱疯萨芬的爱疯萨芬的爱疯萨芬的爱疯萨芬的爱疯萨芬的爱疯萨芬的爱疯萨芬的爱疯萨芬的爱疯萨芬的爱疯萨芬的爱疯萨芬的爱疯";
    
    self.nameLabel.text = name;
    self.dateLabel.text = @"3 days ago";
    
    CGSize size = [Utility calculateStringSize:question font:FONT(TF_SubTitle) constrainedSize:CGSizeMake(kScreenWidth - (CGRectGetMaxX(self.headImgV.frame) + 10), 10000)];
    self.questionLabel.text = question;
    [self.questionLabel setLineSpacing:3];
    self.questionLabel.frame = CGRectMake(CGRectGetMinX(self.nameLabel.frame),
                                          CGRectGetMaxY(self.nameLabel.frame) + 5,
                                          kScreenWidth - (CGRectGetMaxX(self.headImgV.frame) + 10) - MARGIN_LEFT,
                                          MIN(size.height, 100));
    
    // -------------
    
    CGFloat originX = 0;
    CGFloat height = CGRectGetMaxY(self.questionLabel.frame) + 5;
    
    for (int i = 0; i < self.tagArray.count; i++)
    {
        JPIconLabel *tagLabel = [self.tagArray pObjectAtIndex:i];
        if (i == 0)
        {
            [tagLabel setText:@"swift"];
        }
        else
        {
            [tagLabel setText:@"objective-c"];
        }
        
        tagLabel.frame = CGRectMake(CGRectGetMinX(self.nameLabel.frame) + originX, height, tagLabel.frame.size.width, tagLabel.frame.size.height);
        
        originX += tagLabel.frame.size.width + 15;
        if (originX + HEAD_IMAGE_SIZE + 2 * MARGIN_LEFT > kScreenWidth - 15)
        {
            // 越界
            height += tagLabel.frame.size.height;
            originX = 0;
            tagLabel.frame = CGRectMake(CGRectGetMinX(self.nameLabel.frame) + originX, height, tagLabel.frame.size.width, tagLabel.frame.size.height);
            originX += tagLabel.frame.size.width + 15;
        }
    }
    
    height += 20;
    
    CGRect frame = self.commentLabel.frame;
    frame.origin.y = height + 5;
    self.commentLabel.frame = frame;
    
    CGRect frame1 = self.praiseLabel.frame;
    frame1.origin.y = height + 5;
    self.praiseLabel.frame = frame1;
    
    [self.commentLabel setText:@"100 Comments"];
    [self.praiseLabel setText:@"299 Likes"];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
