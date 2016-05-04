//
//  AlmanacContentTwo.m
//  HPF_Information
//
//  Created by lanou on 16/5/4.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "AlmanacContentTwo.h"

#define Width  self.bounds.size.width
#define Height  self.bounds.size.height
@implementation AlmanacContentTwo

-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        
        self.LeftOneView = [[UIView alloc]init];
        [self addSubview:self.LeftOneView];
        self.LeftTwoView = [[UIView alloc]init];
        [self addSubview:self.LeftTwoView];
        self.CentreView = [[UIView alloc]init];
        [self addSubview:self.CentreView];
        self.RightOneView = [[UIView alloc]init];
        [self addSubview:self.RightOneView];
        self.RightTwoView = [[UIView alloc]init];
        [self addSubview:self.RightTwoView];
        
    }
    return self;
    
}
-(void)layoutSubviews
{

    [super layoutSubviews];
    
    self.LeftOneView.frame = CGRectMake(0, 0, Width/9, Height);
   
    self.LeftOneView.backgroundColor = [UIColor colorWithRed:arc4random()%254/255.0 green:arc4random()%254/255.0 blue:arc4random()%254/255.0 alpha:1];
    
    
    self.LeftTwoView.frame = CGRectMake( Width/9, 0, Width*2/9, Height);
    self.LeftTwoView.layer.borderWidth=1;
    self.LeftTwoView.layer.borderColor =[UIColor redColor].CGColor;
    self.LeftTwoView.backgroundColor = [UIColor colorWithRed:arc4random()%254/255.0 green:arc4random()%254/255.0 blue:arc4random()%254/255.0 alpha:1];
    
    self.CentreView.frame = CGRectMake( Width/3, 0, Width/3, Height);
    
    self.CentreView.backgroundColor = [UIColor colorWithRed:arc4random()%254/255.0 green:arc4random()%254/255.0 blue:arc4random()%254/255.0 alpha:1];
    
    self.RightTwoView.frame = CGRectMake( Width*2/3, 0, Width*2/9, Height);
    self.RightTwoView.layer.borderWidth=1;
    self.RightTwoView.layer.borderColor =[UIColor redColor].CGColor;
    self.RightTwoView.backgroundColor = [UIColor colorWithRed:arc4random()%254/255.0 green:arc4random()%254/255.0 blue:arc4random()%254/255.0 alpha:1];
    
    self.RightOneView.frame = CGRectMake( Width*8/9, 0, Width*1/9, Height);
    
    self.RightOneView.backgroundColor = [UIColor colorWithRed:arc4random()%254/255.0 green:arc4random()%254/255.0 blue:arc4random()%254/255.0 alpha:1];



}
@end
