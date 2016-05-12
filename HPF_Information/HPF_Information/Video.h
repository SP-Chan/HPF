//
//  Video.h
//  HPF_Information
//
//  Created by lanou on 16/5/11.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Video : NSObject
@property(nonatomic,strong)NSString *title;//标题
@property(nonatomic,assign)NSInteger like_start;//点赞数
@property(nonatomic,assign)NSInteger dislike_start;//差评数
@property(nonatomic,assign)NSInteger share_start;//分享数
@property(nonatomic,strong)NSString *forum;//类型
@property(nonatomic,strong)NSString *post_time;//跟新时间
@property(nonatomic,strong)NSString *_id;//视频id
@property(nonatomic,assign)NSInteger tv_duration;//视频的时间长度(秒)

//media_data视频详情
@property(nonatomic,strong)NSString *preview_img_url;//视频图片
@property(nonatomic,strong)NSString *user_name;//来源视频名字
@property(nonatomic,strong)NSString *avatar;//来源头像
@end
