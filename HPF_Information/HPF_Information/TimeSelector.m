//
//  TimeSelector.m
//  HPF_Information
//
//  Created by hui on 16/5/2.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "TimeSelector.h"

@interface TimeSelector ()
{
    NSInteger start_year;
    NSString *_year;
    NSString *_month;
    NSString *_day;
}
@property(nonatomic,strong)NSString *currentTime;
@property(nonatomic,strong)NSDictionary *dataDic;
@property(nonatomic,strong)UITapGestureRecognizer *tap;;
@property(nonatomic,strong)UIView *PickView;
@end

@implementation TimeSelector

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
       
    
        
        self.PickView = [[UIView alloc]initWithFrame:CGRectMake(0,kSCREEN_HEIGHT, self.bounds.size.width,  (self.frame.size.width)*3/4)];
        self.pickerV.backgroundColor = [UIColor orangeColor];
        [self addSubview:self.PickView];
        
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, kSCREEN_WIDTH,  (self.frame.size.width)*3/4)];
        imageV.image =[UIImage imageNamed:@"2008111385229728_2"];
        imageV.backgroundColor = [UIColor clearColor];
        [self.PickView addSubview:imageV];
        
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(280, 20, 50, 50)];
        button.backgroundColor = [UIColor clearColor];
        [button setImage:[UIImage imageNamed:@"queding"] forState:UIControlStateNormal];
        button.layer.cornerRadius=25;
        button.layer.masksToBounds=YES;
        
        [button addTarget:self action:@selector(PickTime) forControlEvents:UIControlEventTouchUpInside];
        [self.PickView addSubview:button];
        
        
        
        
        self.pickerV = [[UIPickerView alloc]initWithFrame:CGRectMake(84,96, 236, 144)];
      
        
        
        [self.PickView addSubview:self.pickerV];
        self.pickerV.dataSource=self;
        self.pickerV.delegate=self;
        
        
        [UIView animateWithDuration:0.5 animations:^{
           
            self.PickView.center=self.center;
        }];
       
        self.tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapActiom:)];
    
        self.userInteractionEnabled=YES;
        [self addGestureRecognizer:self.tap];
        
        
        [self.PickView removeGestureRecognizer:self.tap];
        
        
        //存储年的数组
        start_year=2010;
        NSMutableArray *yearArray = [NSMutableArray array];
        for (NSInteger i = 0; i<16; i++) {
            
            
            [yearArray addObject:[NSString stringWithFormat:@"%ld年",start_year+i]];
        }
        
        //存储月份的数组
        NSMutableArray *monthArray = [NSMutableArray array];
        for (NSInteger i = 0; i<12; i++) {
            
            [monthArray addObject:[NSString stringWithFormat:@"%ld月",i+1]];
        }
        
        
        //存储天数的数组
        NSMutableArray *dayArray = [NSMutableArray array];
        for (NSInteger i = 0; i<31; i++) {
            
            [dayArray addObject:[NSString stringWithFormat:@"%ld日",i+1]];
        }
        
        //放进字典
        self.dataDic = [[NSDictionary alloc]initWithObjectsAndKeys:yearArray,@"year",monthArray,@"month",dayArray,@"day" ,nil];
        
        
        
        NSDate *  senddate=[NSDate date];
        
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        
        [dateformatter setDateFormat:@"YYYYMMdd"];
        
        NSString *  today=[dateformatter stringFromDate:senddate];
        
        
        NSInteger yearNow = [[today substringToIndex:4] integerValue]-start_year;
        NSInteger monthNow =  [[today substringWithRange:NSMakeRange(4, 2)] integerValue];
        
        NSInteger dayNow = [[today substringWithRange:NSMakeRange(6, 2)] integerValue];
        
        
        
        [self.pickerV selectRow:yearNow inComponent:0 animated:NO];
         [self.pickerV selectRow:monthNow-1 inComponent:1 animated:NO];
         [self.pickerV selectRow:dayNow-1 inComponent:2 animated:NO];
    }
    
    
    return self;

}
#pragma -mark UIpickerView 代理
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.dataDic.count;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSArray *keyArray = [self.dataDic allKeys];
    
    NSArray *contentArray = [self.dataDic objectForKey:keyArray[component]];
    
    
    if (component==2) {
        
        NSInteger month =[pickerView selectedRowInComponent:1]+1;
        
        NSInteger year = [pickerView selectedRowInComponent:0]+start_year;
        switch (month) {
            case 4: case 6: case 9: case 11:
                
                contentArray=[contentArray subarrayWithRange:NSMakeRange(0, 30)];
                return contentArray.count;
             case 2:
            {
                
                //判断是否是闰年28天
                if ([self isLeapYear:year])
                {

                //是
    contentArray=[contentArray subarrayWithRange:NSMakeRange(0, 28)];
                    
                }else
                {
                    //不是就29
    contentArray=[contentArray subarrayWithRange:NSMakeRange(0, 29)];
                
                }
                return contentArray.count;
            }
                
            default:
                return contentArray.count;
        }
        
    }

    return contentArray.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray *keyArray = [self.dataDic allKeys];
    
    NSArray *contentArray = [self.dataDic objectForKey:keyArray[component]];
    if (component==2) {
        //月
        NSInteger month  = [pickerView selectedRowInComponent:1]+1;
    
        //年
        NSInteger year = [pickerView selectedRowInComponent:0]+start_year;
        
        
        switch (month) {
            case 4: case 6: case 9: case 11:
                
                
                contentArray = [contentArray subarrayWithRange:NSMakeRange(0, 30)];
                return contentArray[row];
              
                case 2:
            {
               
                if ( [self isLeapYear:year])
                {
                    
                    //闰年
                    contentArray = [contentArray subarrayWithRange:NSMakeRange(0, 28)];
                }
                else
                {
                   
                    contentArray = [contentArray subarrayWithRange:NSMakeRange(0, 29)];
                }
                
                return contentArray[row];
            }
            default:
                return contentArray[row];
        }
    }
    return contentArray[row];
}
//设置宽度
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return self.bounds.size.width/5;
}

//高度
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30;

}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    
    NSArray *keyArray = [self.dataDic allKeys];
    
    NSArray *contentArray = [self.dataDic objectForKey:keyArray[component]];
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    lable.textAlignment=NSTextAlignmentCenter;
    lable.font =[UIFont boldSystemFontOfSize:15];
    lable.text = [contentArray objectAtIndex:row];
    return lable;
    

}
//当选择的行数改变时触发的方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    
   
    
    //第一列的被选择行变化，即年份改变，则刷新月份和天数
    if (component == 0)
    {
         //刷新月份与日期
        //下面是将月份和天数都定位到第一行
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView selectRow:0 inComponent:2 animated:YES];
        [pickerView reloadAllComponents];
        ;
       
        
    }
    //第二列的被选择行变化，即月份发生变化，刷新天这列的内容
    if (component == 1)
    {
        
        [pickerView selectRow:0 inComponent:2 animated:YES];
        [ pickerView reloadAllComponents];
       
        
    }//需要这些条件的原因是年份和月份的变化，都会引起每月的天数的变化，他们之间是有联系的，要掌握好他们之间的对应关系
    


    
}

//判断是否闰年
- (BOOL)isLeapYear:(NSInteger)year
{
    if ((year % 400 == 0) || ((year % 4 == 0) && (year % 100 != 0)))
    {
        return YES; //是闰年返回 YES
    }
    
    return NO; //不是闰年，返回 NO
}
//点击手势动画
-(void)tapActiom:(UITapGestureRecognizer *)senter
{
    
   
    [UIView animateWithDuration:0.5 animations:^{
       self.PickView.frame= CGRectMake(0,kSCREEN_HEIGHT, self.bounds.size.width,  (self.frame.size.height)/2);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
           
            usleep(333333);
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self removeFromSuperview];
            });
            
            
        });
       
        
    }];

}
//button点击事件
-(void)PickTime
{

  NSString *year=  [[self.dataDic objectForKey:@"year"] objectAtIndex:[self.pickerV selectedRowInComponent:0]];
    NSString *month=  [[self.dataDic objectForKey:@"month"] objectAtIndex:[self.pickerV selectedRowInComponent:1]];
    NSString *day=  [[self.dataDic objectForKey:@"day"] objectAtIndex:[self.pickerV selectedRowInComponent:2]];
    
  
    
   
    
    NSString*Dateyear = [year stringByReplacingOccurrencesOfString:@"年" withString:@""];;
    
 
    
    NSString*Datemonth = [month stringByReplacingOccurrencesOfString:@"月" withString:@""];
    
   
    
    NSString*Dateday = [day stringByReplacingOccurrencesOfString:@"日" withString:@""];
    
    
    NSString *date =  [[Dateyear stringByAppendingString:@"-"] stringByAppendingString:Datemonth];
    NSString *dateTime = [[date stringByAppendingString:@"-"] stringByAppendingString:Dateday];
    
    
    
    
    
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:dateTime,@"dateTime", nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"time" object:nil userInfo:dic];
   
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"time"];
    
    [[NSUserDefaults standardUserDefaults]setObject:dic forKey:@"time"];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.PickView.frame= CGRectMake(0,kSCREEN_HEIGHT, self.bounds.size.width,  (self.frame.size.height)/2);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            usleep(333333);
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self removeFromSuperview];
            });
            
            
        });
        
        
    }];
    

}
@end
