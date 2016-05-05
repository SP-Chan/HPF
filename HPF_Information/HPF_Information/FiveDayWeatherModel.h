//
//  FiveDayWeatherModel.h
//  HPF_Information
//
//  Created by XP on 16/5/5.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FiveDayWeatherModel : NSObject
/**
 * 时间
 **/
@property(nonatomic,strong)NSString *date;
/**
 * 当天早晚的天气状况
 **/
@property(nonatomic,strong)NSDictionary *info;
/**
 * 星期几
 **/
@property(nonatomic,strong)NSString *week;
/**
 * 农历
 **/
@property(nonatomic,strong)NSString *nongli;
@end
