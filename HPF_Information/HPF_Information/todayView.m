//
//  todayView.m
//  星座view
//
//  Created by lanou on 16/5/9.
//  Copyright © 2016年 黄辉. All rights reserved.
//

#import "todayView.h"

@implementation todayView

-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        
        self.titleColumn = [[UIView alloc]init];
        [self addSubview:self.titleColumn];
        
        self.leftView = [[UIView alloc]init];
        [self.titleColumn addSubview:self.leftView];
        
         self.name = [[UILabel alloc]init];
        [self.leftView addSubview:self.name];
        
        
        
        self.contentColumn = [[UIView alloc]init];
        [self addSubview:self.contentColumn];
        
        self.rightView = [[UIView alloc]init];
        [self.titleColumn addSubview:self.rightView];
       
        self.date = [[UILabel alloc]init];
        [self.rightView addSubview:self.date];
        
        
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleColumn.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height*1/4);
    
    
    

 _leftView .frame= CGRectMake(0, 0, self.titleColumn.bounds.size.width*5/12, self.titleColumn.bounds.size.height);
    
    
    
    self.name.frame =CGRectMake(self.leftView.bounds.size.width/4, self.leftView.bounds.size.height/4, self.leftView.bounds.size.width*3/4, self.leftView.bounds.size.height/2);
    
     self.name.font =[UIFont boldSystemFontOfSize:28];
 self.name.textAlignment=NSTextAlignmentCenter;
    
    
  
    _imageV = [[UIImageView alloc]initWithFrame:CGRectMake(4, self.leftView.bounds.size.height*10/32, self.leftView.bounds.size.width/4,  self.leftView.bounds.size.width/4)];
   
    _imageV.image = [UIImage imageNamed:self.imageStr];
    [_leftView addSubview:_imageV];
    
    
   
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(4, self.leftView.bounds.size.height*3/4, self.leftView.bounds.size.width, self.leftView.bounds.size.height/4)];
    [self.leftView addSubview:label];
    label.textColor = [UIColor grayColor];
    label.text =self.dateStr;
    label.textAlignment=NSTextAlignmentCenter;
    
    UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(self.titleColumn.bounds.size.width*5/12, self.titleColumn.bounds.size.height/4, 4, self.titleColumn.bounds.size.height*3/4-4)];
    l.backgroundColor = [UIColor colorWithRed:120/255.0 green:47/255.0 blue:170/255.0 alpha:1];
    [self.titleColumn addSubview:l];
    
    
    
    
    _rightView.frame = CGRectMake(self.titleColumn.bounds.size.width*5/12+4, 0, self.titleColumn.bounds.size.width*7/12-4, self.titleColumn.bounds.size.height);
    
    
    UILabel *la = [[UILabel alloc]initWithFrame:CGRectMake(0, self.rightView.bounds.size.height/4, self.rightView.bounds.size.width*3/4, self.rightView.bounds.size.height/2)];
    
   
    
    la.text =@"今日运势";
    la.textAlignment=NSTextAlignmentCenter;
    la.font = [UIFont systemFontOfSize:25];
    la.textColor = [UIColor grayColor];
    la.alpha=0.8;
    [self.rightView addSubview:la];
    
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(5, self.rightView.bounds.size.height*3/4, self.rightView.bounds.size.width/3, self.rightView.bounds.size.height/4)];
    
    lab.text=@"有效日期:";
    lab.textAlignment = NSTextAlignmentLeft;
    lab.textColor = [UIColor grayColor];
    lab.font=[UIFont systemFontOfSize:15];
    [self.rightView addSubview:lab];
    
    
    _date.frame=CGRectMake(self.rightView.bounds.size.width/3+5, self.rightView.bounds.size.height*3/4, self.rightView.bounds.size.width*2/3, self.rightView.bounds.size.height/4);
    

    _date.font =[UIFont systemFontOfSize:14];
    _date.textAlignment=NSTextAlignmentLeft;
    _date.textColor =[UIColor colorWithRed:120/255.0 green:47/255.0 blue:170/255.0 alpha:1];
    
    
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, self.bounds.size.height*1/4+5, self.bounds.size.width, 1)];
    line.backgroundColor =[UIColor colorWithRed:120/255.0 green:47/255.0 blue:170/255.0 alpha:0.5];
    [self addSubview:line];
    
    _contentColumn.frame=CGRectMake(0, self.bounds.size.height*1/4+10, self.bounds.size.width, self.bounds.size.height*3/4-10);
    
    static NSInteger a =1;
    for (int i = 0; i<5; i++) {
        
        for (int j = 0; j<4; j++) {
            
            if ((j+1)%2==1) {
                UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(_contentColumn.bounds.size.width*j/4,_contentColumn.bounds.size.height*i/5, _contentColumn.bounds.size.width/6, _contentColumn.bounds.size.height/5-2)];
                title.tag =a;
                NSLog(@"奇数%ld",a);
                [self.contentColumn addSubview:title];
                title.backgroundColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1];
                title.textAlignment=NSTextAlignmentCenter;
                title.textColor= [UIColor blackColor];
                title.font=[UIFont systemFontOfSize:14];
            }else
            {
                
                
                if (i==4&&j==1) {
                    
                    UILabel *contents = [[UILabel alloc]initWithFrame:CGRectMake(_contentColumn.bounds.size.width*(j-1)/4+_contentColumn.bounds.size.width/6,_contentColumn.bounds.size.height*i/5, _contentColumn.bounds.size.width*5/6, _contentColumn.bounds.size.height/5-2)];
                    contents.tag=a;
                    NSLog(@"特殊%ld",a);
                    contents.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
                    
                    contents.font = [UIFont systemFontOfSize:13];
                    [self.contentColumn addSubview:contents];
                    contents.numberOfLines=4;
                    a=1;
                    break;
                    
                    
                   
                  
                }
                
                
              UILabel *content = [[UILabel alloc]initWithFrame:CGRectMake(_contentColumn.bounds.size.width*(j-1)/4+_contentColumn.bounds.size.width/6,_contentColumn.bounds.size.height*i/5, _contentColumn.bounds.size.width/3, _contentColumn.bounds.size.height/5-2)];
                [self.contentColumn addSubview:content];
                content.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
                content.tag=a;
                content.textAlignment=NSTextAlignmentCenter;
                content.textColor= [UIColor grayColor];
NSLog(@"偶数%ld",a);
            
            }
        
            a++;
        }
    }
   
    
    
        NSString *content= [[_Datadic objectForKey:@"number"] stringValue];
   
  
NSArray *array = [NSArray arrayWithObjects:
    @"综合指数",[_Datadic objectForKey:@"all"],
    @"幸运颜色",[_Datadic objectForKey:@"color"],
    @"健康指数",[_Datadic objectForKey:@"health"],
    @"恋爱指数",[_Datadic objectForKey:@"love"],
    @"财运指数",[_Datadic objectForKey:@"money"],
    @"幸运数字",content,
    @"工作指数",[_Datadic objectForKey:@"work"],
    @"速配星座",[_Datadic objectForKey:@"QFriend"],
    @"今日解析",[_Datadic objectForKey:@"summary"],nil];
    
    NSLog(@"==%ld",array.count);
    

    for (int i = 0; i<array.count; i++) {
        
        UILabel *lab = (UILabel *)[_contentColumn viewWithTag:(i+1)];
        
        lab.text = [array objectAtIndex:i];
        
    }
        
}


@end
