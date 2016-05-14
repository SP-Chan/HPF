//
//  RecordDataBase.m
//  HPF_Information
//
//  Created by lanou on 16/5/13.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "RecordDataBase.h"
#import "FMDatabase.h"
@interface RecordDataBase ()

@property(nonatomic,strong)FMDatabase *db;

@end

@implementation RecordDataBase
+(instancetype)shareRecordData
{
    static RecordDataBase *recordData = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        recordData = [[RecordDataBase alloc]init];
    });

    return recordData;
}
//关联
-(instancetype)init
{
    if ([super init]) {
        
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
        NSString *dbPath = [docPath stringByAppendingPathComponent:@"Video.sqlite"];
        
        NSLog(@"%@",NSHomeDirectory());
        
        
        _db = [FMDatabase databaseWithPath:dbPath];
    }
    return self;

}
//建表
-(BOOL)createTabe
{

    if ([_db open]) {
        
        NSString *sql = [NSString stringWithFormat:@"create table if not exists videos (id integer primary key autoincrement , title text,pic_name text,time text,videoId text)"];
        
        [_db executeUpdate:sql];
        [_db close];
        
        return YES;
        
    }
    
    
    return NO;

    
}
//添加
-(BOOL)insertVideo:(Video *)video
{
    if ([_db open]) {
        
        
        NSString *sql = [NSString stringWithFormat:@"insert into videos(title,pic_name,time,videoId) values ('%@','%@','%@','%@')",video.title,video.preview_img_url,video.post_time,video._id];
    
        [_db executeUpdate:sql];
        [_db close];
        return YES;
        
    }
    return NO;

}
//遍历所有
-(NSMutableArray *)selectVideo
{
    
    NSMutableArray *array = [NSMutableArray array];
    if ([_db open]) {
        
        NSString *sql = [NSString stringWithFormat:@"select * from videos"];
        
        FMResultSet *set = [_db executeQuery:sql];
        while ([set next]) {
            Video *vi = [[Video alloc]init];
            
            vi.title = [set stringForColumn:@"title"];
            vi.preview_img_url = [set stringForColumn:@"pic_name"];
            vi.post_time = [set stringForColumn:@"time"];
            vi._id = [set stringForColumn:@"videoId"];
            
            [array addObject:vi];
            
        }
        [_db close];
        return array;
        
        
    }
    return array;
    
    
}
-(BOOL)deleteVideoWithTitle:(NSString *)title
{
    if ([_db open]) {
        NSString *sql = [NSString stringWithFormat:@"delete from videos where title = '%@'",title];
        [_db executeUpdate:sql];
        [_db close];
        return YES;
    }
    return NO;

}
//删除全部
-(BOOL)deleteVideo
{
    if ([_db open]) {
        NSString *sql = [NSString stringWithFormat:@"delete from videos"];
        [_db executeUpdate:sql];
        [_db close];
        return YES;
        
    }
    return NO;
    
}
//判断
-(NSMutableArray *)selectVideoWithTitle:(NSString *)title
{
    NSMutableArray *array = [NSMutableArray array];
    if([_db open])
    {
        NSString *sql = [NSString stringWithFormat:@"select * from videos where title = '%@'",title];
        
        FMResultSet *set = [_db executeQuery:sql];
        while ([set next]) {
            
            NSString *title = [set stringForColumn:@"title"];
            Video *vi = [[Video alloc]init];
            vi.title=title;
            
            [array addObject:vi];
        }
        [_db close];
        return array;
        
    }
    return array;
}

@end
