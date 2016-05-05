//
//  CurrentWindModel.h
//  HPF_Information
//
//  Created by XP on 16/5/5.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrentWindModel : NSObject
/**
 * 风速
 **/
@property(nonatomic,strong)NSString *windspeed;
/**
 * 风向
 **/
@property(nonatomic,strong)NSString *direct;
/**
 * 风力等级
 **/
@property(nonatomic,strong)NSString *power;
/**
 * 一般返回null
 **/
@property(nonatomic,strong)NSString *offset;
@end
