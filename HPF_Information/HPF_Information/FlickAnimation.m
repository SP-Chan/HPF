//
//  FlickAnimation.m
//  HPF_Information
//
//  Created by lanou on 16/5/5.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "FlickAnimation.h"
#import "NetworkRequestManager.h"
#import "TimeLuck.h"
#import "HPFBaseButton.h"
#import "HPFBaseImageView.h"
#import "HPFBaseLabel.h"
@interface FlickAnimation ()
{
NSInteger  temp;
    BOOL isOpem;
}
@property(nonatomic,strong)UIButton *addbutton;
@property(nonatomic,strong)UIView *contentView;
@property(nonatomic,strong)NSString *urlTime;
@property(nonatomic,strong)NSMutableArray *TimeArray;
@property(nonatomic,strong)NSString *hours;

@end
@implementation FlickAnimation

-(instancetype )initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];
    if (self) {
        
        _addbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_addbutton];
        
        _contentView = [[UIView alloc]init];
        [self addSubview:_contentView];
        _dataArray = [NSMutableArray array];
         _buttonSet = [NSMutableSet set];
        for (int i = 0; i<12; i++) {
            NSString *str = [NSString stringWithFormat:@"shi%d.jpg",i];
            
            UIImage *image = [UIImage imageNamed:str];
            
            [_dataArray addObject:image];
        }
        isOpem=YES;
        
        
       _urlTime=[[NSUserDefaults standardUserDefaults]objectForKey:@"time"];
        
        
        NSLog(@"flick==%@",_urlTime);
        
        
        
        NSDate *  senddate=[NSDate date];
        
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        
        [dateformatter setDateFormat:@"HH"];
        
       _hours=[dateformatter stringFromDate:senddate];
        NSLog(@"hhhh==%@",_hours);
        
      [self requestData];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(timeActiom:) name:@"time" object:nil];
        
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
   
    _addbutton.frame =CGRectMake(0, 0, self.frame.size.width/4,  self.frame.size.width/4);
    [_addbutton setImage:[UIImage imageNamed:@"9389104_145654745119_2.jpg"] forState:UIControlStateNormal];
    _addbutton.center =self.center;
    _addbutton.layer.cornerRadius=self.frame.size.width/8;
    _addbutton.layer.masksToBounds=YES;
    
    [_addbutton addTarget:self action:@selector(starButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    HPFBaseButton *baseButton = [[HPFBaseButton alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH*5/12, 64, kSCREEN_WIDTH/12, kSCREEN_WIDTH/12)];
    
    [baseButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [self addSubview:baseButton];
    
    [baseButton addTarget:self action:@selector(removeObject) forControlEvents:UIControlEventTouchUpInside];
    [self setContent];

}
-(void)removeObject
{
    
    
    if (!isOpem) {
        [self close];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            usleep(666666);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self removeFromSuperview];
            });
            
        });
    }else
    {
        CGRect rect =_addbutton.frame;
        rect.origin.y=kSCREEN_HEIGHT;
        
        [UIView animateWithDuration:0.5 animations:^{
           
            _addbutton.frame=rect;
        }];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            usleep(666666);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self removeFromSuperview];
            });
            
        });
    
    }
    
    
    
    
}
-(void)requestData
{
    
    
    NSString *url = [NSString stringWithFormat:@"http://v.juhe.cn/laohuangli/h?date=%@&key=b45f8bf8fd8c3132a47890b409ae984d",_urlTime];
    
    [NetworkRequestManager requestWithType:GET urlString:url ParDic:nil Header:nil finish:^(NSData *data) {
        
        _TimeArray = [NSMutableArray array];
        
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
        NSArray *array = [dic objectForKey:@"result"];
       
        for (NSDictionary *dic in array) {
            TimeLuck *luck = [[TimeLuck alloc]init];
            [luck setValuesForKeysWithDictionary:dic];
            [_TimeArray addObject:luck];
        }
        for (TimeLuck *luck in _TimeArray) {
            NSLog(@"%@",luck.hours);
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
           
          
            dispatch_async(dispatch_get_main_queue(), ^{
               
                  [self open];
            });
            
        });
        
    } err:^(NSError *error) {
        
    }];
    
    
    
}


-(void)todoSomething
{
    
    
    [UIView animateWithDuration:0.5 animations:^{
        _addbutton.transform = CGAffineTransformRotate(self.addbutton.transform, M_PI_2);
        
    }];

    
    
    if (isOpem==NO) {
        [self close];
       
    }else
    {
        
        [self open];
       
        
    }

}

-(void)setContent
{
    HPFBaseImageView *imagex =[[HPFBaseImageView alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH/12, kSCREEN_HEIGHT-49-64-64, kSCREEN_WIDTH/8, kSCREEN_WIDTH/8)];
    imagex.image = [UIImage imageNamed:@"1597758547gY0_b 2.jpg"];
    imagex.layer.cornerRadius=kSCREEN_WIDTH/16;
    imagex.layer.masksToBounds=YES;
    [self addSubview:imagex];
    
    HPFBaseImageView *imagej =[[HPFBaseImageView alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH/12, kSCREEN_HEIGHT-49-64, kSCREEN_WIDTH/8, kSCREEN_WIDTH/8)];
    imagej.image = [UIImage imageNamed:@"1597758547gY0_b.jpg"];
    imagej.layer.cornerRadius=kSCREEN_WIDTH/16;
    imagej.layer.masksToBounds=YES;
    [self addSubview:imagej];

    
}
- (void)starButtonClicked:(id)sender
{
    //先将未到时间执行前的任务取消。
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(todoSomething) object:sender];
    //button狂点的时候只会执行0.1秒前的点击
    [self performSelector:@selector(todoSomething) withObject:sender afterDelay:0.1];
}

-(void)open
{
    
    for (int i = 0; i<_dataArray.count; i++) {
        
        //根据数组个数创建相应个数button
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        //先定frame.在设定中心
        button.frame=CGRectMake(0, 0, 40, 40);
        
        button.center=self.center;
        //开始时候是透明的
        button.alpha=0;
        
        //圆型
        button.layer.cornerRadius=20;
        button.layer.masksToBounds=YES;
        //设置tag
        button.tag=i;
        
        //设置图片
        [button setBackgroundImage:[_dataArray objectAtIndex:i] forState:UIControlStateNormal];
        
        
        [_buttonSet addObject:button];
        
        //添加点击事件
                    [button addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        
        
        
        [UIView animateWithDuration:1 animations:^{
            
            //根据tag拿到所有button
            UIButton *openButton = (UIButton *)[button viewWithTag:i];
            
            CGPoint point = button.layer.position;
            
            //十二个点根据时钟的位置移动
            switch (button.tag) {
                case 0:
                    point.x =point.x+kSCREEN_WIDTH/3;
                    break;
                case 1:
                    point.x =point.x+sqrt(3)*kSCREEN_WIDTH/6;
                    point.y = point.y -kSCREEN_WIDTH/6;//sqrt(3)表示根号3,每个位置角度刚好30度60度去算1:2:根号3
                    break;
                case 2:
                    
                    point.x =point.x+kSCREEN_WIDTH/6;
                    point.y = point.y-sqrt(3)*kSCREEN_WIDTH/6;//sqrt(3)表示根号3,
                   
                    break;
                case 3:
                    
                    point.y = point.y -kSCREEN_WIDTH/3;
                    break;
                case 4:
                    point.x =point.x-kSCREEN_WIDTH/6;
                    point.y = point.y -sqrt(3)*kSCREEN_WIDTH/6;
                    break;
                case 5:
                    point.x =point.x-sqrt(3)*kSCREEN_WIDTH/6;
                    point.y = point.y -kSCREEN_WIDTH/6;
                    break;
                case 6:
                    point.x =point.x-kSCREEN_WIDTH/3;
                    
                    break;
                    
                case 7:
                    point.x =point.x-sqrt(3)*kSCREEN_WIDTH/6;
                    point.y = point.y +kSCREEN_WIDTH/6;
                    break;
                case 8:
                    point.x =point.x-kSCREEN_WIDTH/6;
                    point.y = point.y +sqrt(3)*kSCREEN_WIDTH/6;
                    break;
                case 9:
                    
                    point.y = point.y +kSCREEN_WIDTH/3;
                    break;
                case 10:
                    point.x =point.x+kSCREEN_WIDTH/6;
                    point.y = point.y +sqrt(3)*kSCREEN_WIDTH/6;
                    break;
                case 11:
                    point.x =point.x+sqrt(3)*kSCREEN_WIDTH/6;
                    point.y = point.y +kSCREEN_WIDTH/6;
                    break;
                    
                default:
                    break;
            }
            
            //每for一次button位置偏移一个
            openButton.layer.position=point;
            //偏移到终点透明度为没有
            openButton.alpha=1;
        }];
        
    }
    
    
    isOpem=NO;


}
-(void)close
{
  
    //设置动画返回
    [UIView animateWithDuration:1 animations:^{
        
        //从集合里面拿出所有button
        for (int i = 0; i <_dataArray.count; i++) {
            
       
            NSArray *array = [_buttonSet allObjects];
            
            UIButton *bu = [array objectAtIndex:i];

            
            //因为终点一样都是点击button中心
            CGPoint point =  self.center;
            
            bu.layer.position=point;
            //返回的时候透明都为0
            bu.alpha=0;
        }
        
      
    }];
    
    
    
    
    //加到线程里面 (目的就是动画结束的时候所用的时间1s等于 在线程里面睡眠大约1s删除button)
    [NSThread detachNewThreadSelector:@selector(delay) toTarget:self withObject:nil];
    isOpem=YES;
//    
}


-(void)delay
{
    //微秒 (必须小于动画时候)100000等于1秒
    usleep(9999);
    [_buttonSet removeAllObjects];
    
}


-(void)timeActiom:(NSNotification *)time
{
    NSDictionary *dic = time.userInfo;
    
    NSLog(@"____%@",dic);
    
    
}

-(void)touch:(UIButton *)button
{
    [_TimeArray objectAtIndex:button.tag];
    
    
//    NSLog(@"==%@",[_TimeArray objectAtIndex:button.tag]);
    
//    NSDictionary *dic =(NSDictionary *)[_TimeArray objectAtIndex:button.tag];
//    NSLog(@"==%@",[dic objectForKey:@"yi"]);
    

}



@end
