//
//  XPChartAndLineView.h
//  CurveLine
//
//  Created by lanou on 16/4/22.
//  Copyright © 2016年 陈少平. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XPChartAndLineView : UIView
#pragma mark- 线的属性设置
/**
 * x的值的数组
 */
@property(nonatomic,strong)NSMutableArray *xValueArray;
/**
 * y的值的数组
 */
@property(nonatomic,strong)NSMutableArray *yValueArray;
/**
 * 显示到各点上的数字
 */
@property(nonatomic,strong)NSMutableArray *yStringArray;
/**
 *  连线的颜色
 */
@property(nonatomic,strong)UIColor *lineColor;
/**
 * 连接线是否使用平滑的曲线
 */
@property(nonatomic,assign)BOOL lineIsCurve;
/**
 * 连线的宽度(粗细)
 */
@property(nonatomic,assign)CGFloat lineWith;
#pragma mark- 线上的点设置
/**
 * 点的颜色 (需要CGPoint参数)
 */
@property(nonatomic,strong)UIColor *pointColor;
/**
 * 点的宽度(半径)  (需要CGPoint参数)
 */
@property(nonatomic,assign)CGFloat pointWidth;
#pragma mark- 线上的数字属性设置
/**
 * 数值的颜色
 */
@property(nonatomic,strong)UIColor *colorOfNumber;
/**
 * 数值的字号
 */
@property(nonatomic,assign)NSInteger fontSizeOfNumber;
/**
 * y的最大取值范围
 */
@property(nonatomic,assign)float maxY;
/**
 * 所在视图的高度
 */
@property(nonatomic,assign)float viewHeight;
//重写初始化方法
-(instancetype)initWithFrame:(CGRect)frame xValueArray:(NSMutableArray *)xValueArray yValueArray:(NSMutableArray *)yValueArray yStringArray:(NSMutableArray *)yStringArray maxY:(float)maxY viewHeight:(float)viewHeight lineIsCurve:(BOOL)lineIsCurve;
//画线方法
-(void)showLine;


@end
