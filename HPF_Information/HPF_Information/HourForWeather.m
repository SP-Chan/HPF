//
//  HourForWeather.m
//  HPF_Information
//
//  Created by XP on 16/5/4.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "HourForWeather.h"

@implementation HourForWeather

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.twenty_fourLabel = [[UILabel alloc] init];
        self.weatherImageV = [[UIImageView alloc] init];
        self.weatherLabel = [[UILabel alloc] init];
        
        [self addSubview:self.twenty_fourLabel];
        [self addSubview:self.weatherImageV];
        [self addSubview:self.weatherLabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.weatherLabel.frame = CGRectMake(5, 0, self.frame.size.width-10, self.frame.size.height/4);
    self.weatherImageV.frame = CGRectMake(5, self.frame.size.height/4, self.frame.size.width-10, self.frame.size.height/2);
    
    self.twenty_fourLabel.frame = CGRectMake(5, self.frame.size.height*3/4, self.frame.size.width-10, self.frame.size.height/4);
    self.twenty_fourLabel.textAlignment = NSTextAlignmentCenter;
    self.twenty_fourLabel.textColor = [UIColor blackColor];
    self.twenty_fourLabel.font = [UIFont systemFontOfSize:14];
    
    self.weatherLabel.backgroundColor = [UIColor redColor];
    self.weatherImageV.backgroundColor = [UIColor whiteColor];
    self.twenty_fourLabel.backgroundColor = [UIColor blueColor];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
