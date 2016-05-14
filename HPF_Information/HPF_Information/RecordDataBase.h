//
//  RecordDataBase.h
//  HPF_Information
//
//  Created by lanou on 16/5/13.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Video.h"
@interface RecordDataBase : NSObject
+(instancetype)shareRecordData;
-(BOOL)createTabe;
-(BOOL)insertVideo:(Video *)video;
-(NSMutableArray *)selectVideo;
-(BOOL)deleteVideoWithTitle:(NSString *)title;
-(BOOL)deleteVideo;
-(NSMutableArray *)selectVideoWithTitle:(NSString *)title;
@end
