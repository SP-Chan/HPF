//
//  VideoTableViewCell.m
//  HPF_Information
//
//  Created by lanou on 16/5/11.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "VideoTableViewCell.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
#import "RecordDataBase.h"

#define  Uphight ((kSCREEN_WIDTH-60)*2/7+40+(kSCREEN_WIDTH-20)*2/3+10)
#define   DowmWidth ((kSCREEN_WIDTH-20)/6+30+(kSCREEN_WIDTH-20)/12)
#define   shareWidth  DowmWidth+(kSCREEN_WIDTH-20)/12+10
#define  shareLWidth shareWidth+(kSCREEN_WIDTH-20)/6+10
@implementation VideoTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addSubview:self.name_Pic];
        [self addSubview:self.like_Pic];
        [self addSubview:self.dislike_Pic];
        [self addSubview:self.share_pic];
        [self addSubview:self.user_name];
        [self addSubview:self.time];
        [self addSubview:self.forum];
        [self addSubview:self.title];
        
        [self addSubview:self.line_up];
        [self addSubview:self.line_dowm];
        [self addSubview:self.preview_img_url];
        [self addSubview:self.like_start];
        [self addSubview:self.dislike_start];
        [self addSubview:self.share_start];
        [self addSubview:self.tv_duration];
        [self addSubview:self.centerImage];
        [self addSubview:self.timeLength];
        
    }

    return self;
}
-(UILabel *)timeLength
{

    if (!_timeLength) {
        self.timeLength = [[UILabel alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH-10-(kSCREEN_WIDTH-60)*2/7 ,Uphight-10-(kSCREEN_WIDTH-60)/14,(kSCREEN_WIDTH-60)*2/7 , (kSCREEN_WIDTH-60)/14)];
        
        self.timeLength.textAlignment=NSTextAlignmentRight;
        self.timeLength.font = [UIFont systemFontOfSize:16];
        self.timeLength.textColor = [UIColor whiteColor];
    }
    return _timeLength;

}
-(UIImageView *)name_Pic
{

    if (!_name_Pic) {
        self.name_Pic = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, (kSCREEN_WIDTH-60)/7, (kSCREEN_WIDTH-60)/7)];
        self.name_Pic.backgroundColor = [UIColor orangeColor];
    
        NSURL *url = [NSURL URLWithString:@"http://image.uc.cn/s/uae/g/0q/product/q-v-a.jpg"];
        
        [self.name_Pic sd_setImageWithURL:url];
        self.name_Pic.layer.cornerRadius =(kSCREEN_WIDTH-60)/14;
        self.name_Pic.layer.masksToBounds=YES;
       
       
    }
    return _name_Pic;
}

-(UILabel *)user_name
{
    if (!_user_name) {
        self.user_name = [[UILabel alloc]initWithFrame:CGRectMake((kSCREEN_WIDTH-60)/7+30, 10+(kSCREEN_WIDTH-60)/28, (kSCREEN_WIDTH-60)*2/7, (kSCREEN_WIDTH-60)/14)];
        self.user_name.font = [UIFont systemFontOfSize:16];
      
    }

    return _user_name;
}
-(UILabel *)time
{
    if (!_time) {
        self.time =[[UILabel alloc]initWithFrame:CGRectMake(50+(kSCREEN_WIDTH-60)*3/7,10+ (kSCREEN_WIDTH-60)/14,(kSCREEN_WIDTH-60)*4/7 , (kSCREEN_WIDTH-60)/14)];
       
        self.time.font = [UIFont systemFontOfSize:16];
    
        self.time.textColor = [UIColor colorWithRed:120/255.0 green:47/255.0 blue:170/255.0 alpha:1];
         self.time.adjustsFontSizeToFitWidth = YES;
       
    }
    return _time;

}
-(UILabel *)forum
{
    if (!_forum) {
        self.forum =[[UILabel alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH-10-(kSCREEN_WIDTH-60)*2/7 ,10,(kSCREEN_WIDTH-60)*2/7 , (kSCREEN_WIDTH-60)/14)];
       self.forum.font = [UIFont systemFontOfSize:16];
        
    }
    return _forum;
    
}
-(UILabel *)title
{
    if (!_title) {
        self.title = [[UILabel alloc]initWithFrame:CGRectMake(10,( kSCREEN_WIDTH-60)/7+20, kSCREEN_WIDTH-20, (kSCREEN_WIDTH-60)/7)];
        
     self.title.font = [UIFont systemFontOfSize:16];
        self.title.textColor = [UIColor colorWithRed:arc4random()%254/255.0 green:arc4random()%254/255.0 blue:arc4random()%254/255.0 alpha:1];
        self.title.numberOfLines=2;
    }
 
    return _title;

}

-(UILabel *)line_up
{
    if (!_line_up) {
        self.line_up = [[UILabel alloc]initWithFrame:CGRectMake(10,( kSCREEN_WIDTH-60)*2/7+30, kSCREEN_WIDTH-20,1)];
        
       self.line_up.backgroundColor=  [UIColor colorWithRed:120/255.0 green:47/255.0 blue:170/255.0 alpha:1];
    }
    
    return _line_up;


}
-(UIButton *)preview_img_url
{

    if (!_preview_img_url) {
        self.preview_img_url = [UIButton buttonWithType:UIButtonTypeCustom];
     
        
        self.preview_img_url.frame=CGRectMake(10, (kSCREEN_WIDTH-60)*2/7+40, kSCREEN_WIDTH-20, (kSCREEN_WIDTH-20)*2/3);
        
        [self.preview_img_url addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
        
    }

    return _preview_img_url;

}
-(UILabel *)line_dowm
{
    if (!_line_dowm) {
        self.line_dowm = [[UILabel alloc]initWithFrame:CGRectMake(10,((kSCREEN_WIDTH-60)*2/7+40+(kSCREEN_WIDTH-20)*2/3+10), kSCREEN_WIDTH-20,1)];
        
          self.line_dowm.backgroundColor=  [UIColor colorWithRed:120/255.0 green:47/255.0 blue:170/255.0 alpha:1];
    }
    
    return _line_dowm;
    
    
}

-(UIImageView *)like_Pic
{
    if (!_like_Pic) {
        self.like_Pic = [[UIImageView alloc]initWithFrame:CGRectMake(10, Uphight+10, (kSCREEN_WIDTH-20)/12, (kSCREEN_WIDTH-20)/12)];
        self.like_Pic.image = [UIImage imageNamed:@"zan"];
        
    }
    
    return _like_Pic;
}

-(UILabel *)like_start
{
    if (!_like_start) {
        self.like_start = [[UILabel alloc]initWithFrame:CGRectMake(20+(kSCREEN_WIDTH-20)/12, Uphight+10+(kSCREEN_WIDTH-20)/48, (kSCREEN_WIDTH-20)/6, (kSCREEN_WIDTH-60)/14)];
        
     
        self.like_start.font = [UIFont systemFontOfSize:16];
        self.like_start.textColor= [UIColor redColor];
    }

    return _like_start;
}
-(UIImageView *)dislike_Pic
{
    if (!_dislike_Pic) {
        self.dislike_Pic = [[UIImageView alloc]initWithFrame:CGRectMake(((kSCREEN_WIDTH-20)/6+30+(kSCREEN_WIDTH-20)/12), Uphight+10, (kSCREEN_WIDTH-20)/12, (kSCREEN_WIDTH-20)/12)];
       self.dislike_Pic.image = [UIImage imageNamed:@"cai"];
        
    }
    return _dislike_Pic;
}


-(UILabel *)dislike_start
{
    if (!_dislike_start) {
        self.dislike_start = [[UILabel alloc]initWithFrame:CGRectMake(DowmWidth+(kSCREEN_WIDTH-20)/12+10, Uphight+10+(kSCREEN_WIDTH-20)/48, (kSCREEN_WIDTH-20)/6, (kSCREEN_WIDTH-60)/14)];
        
        self.dislike_start.font = [UIFont systemFontOfSize:16];
        self.dislike_start.textColor= [UIColor redColor];
       
    }
    
    return _dislike_start;
}
-(UIImageView *)share_pic
{

    if (!_share_pic) {
        self.share_pic = [[UIImageView alloc]initWithFrame:CGRectMake(shareWidth+(kSCREEN_WIDTH-20)/6+10, Uphight+10, (kSCREEN_WIDTH-20)/12, (kSCREEN_WIDTH-20)/12)];
        
        self.share_pic.image = [UIImage imageNamed:@"fenxiang"];
    }
    return _share_pic;


    
}
-(UILabel *)share_start
{
    if (!_share_start) {
        self.share_start = [[UILabel alloc]initWithFrame:CGRectMake(shareLWidth+(kSCREEN_WIDTH-20)/12+10, Uphight+10+(kSCREEN_WIDTH-20)/48, (kSCREEN_WIDTH-20)/6, (kSCREEN_WIDTH-60)/14)];
        self.share_start.font = [UIFont systemFontOfSize:16];
        self.share_start.textColor= [UIColor redColor];
       
       
    }
    
    return _share_start;
    
    //Uphight+10+(kSCREEN_WIDTH-20)/48 +(kSCREEN_WIDTH-60)/14) +20
}


-(UIImageView *)centerImage
{
  
    if (!_centerImage) {
        self.centerImage = [[UIImageView alloc]initWithFrame:CGRectMake((kSCREEN_WIDTH-20)/2-20, ((kSCREEN_WIDTH-60)*2/7+40)+(kSCREEN_WIDTH-20)*2/6-20, 40, 40)];
        //        self.centerImage.center=self.preview_img_url.center;
        self.centerImage.layer.cornerRadius=20;
        self.centerImage.layer.masksToBounds=YES;
        self.centerImage.backgroundColor= [UIColor whiteColor];
        self.centerImage.image = [UIImage imageNamed:@"bofang"];
    }
    return _centerImage;
}


#pragma -mark layoutSubviews
-(void)layoutSubviews
{
    [super layoutSubviews];

     self.title.text =self.video.title;
    self.user_name.text = self.video.user_name;
    self.time.text=self.video.post_time;
    self.forum.text=self.video.forum;
    NSURL *url  = [NSURL URLWithString:self.video.preview_img_url];

    [self.preview_img_url sd_setBackgroundImageWithURL:url forState:UIControlStateNormal];

   
    NSNumber *numberLick = [NSNumber numberWithInteger:self.video.like_start];
    
    self.like_start.text=[numberLick  stringValue];
   
    
    NSNumber *numberDislike = [NSNumber numberWithInteger:self.video.dislike_start];
    
    self.dislike_start.text=[numberDislike stringValue];
    
    
    NSNumber *numberShaer = [NSNumber numberWithInteger:self.video.share_start];
    
    self.share_start.text=[numberShaer stringValue];
    
    

    
    
    
    
    
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(self.video.tv_duration%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",self.video.tv_duration%60];
    //format of time
    
      NSString *format_time = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
    
    self.timeLength.text =format_time;
    
}

-(void)play:(UIButton *)button
{
    NSLog(@"%@",self.video._id);
     NSDictionary *dic=[[NSDictionary alloc]initWithObjectsAndKeys:self.video._id,@"play",self.video.title,@"title" ,nil];
    
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"播放" object:nil userInfo:dic];
    
    
    if ([[RecordDataBase shareRecordData]selectVideoWithTitle:self.video.title].count>0) {
        
    }else
    {
        [[RecordDataBase shareRecordData]insertVideo:self.video];
    
    }

    

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
