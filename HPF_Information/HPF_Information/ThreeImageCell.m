//
//  ThreeImageCell.m
//  HPF_Information
//
//  Created by 邓方 on 16/5/4.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "ThreeImageCell.h"
#import "UIImageView+WebCache.h"
@implementation ThreeImageCell


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        self.titleLabel.text = _news.title;
        self.sourceLabel.text = _news.source;
        NSString *str = [NSString stringWithFormat:@"%ld",_news.replyCount];
        NSString *followStr = [str stringByAppendingString:@"跟帖"];
        self.followLabel.text = followStr;
        //        [self.iconImage sd_setImageWithURL:[NSURL URLWithString:_news.imgsrc]];
        [self.iconImage1 sd_setImageWithURL:[NSURL URLWithString:_news.imgsrc] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        self.followLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.followLabel.layer.masksToBounds = YES;
        self.followLabel.layer.borderWidth = 1;
        self.followLabel.layer.cornerRadius = 5;
        
        
    });
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
