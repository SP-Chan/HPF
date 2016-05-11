//
//  BusStation.h
//  HPF_Information
//
//  Created by XP on 16/5/10.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusStation : NSObject
@property(nonatomic,strong)NSString *line_id;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *key_name;
@property(nonatomic,strong)NSString *front_name;
@property(nonatomic,strong)NSString *terminal_name;
@property(nonatomic,strong)NSString *start_time;
@property(nonatomic,strong)NSString *end_time;
@property(nonatomic,strong)NSString *basic_price;
@property(nonatomic,strong)NSString *total_price;
@property(nonatomic,strong)NSString *company;
@property(nonatomic,strong)NSString *length;
@end
