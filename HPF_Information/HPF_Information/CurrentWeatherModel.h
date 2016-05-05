//
//  CurrentWeatherModel.h
//  HPF_Information
//
//  Created by XP on 16/5/5.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrentWeatherModel : NSObject
/**
 * 温度
 **/
@property(nonatomic,strong)NSString *temperature;
/**
 * 湿度
 **/
@property(nonatomic,strong)NSString *humidity;
/**
 * 天气状况
 **/
@property(nonatomic,strong)NSString *info;
/**
 * 18是雾这种天气所对应的图片的ID，每种天气的图片需要您自己设计，或者请阅读
 https://www.juhe.cn/docs/api/id/39/aid/117
 **/
@property(nonatomic,strong)NSString *img;

@end
