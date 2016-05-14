//
//  SolveLogo.m
//  Uivew
//
//  Created by lanou on 16/5/7.
//  Copyright © 2016年 黄辉. All rights reserved.
//

#import "SolveLogo.h"
#import "TypeDataBaseUtil.h"
#import "DreamType.h"
#import "MarkViewController.h"
#import "totalDataBaseUtil.h"
@implementation SolveLogo

-(instancetype)initWithFrame:(CGRect)frame
{

    if ([super initWithFrame:frame]) {
        
        self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        [self addSubview:self.imageV];
        _dataArray = [NSMutableArray array];
        self.dbSphere = [[DBSphereView alloc]init];
        self.dbSphere.frame=CGRectMake(5, self.bounds.size.height/6, self.bounds.size.width, self.bounds.size.height*3/4-10);
        _buttonArray=[NSMutableArray array];
        
        [self addSubview:self.dbSphere];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
       
        button.frame=CGRectMake(0, 0, self.bounds.size.width/3,self.bounds.size.width/8);
        [button setImage:[UIImage imageNamed:@"Unknown-3"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        [button setTitle:@"实时搜索" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        for (DreamType *dream in [[TypeDataBaseUtil shareDataBaseUtil]selectDreamType]) {
            [_dataArray addObject:dream.title];
        }
    
        
        [self setType];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageV.image = [UIImage imageNamed:@"meng"];
   
   
    
}

-(void)search
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"搜索" object:nil];

}
-(void)setType
{
    _flag =1;
    for (int i = 0; i<12; i++) {
        
        for (int j = 0; j<3; j++) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            
            button.frame=CGRectMake(0, 0, self.bounds.size.width/2, 64);
            button.backgroundColor =[UIColor clearColor];
            
            button.tag=_flag;
            
            [button setTitle:[_dataArray objectAtIndex:_flag-1] forState:UIControlStateNormal];
            
            [self.dbSphere addSubview:button];
            
            button.titleLabel.font = [UIFont boldSystemFontOfSize:arc4random()%6+20];
            
            button.titleLabel.textAlignment=NSTextAlignmentCenter;
            
            [button setTitleColor:[UIColor colorWithRed:arc4random()%254/255.0 green:arc4random()%254/255.0  blue:arc4random()%254/255.0  alpha:1] forState:UIControlStateNormal];
            

            [button addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
            _flag++;
            
            [_buttonArray addObject:button];
            if (_flag==_dataArray.count) {
                break;
            }
            
        }
        
    }
    [self.dbSphere setCloudTags:_buttonArray];

}
-(void)choose:(UIButton *)choose
{
    [self.dbSphere timerStop];
    NSLog(@"点击");
    [UIView animateWithDuration:0.3 animations:^{
        choose.transform = CGAffineTransformMakeScale(2, 2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            choose.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished) {
            [self.dbSphere timerStart];
            
            NSDictionary *dic = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:choose.tag] forKey:@"tag"];
            
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"标签" object:nil userInfo:dic];
            
            
            
        }];
    }];


    
    
   

}
@end
