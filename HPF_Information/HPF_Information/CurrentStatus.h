//
//  CurrentStatus.h
//  HPF_Information
//
//  Created by XP on 16/5/5.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrentStatus : NSObject
/**
 * 城市编号
 **/
@property(nonatomic,strong)NSString *city_code;
/**
 * 城市
 **/
@property(nonatomic,strong)NSString *city_name;
/**
 * 日期
 **/
@property(nonatomic,strong)NSString *date;
/**
 * 更新时间
 **/
@property(nonatomic,strong)NSString *time;
/**
 * 星期几
 **/
@property(nonatomic,strong)NSString *week;
/**
 * 农历
 **/
@property(nonatomic,strong)NSString *moon;
/**
 * 更新时间编号
 **/
@property(nonatomic,strong)NSString *dataUptime;
/**
 * 风力
 **/
@property(nonatomic,strong)NSDictionary *wind;
/**
 * 天气
 **/
@property(nonatomic,strong)NSDictionary *weather;
@end
