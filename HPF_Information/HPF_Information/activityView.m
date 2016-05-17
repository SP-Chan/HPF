//
//  activityView.m
//  HPF_Information
//
//  Created by lanou on 16/5/12.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "activityView.h"

static activityView *activity = nil;

@implementation activityView

+(instancetype)shareActivityView
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (activity == nil) {
            activity = [[activityView alloc]init];
        }
    });
    return activity;
}

-(instancetype)init
{
    if ([super init]) {
        _activity = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0,kSCREEN_WIDTH/10, kSCREEN_WIDTH/10)];
       
        _activity.layer.position =CGPointMake(kSCREEN_WIDTH*7/48,kSCREEN_WIDTH*7/48);
        [_activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
        
        self.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
        self.frame =CGRectMake(0, 0, kSCREEN_WIDTH*7/24, kSCREEN_WIDTH*7/24);
        self.layer.position =CGPointMake(kSCREEN_WIDTH/2, kSCREEN_HEIGHT/2-64);
        self.layer.cornerRadius =15;
        self.layer.masksToBounds=YES;
        
        
        self.lable =[[UILabel alloc]initWithFrame:CGRectMake(0, kSCREEN_WIDTH*7/48-kSCREEN_WIDTH/20+kSCREEN_WIDTH/10, kSCREEN_WIDTH*7/24, kSCREEN_WIDTH*7/48-kSCREEN_WIDTH/20)];
        self.lable.textAlignment=NSTextAlignmentCenter;
        self.lable.text=@"拼命的加载中...";
        self.lable.textColor = [UIColor blackColor];
        self.lable.font=[UIFont systemFontOfSize:15];
        [self addSubview:_activity];
        [self addSubview:_lable];
        [_activity startAnimating];
    }
    return self;

}
-(void)removeActivityView
{
    [_activity stopAnimating];
    [self removeFromSuperview];
}
//-(UIActivityIndicatorView *)activity
//{
//    if (!_activity) {
//        
//        _activity = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH/10, kSCREEN_WIDTH/10)];
//        _activity.layer.position =CGPointMake(self.bounds.origin.x/2, self.bounds.origin.y/2);
//        [_activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
//        _activity.backgroundColor = [UIColor redColor];
//        
//    }
//    return _activity;
//}
//-(UILabel *)lable
//{
//
//    if (!_lable) {
//        self.lable = [[UILabel alloc]initWithFrame:CGRectMake(0, self.bounds.origin.x/2+kSCREEN_WIDTH/10, self.bounds.size.width, self.bounds.size.height-self.bounds.origin.x/2+kSCREEN_WIDTH/10)];
//        self.lable.textAlignment=NSTextAlignmentCenter;
//        self.lable.text=@"玩命的加载中...";
//        self.lable.textColor = [UIColor blackColor];
//    }
//    return _lable;
//}


-(void)setActivityColor:(UIColor *)color
{

    [_activity setColor:color];
}

@end
