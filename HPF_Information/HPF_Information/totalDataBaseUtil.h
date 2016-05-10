//
//  totalDataBaseUtil.h
//  周公解梦
//
//  Created by lanou on 16/3/5.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "Dream.h"

@interface totalDataBaseUtil : NSObject

+(totalDataBaseUtil *)shareTotalDataBase;

//模糊查询数据
-(NSMutableArray *)selectDreamWithTitle:(NSString *)title;

-(NSMutableArray *)selectDreamWithParentld:(NSString *)parentld;
@end
