//
//  PM25Model.m
//  HPF_Information
//
//  Created by XP on 16/5/5.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "PM25Model.h"

@implementation PM25Model
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"error = %@",key);
}
@end
