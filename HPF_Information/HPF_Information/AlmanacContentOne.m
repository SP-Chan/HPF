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
        
        self.luckyTime = [[UILabel alloc]init];
        [self.LeftView addSubview:self.luckyTime];
        
        self.fierceTime = [[UILabel alloc]init];
        [self.RightView addSubview:self.fierceTime];
        
        self.CentreLable = [[UILabel alloc]init];
        [self.CentreView addSubview:self.CentreLable];
        
        self.CentreBelow = [[UIView alloc]init];
        [self addSubview:self.CentreBelow];
        
        
        self.CentreLeftLabel = [[UILabel alloc]init];
        self.CentreRightLabel = [[UILabel alloc]init];
        [self.CentreLeft addSubview:self.CentreLeftLabel];
        
        [self.CentreRight addSubview:self.CentreRightLabel];
        
        
        
    }
    return self;
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.LeftView.frame = CGRectMake(0, 0, Width/4, Height);
    self.LeftView.layer.borderWidth=1;
    self.LeftView.layer.borderColor =[UIColor redColor].CGColor;
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.LeftView.bounds.size.width,self.LeftView.bounds.size.height/5)];
    
    label.text=@"吉辰";
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textColor = [UIColor redColor];
    label.textAlignment=NSTextAlignmentCenter;
    [self.LeftView addSubview:label];
    
    
    //103.42.19
    self.luckyTime.frame = CGRectMake(0, self.LeftView.bounds.size.height/5, self.LeftView.bounds.size.width, self.LeftView.bounds.size.height*4/5);
    
    self.luckyTime.textColor = [UIColor colorWithRed:103/255.0 green:42/255.0 blue:19/255.0 alpha:1];
    self.luckyTime.numberOfLines=5;
    self.luckyTime.textAlignment=NSTextAlignmentCenter;
    self.luckyTime.font = [UIFont systemFontOfSize:18];
    
        self.CentreView.frame = CGRectMake(Width/4, 0, Width/2, Height*2/5);
        self.CentreView.layer.borderWidth=1;
        self.CentreView.layer.borderColor =[UIColor redColor].CGColor;
    
     UILabel *labeC = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.CentreView.bounds.size.width,self.CentreView.bounds.size.height/2)];
    
    labeC.text=@"五行";
   labeC.font = [UIFont boldSystemFontOfSize:20];
    labeC.textColor = [UIColor redColor];
    labeC.textAlignment=NSTextAlignmentCenter;
    [self.CentreView addSubview:labeC];
    
    
    self.CentreLable.frame = CGRectMake(0, self.CentreView.bounds.size.height/2,  self.CentreView.bounds.size.width, self.CentreView.bounds.size.height/2);
    
    self.CentreLable.textColor = [UIColor colorWithRed:103/255.0 green:42/255.0 blue:19/255.0 alpha:1];
    self.CentreLable.textAlignment=NSTextAlignmentCenter;
    self.CentreLable.font = [UIFont systemFontOfSize:18];
    
    
    
    
    
    
        self.CentreLeft.frame = CGRectMake(Width/4, Height*2/5, Width/5, Height*3/5);
        self.CentreLeft.layer.borderWidth=1;
        self.CentreLeft.layer.borderColor =[UIColor redColor].CGColor;
   
     self.CentreLeftLabel.numberOfLines=8;
    self.CentreLeftLabel.frame=self.CentreLeft.bounds;
    
    self.CentreLeftLabel.textColor = [UIColor colorWithRed:103/255.0 green:42/255.0 blue:19/255.0 alpha:1];
    
    self.CentreLeftLabel.font = [UIFont systemFontOfSize:18];
   
    
    self.CentreBelow.frame = CGRectMake(Width/4+Width/5, Height*2/5, Width/10, Height*3/5);
    self.CentreBelow.layer.borderWidth=1;
    self.CentreBelow.layer.borderColor =[UIColor redColor].CGColor;
    
    UILabel *below = [[UILabel alloc]initWithFrame:self.CentreBelow.bounds];
    below.numberOfLines=2;
    below .text=@"百忌";
    below .font = [UIFont boldSystemFontOfSize:20];
    below .textColor = [UIColor redColor];
    below.textAlignment=NSTextAlignmentCenter;
    [self.CentreBelow addSubview:below];
    
    
    
        self.CentreRight.frame = CGRectMake(Width/2+Width/20, Height*2/5, Width/5, Height*3/5);
        self.CentreRight.layer.borderWidth=1;
        self.CentreRight.layer.borderColor =[UIColor redColor].CGColor;
    
    self.CentreRightLabel.frame=self.CentreRight.bounds;
    self.CentreRightLabel.textColor = [UIColor colorWithRed:103/255.0 green:42/255.0 blue:19/255.0 alpha:1];
    
    self.CentreRightLabel.font = [UIFont systemFontOfSize:18];
       self.CentreRightLabel.numberOfLines=8;

    
    
    
    
    
    self.RightView.frame = CGRectMake(Width*3/4, 0, Width/4, Height);
    self.RightView.layer.borderWidth=1;
    self.RightView.layer.borderColor =[UIColor redColor].CGColor;
   
    UILabel *labelR = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.RightView.bounds.size.width,self.RightView.bounds.size.height/5)];
    
    labelR .text=@"凶辰";
    labelR .font = [UIFont boldSystemFontOfSize:20];
    labelR .textColor = [UIColor redColor];
    labelR .textAlignment=NSTextAlignmentCenter;
    [self.RightView addSubview:labelR];
    
    
    //103.42.19
    self.fierceTime.frame = CGRectMake(0, self.LeftView.bounds.size.height/5, self.RightView.bounds.size.width, self.RightView.bounds.size.height*4/5);
    
    self.fierceTime.textColor = [UIColor colorWithRed:103/255.0 green:42/255.0 blue:19/255.0 alpha:1];
    self.fierceTime.numberOfLines=5;
    self.fierceTime.textAlignment=NSTextAlignmentCenter;
    self.fierceTime.font = [UIFont systemFontOfSize:18];
    
    
    
    
}

@end
