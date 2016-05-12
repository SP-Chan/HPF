//
//  VideoTableViewCell.h
//  HPF_Information
//
//  Created by lanou on 16/5/11.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Video.h"

@interface VideoTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *name_Pic;//类型图片
@property(nonatomic,strong)UIImageView *like_Pic;//点赞图片
@property(nonatomic,strong)UIImageView *dislike_Pic;//差评图片
@property(nonatomic,strong)UIImageView *share_pic;//分享图片
@property(nonatomic,strong)UILabel *user_name;//类型名
@property(nonatomic,strong)UILabel *time;//时间
@property(nonatomic,strong)UILabel *forum;//视频类型
@property(nonatomic,strong)UILabel *title;//视频标题
@property(nonatomic,strong)UILabel *line_up;
@property(nonatomic,strong)UILabel *line_dowm;
@property(nonatomic,strong)UIButton *preview_img_url;//点击图片
@property(nonatomic,strong)UILabel *like_start;//点赞数
@property(nonatomic,strong)UILabel *dislike_start;//差
@property(nonatomic,strong)UILabel *share_start;//分享数
@property(nonatomic,strong)UILabel *tv_duration;//视频长度
@property(nonatomic,strong)UIImageView *centerImage;
@property(nonatomic,strong)UILabel *timeLength;

@property(nonatomic,strong)Video *video;
@end
