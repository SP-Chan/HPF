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
        
        self.CentreView = [[UIView alloc]init];
        [self addSubview:self.CentreView];
        self.RightOneView = [[UIView alloc]init];
        [self addSubview:self.RightOneView];
       
        self.LeftLable = [[UILabel alloc]init];
        [self.LeftOneView addSubview:self.LeftLable];
        self.RightLable = [[UILabel alloc]init];
        [self.RightOneView addSubview:self.RightLable];
        
        self.CentreButton= [UIButton buttonWithType:UIButtonTypeCustom];
        [self.CentreView addSubview:self.CentreButton];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(animation:) name:@"animation" object:nil];
        
        
    }
    return self;
    
}
-(void)layoutSubviews
{

    [super layoutSubviews];
    
    self.LeftOneView.frame = CGRectMake(0, 0, Width/3, Height);
    self.LeftOneView.layer.borderWidth=1;
    self.LeftOneView.layer.borderColor =[UIColor redColor].CGColor;
        
    
    UILabel *labelL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.LeftOneView.bounds.size.width,self.LeftOneView.bounds.size.height/5)];
    
    labelL .text=@"宜";
    labelL.font = [UIFont boldSystemFontOfSize:20];
    labelL .textColor = [UIColor redColor];
    labelL .textAlignment=NSTextAlignmentCenter;
    [self.LeftOneView addSubview:labelL];
    
    
    //103.42.19
    self.LeftLable.frame = CGRectMake(0, self.LeftOneView.bounds.size.height/5, self.LeftOneView.bounds.size.width, self.LeftOneView.bounds.size.height*4/5);
    
     self.LeftLable.textColor = [UIColor colorWithRed:103/255.0 green:42/255.0 blue:19/255.0 alpha:1];
     self.LeftLable.numberOfLines=5;
     self.LeftLable.textAlignment=NSTextAlignmentCenter;
     self.LeftLable.font = [UIFont systemFontOfSize:18];
    
    
    
    
    
    
    
    
   
    
    self.CentreView.frame = CGRectMake( Width/3, 0, Width/3, Height);
    
    self.CentreView.layer.borderWidth=1;
    self.CentreView.layer.borderColor =[UIColor redColor].CGColor;
    
  
    self.CentreButton.frame=CGRectMake(0, 0, Width/3-4, Width/3-4);
   
    self.CentreButton.layer.cornerRadius=(Width/3-4)/2;
    self.CentreButton.layer.masksToBounds=YES;
    [self.CentreButton setImage:[UIImage imageNamed:@"wuxinbagua.jpg"] forState:UIControlStateNormal];
    
  
   
    
    self.RightOneView.frame = CGRectMake( Width*2/3, 0, Width*1/3, Height);
    self.RightOneView.layer.borderWidth=1;
    self.RightOneView.layer.borderColor =[UIColor redColor].CGColor;
   
    
    UILabel *labelR = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.RightOneView.bounds.size.width,self.RightOneView.bounds.size.height/5)];
    
    labelR .text=@"忌";
    labelR.font = [UIFont boldSystemFontOfSize:20];
    labelR .textColor = [UIColor redColor];
    labelR .textAlignment=NSTextAlignmentCenter;
    [self.RightOneView addSubview:labelR];
    
    
    //103.42.19
    self.RightLable.frame = CGRectMake(0, self.RightOneView.bounds.size.height/5, self.RightOneView.bounds.size.width, self.RightOneView.bounds.size.height*4/5);
    
    self.RightLable.textColor = [UIColor colorWithRed:103/255.0 green:42/255.0 blue:19/255.0 alpha:1];
    self.RightLable.numberOfLines=5;
    self.RightLable.textAlignment=NSTextAlignmentCenter;
    self.RightLable.font = [UIFont systemFontOfSize:18];
    
    

}
-(void)animation:(NSNotification *)animation
{
[UIView animateWithDuration:0.5 animations:^{
   self.CentreButton.transform = CGAffineTransformRotate(self.CentreButton.transform, M_PI_2);
    
}];
    
}

@end
