//
//  LineTopView.m
//  HPF_Information
//
//  Created by XP on 16/5/10.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "LineTopView.h"

@implementation LineTopView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.startLabel];
        [self addSubview:self.finishLabel];
        [self addSubview:self.startTimeLabel];
        [self addSubview:self.finishTimeLabel];
        [self addSubview:self.picketPrice];
        [self addSubview:self.lineLabel];
        [self addSubview:self.changeButton];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.startLabel.frame = CGRectMake(10, 5, kSCREEN_WIDTH/3, kSCREEN_HEIGHT/33);
    self.finishLabel.frame = CGRectMake(10, kSCREEN_HEIGHT/33+5, kSCREEN_WIDTH/3, kSCREEN_HEIGHT/33);
    self.lineLabel.frame = CGRectMake(5, kSCREEN_HEIGHT/33*2+8, kSCREEN_WIDTH-10, 0.5);
    self.changeButton.frame = CGRectMake(kSCREEN_WIDTH*5/6-15, (kSCREEN_HEIGHT/33+5)/2, kSCREEN_WIDTH/7, kSCREEN_HEIGHT/33+5);
    
    self.startTimeLabel.frame = CGRectMake(10, kSCREEN_HEIGHT/33*2+10, kSCREEN_WIDTH/6, kSCREEN_HEIGHT/33);
    self.finishTimeLabel.frame = CGRectMake(10+kSCREEN_WIDTH/6+10, kSCREEN_HEIGHT/33*2+10, kSCREEN_WIDTH/6, kSCREEN_HEIGHT/33);
    self.picketPrice.frame = CGRectMake(kSCREEN_HEIGHT/8*2+10+10, kSCREEN_HEIGHT/33*2+10, kSCREEN_WIDTH/3, kSCREEN_HEIGHT/33);
    

    
}
-(HPFBaseLabel *)lineLabel
{
    if (!_lineLabel) {
        _lineLabel = [[HPFBaseLabel alloc] init];
        _lineLabel.backgroundColor = [UIColor grayColor];
    }
    return _lineLabel;
}
-(HPFBaseButton *)changeButton
{
    if (!_changeButton) {
        _changeButton = [HPFBaseButton buttonWithType:UIButtonTypeCustom];
        [_changeButton setTitle:@"正向" forState:UIControlStateNormal];
        _changeButton.layer.cornerRadius = 3;
        _changeButton.layer.masksToBounds = YES;
        _changeButton.backgroundColor = [UIColor greenColor];
    }
    return _changeButton;
}

-(HPFBaseLabel *)startLabel
{
    if (!_startLabel) {
        _startLabel = [[HPFBaseLabel alloc] init];
        _startLabel.text = @"珠岛花园";
        _startLabel.font = [UIFont systemFontOfSize:12];
    }
    return _startLabel;
}
-(HPFBaseLabel *)finishLabel
{
    if (!_finishLabel) {
        _finishLabel = [[HPFBaseLabel alloc] init];
        _finishLabel.text = @"海印桥";
        _finishLabel.font = [UIFont systemFontOfSize:12];
    }
    return _finishLabel;
}
-(HPFBaseLabel *)startTimeLabel
{
    if (!_startTimeLabel) {
        _startTimeLabel = [[HPFBaseLabel alloc] init];
        _startTimeLabel.text = @"02:55";
        _startTimeLabel.font = [UIFont systemFontOfSize:10];
    }
    return _startTimeLabel;
}
-(HPFBaseLabel *)finishTimeLabel
{
    if (!_finishTimeLabel) {
        _finishTimeLabel = [[HPFBaseLabel alloc] init];
        _finishTimeLabel.text = @"09:44";
        _finishTimeLabel.font = [UIFont systemFontOfSize:10];
    }
    return _finishTimeLabel;
}
-(HPFBaseLabel *)picketPrice
{
    if (!_picketPrice) {
        _picketPrice = [[HPFBaseLabel alloc] init];
        _picketPrice.text = @"票价: 票价2元";
    }
    return _picketPrice;
}



@end
