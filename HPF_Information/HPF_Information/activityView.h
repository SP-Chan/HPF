//
//  activityView.h
//  HPF_Information
//
//  Created by lanou on 16/5/12.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * 屏幕的宽度
 */
#define kSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

/**
 * 屏幕高度
 */
#define kSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface activityView : UIView
@property(nonatomic,strong)UIActivityIndicatorView *activity;
@property(nonatomic,strong)UILabel *lable;

//设置颜色
-(void)setActivityColor:(UIColor *)color;

@end
