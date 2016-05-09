//
//  TypeDataBaseUtil.h
//  Uivew
//
//  Created by lanou on 16/5/7.
//  Copyright © 2016年 黄辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "DreamType.h"
@interface TypeDataBaseUtil : NSObject
+(TypeDataBaseUtil *)shareDataBaseUtil;
-(NSMutableArray *)selectDreamType;
@end
