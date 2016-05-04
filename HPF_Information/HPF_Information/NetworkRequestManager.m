//
//  NetworkRequestManager.m
//  LifeSupport
//
//  Created by lanou on 16/4/12.
//  Copyright © 2016年 陈少平. All rights reserved.
//

#import "NetworkRequestManager.h"

@implementation NetworkRequestManager

+(void)requestWithType:(RequestType)type urlString:(NSString *)urlString ParDic:(NSDictionary *)pardic Header:(NSString *)header finish:(RequetFinish)finish err:(RequestError)err
{
    NetworkRequestManager *manager = [[NetworkRequestManager alloc] init];
    [manager requestWithType:type urlString:urlString ParDic:pardic Header:header finish:finish err:err];
}

-(void)requestWithType:(RequestType)type urlString:(NSString *)urlString ParDic:(NSDictionary *)pardic Header:(NSString *)header finish:(RequetFinish)finish err:(RequestError)err
{
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    if (header) {
        [request setValue:header forHTTPHeaderField:@"apikey"];
    }
    if (type == POST) {
        [request setHTTPMethod:@"POST"];
        if (pardic.count>0) {
            NSData *data = [self DicToData:pardic];
            [request setHTTPBody:data];
        }
    }
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            finish(data);
        }else{
            err(error);
        }
    }];
    [task resume];
    
  
}
#pragma -mark 把参数字典转化为NSData的私有方法
-(NSData *)DicToData:(NSDictionary *)dic
{
    //1.创建一个可变数组用来存放所有的键值对
    NSMutableArray *array = [NSMutableArray array];
    //2.遍历出来所有的键值对
    for (NSString *key in dic) {
        NSString *keyAndValue = [NSString stringWithFormat:@"%@=%@",key,dic[key]];
        [array addObject:keyAndValue];
    }
    //array = ["a=b","c=d","e=f"]
    //3.将数组转化为字符串
    NSString *parStr = [array componentsJoinedByString:@"&"];
    // a=b&c=d&e=f
    NSLog(@"parStr= %@",parStr);
    
    //4.将字符串转化为NSData
    NSData *data = [parStr dataUsingEncoding:NSUTF8StringEncoding];
    return data;
    
    
}


@end
