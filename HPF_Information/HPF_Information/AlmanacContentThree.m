//
//  AlmanacContentThree.m
//  HPF_Information
//
//  Created by lanou on 16/5/4.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "AlmanacContentThree.h"

@implementation AlmanacContentThree

-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        
        self.LeftView = [[UIView alloc]init];
        [self addSubview:self.LeftView];
        
        self.leftLabel = [[UILabel alloc]init];
        [self.LeftView addSubview:self.leftLabel];
        
        self.RightView = [[UIView alloc]init];
        [self addSubview:self.RightView];
        
        self.rightLable = [[UILabel alloc]init];
        [self.RightView addSubview:self.rightLable];
        
        
    }
    return self;
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.LeftView.frame = CGRectMake(0, 0, Width/2, Height);
    self.LeftView.layer.borderWidth=1;
    self.LeftView.layer.borderColor =[UIColor redColor].CGColor;
    self.leftLabel.frame =CGRectMake(0, 0,Width/2,Height );
    self.leftLabel.font = [UIFont boldSystemFontOfSize:20];
    self.leftLabel.textAlignment=NSTextAlignmentCenter;
    self.leftLabel.textColor = [UIColor redColor];
    self.leftLabel.adjustsFontSizeToFitWidth = YES;
    
    
    self.rightLable.frame =CGRectMake(0, 0,Width/2,Height );
    self.rightLable.font = [UIFont boldSystemFontOfSize:20];
    self.rightLable.textAlignment=NSTextAlignmentCenter;
    self.rightLable.textColor = [UIColor redColor];
   self.rightLable.adjustsFontSizeToFitWidth = YES;
   
  
    self.RightView.frame = CGRectMake(Width/2, 0, Width/2, Height);
    self.RightView.layer.borderWidth=1;
    self.RightView.layer.borderColor =[UIColor redColor].CGColor;
   

}
@end
