//
//  bus.h
//  UI行讯通
//
//  Created by lanou on 16/3/26.
//  Copyright © 2016年 陈少平. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bus : NSObject
@property(nonatomic,strong)NSNumber *busId;
@property(nonatomic,strong)NSNumber *station;
@property(nonatomic,strong)NSNumber *state;
@property(nonatomic,strong)NSNumber *distance;
@property(nonatomic,strong)NSNumber *reporTime;
@end
