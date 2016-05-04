//
//  AlmanacContentOne.m
//  HPF_Information
//
//  Created by lanou on 16/5/4.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "AlmanacContentOne.h"

#define Width  self.bounds.size.width
#define Height  self.bounds.size.height
@implementation AlmanacContentOne


-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        
        self.LeftView = [[UIView alloc]init];
        [self addSubview:self.LeftView];
        self.RightView = [[UIView alloc]init];
        [self addSubview:self.RightView];
        self.CentreView = [[UIView alloc]init];
        [self addSubview:self.CentreView];
        self.CentreLeft = [[UIView alloc]init];
        [self addSubview:self.CentreLeft];
        self.CentreRight = [[UIView alloc]init];
        [self addSubview:self.CentreRight];
        
    }
    return self;
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.LeftView.frame = CGRectMake(0, 0, Width/4, Height);
    self.LeftView.layer.borderWidth=1;
    self.LeftView.layer.borderColor =[UIColor redColor].CGColor;
    self.LeftView.backgroundColor = [UIColor colorWithRed:arc4random()%254/255.0 green:arc4random()%254/255.0 blue:arc4random()%254/255.0 alpha:1];
    
    
    
        self.CentreView.frame = CGRectMake(Width/4, 0, Width/2, Height*3/5);
        self.CentreView.layer.borderWidth=1;
        self.CentreView.layer.borderColor =[UIColor redColor].CGColor;
        self.CentreView.backgroundColor = [UIColor colorWithRed:arc4random()%254/255.0 green:arc4random()%254/255.0 blue:arc4random()%254/255.0 alpha:1];
    
    
        self.CentreLeft.frame = CGRectMake(Width/4, Height*3/5, Width/4, Height*2/5);
        self.CentreLeft.layer.borderWidth=1;
        self.CentreLeft.layer.borderColor =[UIColor redColor].CGColor;
        self.CentreLeft.backgroundColor = [UIColor colorWithRed:arc4random()%254/255.0 green:arc4random()%254/255.0 blue:arc4random()%254/255.0 alpha:1];
    
        self.CentreRight.frame = CGRectMake(Width/2, Height*3/5, Width/4, Height*2/5);
        self.CentreRight.layer.borderWidth=1;
        self.CentreRight.layer.borderColor =[UIColor redColor].CGColor;
        self.CentreRight.backgroundColor = [UIColor colorWithRed:arc4random()%254/255.0 green:arc4random()%254/255.0 blue:arc4random()%254/255.0 alpha:1];
    
    self.RightView.frame = CGRectMake(Width*3/4, 0, Width/4, Height);
    self.RightView.layer.borderWidth=1;
    self.RightView.layer.borderColor =[UIColor redColor].CGColor;
    self.RightView.backgroundColor = [UIColor colorWithRed:arc4random()%254/255.0 green:arc4random()%254/255.0 blue:arc4random()%254/255.0 alpha:1];
    
}

@end
