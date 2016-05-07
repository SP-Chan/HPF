//
//  XPChartAndLineView.m
//  CurveLine
//
//  Created by lanou on 16/4/22.
//  Copyright © 2016年 陈少平. All rights reserved.
//

#import "XPChartAndLineView.h"

@interface XPChartAndLineView ()
{
    //顶部的x起点坐标数组
    NSMutableArray *topPointXArray;
    
    //顶部的y点起点坐标
    NSMutableArray *topPointYArray;
    
    //图形的点 array
    NSMutableArray *pointShapeLayerArray;
    
    //连线 数组
    NSMutableArray *lineArray;

    
}

@property(nonatomic,strong)NSMutableArray *YArray;

@end



@implementation XPChartAndLineView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //给一个默认的背景色
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
#pragma mark-重写初始化方法
-(instancetype)initWithFrame:(CGRect)frame xValueArray:(NSMutableArray *)xValueArray yValueArray:(NSMutableArray *)yValueArray yStringArray:(NSMutableArray *)yStringArray maxY:(float)maxY viewHeight:(float)viewHeight lineIsCurve:(BOOL)lineIsCurve
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.xValueArray = xValueArray;
        self.yValueArray = yValueArray;
        self.lineIsCurve = lineIsCurve;
        self.yStringArray = yStringArray;
        self.maxY = maxY;
        self.viewHeight = viewHeight;
    }
    return self;

}
-(NSMutableArray *)YArray
{
    if (!_YArray) {
        _YArray = [NSMutableArray array];
        _YArray = [self changeValue:self.yValueArray];
    }
    return _YArray;
}
#pragma mark- 处理数组里面的数据,因为手机里面的象限处于第四象限,改成我们习惯的第一象限
-(NSMutableArray *)changeValue:(NSArray *)array
{
    NSMutableArray *newArray = [NSMutableArray array];
    for (int i = 0; i<array.count; i++) {
        //旧的Y值
        CGFloat oldY = [array[i] floatValue];
        // 因为取值不一样,比例也会有所不同,根据取回来的Y的最大值可以得出 Y/屏幕高度 = 输入的Y值/对应屏幕的Y值
        NSLog(@"%f",self.maxY);
        CGFloat sameRaioY = self.viewHeight*oldY/self.maxY;
        //转换成第一象限的Y值
        CGFloat newY = self.viewHeight - sameRaioY;
        //转成字符串再装进数组
        NSString *string = [NSString stringWithFormat:@"%f",newY];
        [newArray addObject:string];
    }
    return newArray;
}
#pragma mark-画线的方法
-(void)showLine
{
    //初始化线数组
    lineArray = [NSMutableArray array];
    
    UIBezierPath *line = [UIBezierPath bezierPath];
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    
    //判断数组里面是否有对象
    for (int i = 0; i < self.xValueArray.count; i++) {
        if (i>0) {
            //把数组对象转化成 CGFloat
            
            //终点X坐标
            CGFloat lastXPoint = [_xValueArray[i-1] floatValue];
            //终点Y坐标
            CGFloat lastYPoint = [self.YArray[i-1] floatValue];
            //起点X坐标
            CGFloat currentXPonit = [_xValueArray[i] floatValue];
            //起点Y坐标
            CGFloat currentYPoint = [self.YArray[i] floatValue];
            //终点坐标
            CGPoint lastPoint = CGPointMake(lastXPoint, lastYPoint);
            //起点坐标
            CGPoint currentPoint = CGPointMake(currentXPonit, currentYPoint);
            //判断使用直线,还是圆滑曲线
            if (_lineIsCurve) {
                [line moveToPoint:currentPoint];
                 //添加贝塞尔曲线 两个控制点 x为两个点的中间点 y为首末点的y坐标 为了实现平滑连接
                [line addCurveToPoint:lastPoint controlPoint1:CGPointMake((lastXPoint+currentXPonit)/2, currentYPoint) controlPoint2:CGPointMake((lastXPoint+currentXPonit)/2, lastYPoint)];
           
            }else
            {
                //直线连线
                [line moveToPoint:currentPoint];
                [line addLineToPoint:lastPoint];
      
            }
        }
        lineLayer.path = line.CGPath;
        //线条宽度(没有设定默认为2)
        lineLayer.lineWidth = self.lineWith>0?self.lineWith:2;
        if (!_lineColor) {
            self.lineColor = [UIColor whiteColor];
        }
        lineLayer.strokeColor = self.lineColor.CGColor;
        lineLayer.fillColor = [UIColor clearColor].CGColor;
        [lineArray addObject:lineLayer];
//        [UIView animateWithDuration:1.5 animations:^{
//            [self.layer addSublayer:lineLayer];
//        }];
    }
    //把线都添加都self.layer上
    for (CAShapeLayer *lineLayer in lineArray) {
    
            [self.layer addSublayer:lineLayer];
    }
    [self addPointToTheLine];
   

}
#pragma mark- 用实心圆显示各点
-(void)addPointToTheLine
{
    //用贝塞尔曲线作圆的路径
    UIBezierPath *circle = [UIBezierPath bezierPath];
    pointShapeLayerArray = [NSMutableArray array];
    for (int i = 0; i<self.xValueArray.count; i++) {
        CAShapeLayer *circleLayer = [CAShapeLayer layer];
        CGFloat pointX = [self.xValueArray[i] floatValue];
        CGFloat pointY = [self.YArray[i] floatValue];
        [circle moveToPoint:CGPointMake(pointX, pointY)];
        //圆的半径
        CGFloat radius = self.pointWidth>0?self.pointWidth:5.0;
        [circle addArcWithCenter:CGPointMake(pointX, pointY) radius:radius startAngle:0 endAngle:M_PI*2 clockwise:YES];
        circleLayer.path = circle.CGPath;
        //圆点的颜色
        if (!self.pointColor) {
            self.pointColor = [UIColor orangeColor];
        }
        circleLayer.fillColor = CGColorCreateCopyWithAlpha(self.pointColor.CGColor, 1);
        circleLayer.strokeStart = 0;
        circleLayer.strokeEnd = 1.0;
        circleLayer.lineWidth = 1;
        [pointShapeLayerArray addObject:circleLayer];
    }
    for (CAShapeLayer *layer in pointShapeLayerArray) {
        [self.layer addSublayer:layer];
    }
}
//绘画文字(因为是绘画,方法必须在 drawRect:(CGRect)rect 中实现)
-(void)drawYValue
{
    NSInteger fontSize;
    UIColor *fontColor;
    //文本文字的颜色
    if (self.colorOfNumber) {
        fontColor = self.colorOfNumber;
    }else{
        fontColor = [UIColor blackColor];
    }
    //文本文字的大小
    if (self.fontSizeOfNumber>0) {
        fontSize = self.fontSizeOfNumber;
    }else{
        fontSize = 14;
    }
    
    for (int i = 0; i<self.yStringArray.count; i++) {
        //获取文本
        NSString *yValue = self.yStringArray[i];
        //文本的宽度
        CGFloat textWidth = 28;
        //起始点X
        CGFloat originX = [self.xValueArray[i] floatValue];
        //起始点Y
        CGFloat originY = [self.YArray[i] floatValue];
        //文本高度
        CGFloat height = 20;
        
        //判断文本显示在点上面还是点的下面
        //开始点默认在上方
        if (i == 0) {
            //因为没有封装计算文本的方法,里面x和y的计算纯粹为了让文本尽量居中
            [yValue drawInRect:CGRectMake(originX-textWidth/2+5, originY-height, textWidth, height) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSForegroundColorAttributeName:[fontColor colorWithAlphaComponent:1.0]}];
        }else {
            //判断 当为凹点的时候,文本在点的下方(因为y值越大,反而点越低)
            if ([self.YArray[i-1] floatValue]<originY) {
                [yValue drawInRect:CGRectMake(originX-textWidth/2+5, originY+height/2-5, textWidth, height) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSForegroundColorAttributeName:[fontColor colorWithAlphaComponent:1.0]}];
            }
            else{
                [yValue drawInRect:CGRectMake(originX-textWidth/2+5, originY-height, textWidth, height) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSForegroundColorAttributeName:[fontColor colorWithAlphaComponent:1.0]}];
            }
        }
    }
}





// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
     [self drawYValue];
}


@end
