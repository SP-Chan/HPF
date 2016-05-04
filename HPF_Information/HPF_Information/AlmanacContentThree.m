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
        self.RightView = [[UIView alloc]init];
        [self addSubview:self.RightView];
        
        
    }
    return self;
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.LeftView.frame = CGRectMake(0, 0, Width/2, Height);
    self.LeftView.layer.borderWidth=1;
    self.LeftView.layer.borderColor =[UIColor redColor].CGColor;
    self.LeftView.backgroundColor = [UIColor colorWithRed:arc4random()%254/255.0 green:arc4random()%254/255.0 blue:arc4random()%254/255.0 alpha:1];
    self.RightView.frame = CGRectMake(Width/2, 0, Width/2, Height);
    self.RightView.layer.borderWidth=1;
    self.RightView.layer.borderColor =[UIColor redColor].CGColor;
    self.RightView.backgroundColor = [UIColor colorWithRed:arc4random()%254/255.0 green:arc4random()%254/255.0 blue:arc4random()%254/255.0 alpha:1];

}
@end
