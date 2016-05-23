//
//  TwentyFourHoursWeather.m
//  HPF_Information
//
//  Created by XP on 16/5/4.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "TwentyFourHoursWeather.h"

@implementation TwentyFourHoursWeather
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.twenty_fourScroll = [[UIScrollView alloc] init];

        [self addSubview:self.twenty_fourScroll];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];

    
    self.twenty_fourScroll.frame = CGRectMake(0, self.frame.size.height/4, self.frame.size.width, self.frame.size.height*3/4);
    
    //当前的小时数
    NSInteger currentHour = [self getDateForHour];
    for (int i = 0; i<24; i++) {
        HourForWeather *hour = [[HourForWeather alloc] initWithFrame:CGRectMake(self.twenty_fourScroll.frame.size.width/6*i, 0, self.twenty_fourScroll.frame.size.width/6, self.twenty_fourScroll.frame.size.height)];
        hour.tag = i+1;
 
        if (currentHour<24) {
            if (currentHour<10) {
                hour.twenty_fourLabel.text = [NSString stringWithFormat:@"0%ld:00",(long)currentHour];
                currentHour++;
            }else{
                hour.twenty_fourLabel.text = [NSString stringWithFormat:@"%ld:00",(long)currentHour];
                currentHour++;
            }
        }
        else{
            currentHour = 0;
            hour.twenty_fourLabel.text = [NSString stringWithFormat:@"0%ld:00",(long)currentHour];
        }
        [self.twenty_fourScroll addSubview:hour];
    }
    
    _twenty_fourScroll.showsHorizontalScrollIndicator = NO;
    _twenty_fourScroll.contentSize = CGSizeMake(self.twenty_fourScroll.frame.size.width*4, 0);
    
}
#pragma mark- 获取当前的小时数
-(NSInteger)getDateForHour
{
    //    nf = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    NSLog(@"%@",dateString);
    NSInteger currentFlag = [dateString integerValue];
    NSLog(@"%ld",(long)currentFlag);
    return currentFlag;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
