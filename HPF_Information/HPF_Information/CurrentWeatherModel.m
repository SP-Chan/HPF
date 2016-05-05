//
//  CurrentWeatherModel.m
//  HPF_Information
//
//  Created by XP on 16/5/5.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "CurrentWeatherModel.h"

@implementation CurrentWeatherModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"error = %@",key);
}
@end
