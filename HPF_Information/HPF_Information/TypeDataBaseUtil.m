//
//  TypeDataBaseUtil.m
//  Uivew
//
//  Created by lanou on 16/5/7.
//  Copyright © 2016年 黄辉. All rights reserved.
//

#import "TypeDataBaseUtil.h"

static TypeDataBaseUtil *DataBase = nil;

@interface TypeDataBaseUtil ()

@property(nonatomic,strong)FMDatabase *db;

@end


@implementation TypeDataBaseUtil

+(TypeDataBaseUtil *)shareDataBaseUtil
{
    if (DataBase==nil) {
        DataBase = [[TypeDataBaseUtil alloc]init];
    }
    return DataBase;
}

-(id)init
{
    self = [super init];
    if (self) {
        NSString *zhougongPath = [[NSBundle mainBundle] pathForResource:@"zhougong" ofType:@"sqlite"];
        self.db = [FMDatabase databaseWithPath:zhougongPath];
    }
    return self;
}
-(NSMutableArray *)selectDreamType
{
    NSMutableArray *array = [NSMutableArray array];
    if ([_db open]) {
        NSString *sql = [NSString stringWithFormat:@"select * from arctype"];
        FMResultSet *set = [_db executeQuery:sql];
        while ([set next]) {
            DreamType *type = [[DreamType alloc]init];
            
            type.title = [set stringForColumn:@"title"];
            [array addObject:type];
        }
        [_db close];
    }
        return array;
}
@end
