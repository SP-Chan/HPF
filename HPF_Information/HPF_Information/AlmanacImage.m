//
//  AlmanacImage.m
//  HPF_Information
//
//  Created by lanou on 16/5/4.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "AlmanacImage.h"

@implementation AlmanacImage

-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        
        self.imageV = [[UIImageView alloc]init];
        [self addSubview:self.imageV];
        self.lable = [[UILabel alloc]init];
        [self addSubview:self.lable];
        
    }
    return self;
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageV.frame = self.bounds;
    
    float width = self.imageV.bounds.size.width;
    self.lable.frame=CGRectMake(width*83/100,2, kSCREEN_WIDTH/6, kSCREEN_WIDTH/6);
    
    self.lable.layer.cornerRadius=kSCREEN_WIDTH/12;
    self.lable.layer.masksToBounds=YES;
    
    self.lable.layer.borderWidth=2;
    self.lable.layer.borderColor= [UIColor redColor].CGColor;
    
   
    NSDictionary *dic= [[NSUserDefaults standardUserDefaults]objectForKey:@"time"];
    NSString *time = [dic objectForKey:@"dateTime"];
    NSLog(@"%@",time);
    
    NSArray *array = [time componentsSeparatedByString:@"-"];
    
    NSString *times = [NSString stringWithFormat:@"%@日",[array lastObject] ];
    
    self.lable.text = times;
    self.lable.textAlignment=NSTextAlignmentCenter;
    self.lable.font = [UIFont boldSystemFontOfSize:25];
      self.lable.adjustsFontSizeToFitWidth = YES;
    self.lable.textColor = [UIColor redColor];
}

@end
