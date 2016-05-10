//
//  BusesLine.h
//  HPF_Information
//
//  Created by XP on 16/5/10.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusesLine : NSObject
@property(nonatomic,strong)NSString *terminal_name;
@property(nonatomic,strong)NSString *front_spell;
@property(nonatomic,strong)NSString *line_id;
@property(nonatomic,strong)NSString *key_name;
@property(nonatomic,strong)NSString *time_desc;
@property(nonatomic,strong)NSString *front_name;
@property(nonatomic,strong)NSArray *stationdes;
@property(nonatomic,strong)NSString *start_time;
@property(nonatomic,strong)NSString *total_price;
@property(nonatomic,strong)NSString *company;
@property(nonatomic,strong)NSString *length;
@property(nonatomic,strong)NSString *status;
@property(nonatomic,strong)NSString *basic_price;
@property(nonatomic,strong)NSString *end_time;
@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *commutation_ticket;



@end
