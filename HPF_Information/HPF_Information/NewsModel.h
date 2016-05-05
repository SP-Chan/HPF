//
//  NewsModel.h
//  HPF_Information
//
//  Created by 邓方 on 16/5/5.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject

@property(nonatomic,strong)NSString *postid;
@property(nonatomic,assign)NSInteger replyCount;
@property(nonatomic,assign)NSInteger hasimg;
@property(nonatomic,strong)NSString *docid;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,assign)NSInteger order;
@property(nonatomic,assign)NSInteger cityType;
@property(nonatomic,assign)NSInteger priority;
@property(nonatomic,strong)NSString *imodify;
@property(nonatomic,strong)NSString *boardid;
@property(nonatomic,strong)NSString *partner;
@property(nonatomic,strong)NSString *photosetID;
@property(nonatomic,strong)NSString *logo;
@property(nonatomic,assign)NSInteger votecount;
@property(nonatomic,strong)NSString *skipID;
@property(nonatomic,strong)NSString *skipType;
@property(nonatomic,strong)NSString *url;
@property(nonatomic,assign)NSInteger hasAD;
@property(nonatomic,strong)NSString *source;
@property(nonatomic,strong)NSString *imgsrc;
@property(nonatomic,strong)NSString *subtitle;
@property(nonatomic,strong)NSString *wap_url;
@property(nonatomic,strong)NSString *wap_title;
@property(nonatomic,strong)NSString *wap_img;
@property(nonatomic,strong)NSString *wap_desc;
@property(nonatomic,strong)NSString *ptime;
@property(nonatomic,strong)NSString *digest;






@end
