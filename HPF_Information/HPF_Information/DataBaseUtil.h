//
//  DataBaseUtil.h
//  HPF_Information
//
//  Created by XP on 16/5/11.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataBaseUtil : NSObject

+(DataBaseUtil *)shareDataBaseUtil;
-(BOOL)createTableWithTableName:(NSString *)tableName;
-(BOOL)addMessage:(NSString *)string tableName:(NSString *)tableName;
-(BOOL)deleteMessageWithTableName:(NSString *)tableName;
-(NSArray *)seleteBusesWithTableName:(NSString *)tableName;


@end
