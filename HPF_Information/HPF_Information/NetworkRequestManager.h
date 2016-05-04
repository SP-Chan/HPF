//
//  NetworkRequestManager.h
//  LifeSupport
//
//  Created by lanou on 16/4/12.
//  Copyright © 2016年 陈少平. All rights reserved.
//

#import <Foundation/Foundation.h>
//定义一个枚举表示请求类型
typedef NS_ENUM(NSInteger,RequestType) {
    GET,
    POST
};

//定义一个请求结束时的block作为调用
typedef void (^RequetFinish)(NSData *data);
//定义一个请求失败时的block作为回调
typedef void (^RequestError)(NSError *error);

@interface NetworkRequestManager : NSObject

+(void)requestWithType:(RequestType)type urlString:(NSString *)urlString ParDic:(NSDictionary *)pardic Header:(NSString *)header finish:(RequetFinish)finish err:(RequestError)err;

@end
