//
//  DataBaseUtil.m
//  HPF_Information
//
//  Created by XP on 16/5/11.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "DataBaseUtil.h"
#import "FMDatabase.h"

static DataBaseUtil *dataBase = nil;
@interface DataBaseUtil ()
@property(nonatomic,strong)FMDatabase *db;
@end

@implementation DataBaseUtil

+(DataBaseUtil *)shareDataBaseUtil
{
    if (dataBase == nil) {
        dataBase = [[DataBaseUtil alloc] init];
    }
    return dataBase;
}

-(id)init
{
    self = [super init];
    if (self) {
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
        NSString *path = [docPath stringByAppendingPathComponent:@"busesList.sqlite"];
        self.db = [FMDatabase databaseWithPath:path];
    }
    return self;
}
-(BOOL)createTableWithTableName:(NSString *)tableName
{
    if ([_db open]) {
        NSString *sql = [NSString stringWithFormat:@"create table if not exists '%@'(id integer primary key autoincrement,name text)",tableName];
        BOOL result = [_db executeUpdate:sql];
        [_db close];
        if (result) {
            NSLog(@"创建成功");
        }
    }
    return YES;
}
-(BOOL)addMessage:(NSString *)string tableName:(NSString *)tableName
{
    if ([_db open]) {
        NSString *sql = [NSString stringWithFormat:@"insert into '%@'(name)values('%@')",tableName,string];
        BOOL result = [_db executeUpdate:sql];
        [_db close];
        if (result) {
            NSLog(@"添加成功");
        }
    }
    return YES;
}

-(BOOL)deleteMessageWithTableName:(NSString *)tableName
{
    if ([_db  open]) {
        NSString *sql = [NSString stringWithFormat:@"delete from '%@'",tableName];
        BOOL result = [_db executeUpdate:sql];
        if (result) {
            NSLog(@"删除成功");
        }
    }
    return YES;
}

-(NSArray *)seleteBusesWithTableName:(NSString *)tableName
{
    NSMutableArray *array = [NSMutableArray array];
    if ([_db open]) {
        NSString *sql = [NSString stringWithFormat:@"select * from '%@'",tableName];
        FMResultSet *set = [_db executeQuery:sql];
        while ([set next]) {
            NSString *name = [set stringForColumn:@"name"];
            [array addObject:name];
        }
        [_db close];
    }
    return array;
}

@end
