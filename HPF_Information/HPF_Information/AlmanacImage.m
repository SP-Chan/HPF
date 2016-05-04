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
        
    }
    return self;
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageV.frame = self.bounds;

}
@end
