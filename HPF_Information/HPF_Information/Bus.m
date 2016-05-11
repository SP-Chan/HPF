//
//  bus.m
//  UI行讯通
//
//  Created by lanou on 16/3/26.
//  Copyright © 2016年 陈少平. All rights reserved.
//

#import "Bus.h"

@implementation Bus
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"error = %@",key);
}

@end
