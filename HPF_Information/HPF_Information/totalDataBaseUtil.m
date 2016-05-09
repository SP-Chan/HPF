//
//  totalDataBaseUtil.m
//  周公解梦
//
//  Created by lanou on 16/3/5.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "totalDataBaseUtil.h"

static totalDataBaseUtil *totalDataBase = nil;

@interface totalDataBaseUtil ()

@property(nonatomic,strong)FMDatabase *db;

@end

@implementation totalDataBaseUtil


+(totalDataBaseUtil *)shareTotalDataBase
{
    if (totalDataBase == nil) {
        totalDataBase = [[totalDataBaseUtil alloc] init];
    }
    return totalDataBase;
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

-(NSMutableArray *)selectDreamWithTitle:(NSString *)title
{
    NSMutableArray *array = [NSMutableArray array];
    if ([_db open]) {
        NSString *sql = [NSString stringWithFormat:@"select * from archives where title like '%%%@%%'",title];
        FMResultSet *set = [_db executeQuery:sql];
        while ([set next]) {
            
            
    
            Dream *d = [[Dream alloc] init];
            d.title = [set stringForColumn:@"title"];
            d.content = [set stringForColumn:@"content"];
            
            [array addObject:d];
        }
        [_db close];
    }
    return array;

}
//id
-(NSMutableArray *)selectDreamWithParentld:(NSString *)parentld
{
    
    NSInteger  inte= [parentld  integerValue];
    NSMutableArray *array = [NSMutableArray array];
    if ([_db open]) {
        NSString *sql = [NSString stringWithFormat:@"select * from archives where parentId like '%%%ld%%'",inte];
        FMResultSet *set = [_db executeQuery:sql];
        while ([set next]) {
            
            
            
            Dream *d = [[Dream alloc] init];
            d.title = [set stringForColumn:@"title"];
            d.content = [set stringForColumn:@"content"];
           
            [array addObject:d];
        }
        [_db close];
    }
    return array;
    
}

@end
