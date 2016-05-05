//
//  LifeModel.h
//  HPF_Information
//
//  Created by XP on 16/5/5.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LifeModel : NSObject
/**
 * 空调指数
 **/
@property(nonatomic,strong)NSArray *kongtiao;
/**
 * 运动指数
 **/
@property(nonatomic,strong)NSArray *yundong;
/**
 * 紫外线指数
 **/
@property(nonatomic,strong)NSArray *ziwaixian;
/**
 * 感冒指数
 **/
@property(nonatomic,strong)NSArray *ganmao;
/**
 * 洗车指数
 **/
@property(nonatomic,strong)NSArray *xiche;
/**
 * 污染指数
 **/
@property(nonatomic,strong)NSArray *wuran;
/**
 * 穿衣指数
 **/
@property(nonatomic,strong)NSArray *chuanyi;
@end
