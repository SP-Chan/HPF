//
//  TopView.m
//  HPF_Information
//
//  Created by XP on 16/5/10.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "TopView.h"


@implementation TopView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.reloadButton];
        [self addSubview:self.StartLabel];
        [self addSubview:self.FinalLabel];
        [self addSubview:self.carTitleLabel];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.StartLabel.frame = CGRectMake(15, kSCREEN_HEIGHT/33+5, kSCREEN_WIDTH/2, kSCREEN_HEIGHT/33);
    self.FinalLabel.frame = CGRectMake(15, kSCREEN_HEIGHT/33*2+5, kSCREEN_WIDTH/2, kSCREEN_HEIGHT/33);
    self.carTitleLabel.frame = CGRectMake(15, 5, kSCREEN_WIDTH/2, kSCREEN_HEIGHT/33);
    self.reloadButton.frame = CGRectMake(kSCREEN_WIDTH*6/7-10,kSCREEN_HEIGHT/33+15, kSCREEN_WIDTH/7, kSCREEN_HEIGHT/33);
  
}
-(HPFBaseButton *)reloadButton
{
    if (!_reloadButton) {
        _reloadButton = [HPFBaseButton buttonWithType:UIButtonTypeCustom];
        _reloadButton.backgroundColor = [UIColor greenColor];
        _reloadButton.layer.cornerRadius = 2;
        _reloadButton.layer.masksToBounds = YES;
        [_reloadButton setTitle:@"刷新" forState:UIControlStateNormal];
    }
    return _reloadButton;
}
-(HPFBaseLabel *)StartLabel
{
    if (!_StartLabel) {
        _StartLabel = [[HPFBaseLabel alloc] init];
        _StartLabel.font = [UIFont systemFontOfSize:12];
        _StartLabel.text = @"始发车";
        
    }
    return _StartLabel;
}
-(HPFBaseLabel *)FinalLabel
{
    if (!_FinalLabel) {
        _FinalLabel = [[HPFBaseLabel alloc] init];
        _FinalLabel.font = [UIFont systemFontOfSize:12];
        _FinalLabel.text = @"终点站";
    }
    return _FinalLabel;
}

-(HPFBaseLabel *)carTitleLabel
{
    if (!_carTitleLabel) {
        _carTitleLabel = [[HPFBaseLabel alloc] init];
        _carTitleLabel.font = [UIFont systemFontOfSize:20];
//        _carTitleLabel.backgroundColor = [UIColor yellowColor];
    }
    return _carTitleLabel;
}
@end
