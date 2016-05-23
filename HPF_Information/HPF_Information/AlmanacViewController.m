//
//  AlmanacViewController.m
//  HPF_Information
//
//  Created by XP on 16/4/29.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "AlmanacViewController.h"
#import "UIImageView+WebCache.h"
#import "iCarousel.h"
#import "AlmanacContentThree.h"
#import "AlmanacContentTwo.h"
#import "AlmanacImage.h"
#import "AlmanacContentOne.h"
#import "NetworkRequestManager.h"
#import "ConstellationViewController.h"
#import "HPFBaseLabel.h"
#import "SolveLogo.h"
#import "MarkViewController.h"
#import "totalDataBaseUtil.h"
#import "activityView.h"
@interface AlmanacViewController ()<iCarouselDataSource,iCarouselDelegate,UISearchBarDelegate>
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)NSDictionary *dataDic;
@property(nonatomic,strong)AlmanacContentTwo *contenTwo;

@property(nonatomic,strong)iCarousel *iCarousel;
@property(nonatomic,strong)NSString *urlTime;
@property(nonatomic,strong)UIActivityIndicatorView *activity;

@property(nonatomic,strong)NSMutableArray *constellationArray;
@property(nonatomic,strong)HPFBaseLabel *constellationTitle;
@property(nonatomic,strong)HPFBaseLabel *dreamTitle;
@property(nonatomic,strong)HPFBaseImageView *dreamImage;
@property(nonatomic,strong)NSUserDefaults *UserDdfaults;

@end

@implementation AlmanacViewController



-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    }
    _scrollView.contentSize = CGSizeMake(0, kSCREEN_HEIGHT*2);
    _scrollView.bounces=NO;
    _scrollView.showsVerticalScrollIndicator=NO;
   
    [self.view addSubview:_scrollView];
    return _scrollView;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     
     春绿色 [UIColor colorWithRed:105/255.0 green:178/255.0 blue:115/255.0 alpha:1];
      
     [UIColor colorWithRed:249/255.0 green:191/255.0 blue:100/255.0 alpha:1];
     */


    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    
    _urlTime=[dateformatter stringFromDate:senddate];

    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:_urlTime,@"dateTime", nil];
    
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"time"];
    
    [[NSUserDefaults standardUserDefaults]setObject:dic forKey:@"time"];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Actiom:) name:@"标签" object:nil];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(search:) name:@"搜索" object:nil];

     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(yearBeyond) name:@"yearBeyond" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(timeActiom:) name:@"time" object:nil];

     [self requestData];
    
     _constellationArray = [NSMutableArray array];
    for (int i = 0; i<12; i++) {
        NSString *str = [NSString stringWithFormat:@"xingzuo000%d.jpg",i+1];
        UIImage *image = [UIImage imageNamed:str];
        [_constellationArray addObject:image];
    }

    [self setRightNavigation];
}
-(void)setRightNavigation
{
  
    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    [rightButton setImage:[UIImage imageNamed:@"jing.png"]forState:UIControlStateNormal];
    
    [rightButton addTarget:self action:@selector(Comeback) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    
    self.navigationItem.rightBarButtonItem= rightItem;
}

-(void)Comeback
{

    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    
    _urlTime=[dateformatter stringFromDate:senddate];
    
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:_urlTime,@"dateTime", nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"time" object:nil userInfo:dic];
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"time"];
    
    [[NSUserDefaults standardUserDefaults]setObject:dic forKey:@"time"];
 
}
#pragma -mark 解梦通知
-(void)Actiom:(NSNotification *)actiom
{
    NSDictionary *dic = actiom.userInfo;
    
    NSLog(@"%@", [dic objectForKey:@"tag"]);
    
    NSMutableArray *array = [NSMutableArray array];
    array = [[totalDataBaseUtil shareTotalDataBase]selectDreamWithParentld:[dic objectForKey:@"tag"]];
    MarkViewController *mark = [[MarkViewController alloc]init];
    mark.dataArray=array;
    
    mark.identifier=[dic objectForKey:@"tag"];
    [self.navigationController pushViewController:mark animated:YES];
//     [self presentViewController:mark animated:YES completion:nil];
    
}
#pragma -mark 解梦搜索通知
-(void)search:(NSNotification *)search
{
    NSMutableArray *array = [NSMutableArray array];
    array = [[totalDataBaseUtil shareTotalDataBase]selectDreamWithTitle:@""];
    MarkViewController *mark = [[MarkViewController alloc]init];
    mark.dataArray=array;
    [self.navigationController pushViewController:mark animated:YES];
//    [self presentViewController:mark animated:YES completion:nil];
    

}
#pragma -mark 年份超出通知
-(void)yearBeyond
{
   
    
  UIAlertController *alert =  [UIAlertController alertControllerWithTitle:@"没有数据最多到2020年" message:@"请重新选择年份" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *ale = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    
    [alert addAction:ale];
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:YES completion:^{
        
    }];
    });
    




}


//设置iCarousel
-(iCarousel *)iCarousel{
    
    if (_iCarousel == nil) {
        _iCarousel = [[iCarousel alloc] initWithFrame:CGRectMake(4 , kSCREEN_HEIGHT*105/108 , kSCREEN_WIDTH-8, kSCREEN_HEIGHT/6)];
        _iCarousel.delegate = self;
        _iCarousel.dataSource = self;
        _iCarousel.bounces = NO;
        _iCarousel.pagingEnabled = NO;
        _iCarousel.type = iCarouselTypeCustom;
        _iCarousel.scrollEnabled=YES;
    }
    return _iCarousel;
}


//设置星座标题
-(void)constellation
{
        
        self.constellationTitle = [[HPFBaseLabel alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH/4, kSCREEN_HEIGHT*8/9, kSCREEN_WIDTH/2, kSCREEN_HEIGHT/12)];
   
    
    self.constellationTitle.font = [UIFont boldSystemFontOfSize:22];
    self.constellationTitle.textAlignment=NSTextAlignmentCenter;
    self.constellationTitle.textColor= [UIColor redColor];
    self.constellationTitle.text =@"星座运程";
    
    [self.scrollView addSubview:self.constellationTitle];
    
    
    
    
    self.dreamTitle = [[HPFBaseLabel alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH/4, kSCREEN_HEIGHT*123/108, kSCREEN_WIDTH/2, kSCREEN_HEIGHT/12)];
    
    
    self.self.dreamTitle.font = [UIFont boldSystemFontOfSize:22];
    self.self.dreamTitle.textAlignment=NSTextAlignmentCenter;
    self.self.dreamTitle.textColor= [UIColor redColor];
    self.self.dreamTitle.text =@"周公解梦";
    
    [self.scrollView addSubview:self.dreamTitle];
    
    
    
    
    
    
    
    
    
    
    
}
-(void)requestData
{
    activityView *acti = [[activityView alloc]init];
    [self.view addSubview:acti];
    [acti setActivityColor:[UIColor blackColor]];
    
    
    NSString *url = [NSString stringWithFormat:@"http://v.juhe.cn/laohuangli/d?date=%@&key=b45f8bf8fd8c3132a47890b409ae984d",_urlTime];

    [NetworkRequestManager requestWithType:GET urlString:url ParDic:nil Header:nil finish:^(NSData *data) {
        
        
        
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
       self.dataDic = [dic objectForKey:@"result"];
     
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            
            
           
            if (self.dataDic.count>0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self setTimeTitle];
                    [self SetMainInterface];
                    [acti removeFromSuperview];
                    
                });
                
            }
            
        });
        
        
    } err:^(NSError *error) {
        
    }];
    
    

}

-(void)doData
{
    [self requestData];

}

-(void)SetMainInterface
{

    
    AlmanacImage *imageV = [[AlmanacImage alloc]init];;
    imageV.frame =CGRectMake(0, 0, kSCREEN_WIDTH,kSCREEN_HEIGHT/3);
    
    imageV.backgroundColor = [UIColor clearColor];
//
    imageV.layer.borderWidth = 1;
    imageV.layer.borderColor=[UIColor redColor].CGColor;
    imageV.layer.cornerRadius=5;
    imageV.layer.masksToBounds=YES;
    [self.scrollView addSubview:imageV];
    imageV.imageV.image = [UIImage imageNamed:@"481757_12823573491"];
    
    AlmanacContentThree *three = [[AlmanacContentThree alloc]init];
    three.frame = CGRectMake(4, kSCREEN_HEIGHT/3, kSCREEN_WIDTH-8, kSCREEN_HEIGHT/9);
    three.leftLabel.text=[self.dataDic objectForKey:@"yinli"];
    three.rightLable.text = [self.dataDic objectForKey:@"chongsha"];
   
    
    [self.scrollView addSubview:three];
    
    _contenTwo = [[AlmanacContentTwo alloc]init];;
  
    _contenTwo.frame = CGRectMake(4,kSCREEN_HEIGHT*4/9, kSCREEN_WIDTH-8,kSCREEN_HEIGHT*2/9);
    [self.scrollView addSubview:_contenTwo];
   
    _contenTwo.LeftLable.text = [self.dataDic objectForKey:@"yi"];
    _contenTwo.RightLable.text = [self.dataDic objectForKey:@"ji"];
    [_contenTwo.CentreButton addTarget:self action:@selector(starButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    

    
    AlmanacContentOne *one  = [[AlmanacContentOne alloc]initWithFrame:CGRectMake(4, kSCREEN_HEIGHT*2/3, kSCREEN_WIDTH-8, kSCREEN_HEIGHT*2/9)];
    one.luckyTime.text = [self.dataDic objectForKey:@"jishen"];
    one.fierceTime.text = [self.dataDic objectForKey:@"xiongshen"];
    
    one.CentreLable.text = [self.dataDic objectForKey:@"wuxing"];
    
    NSString *str = [self.dataDic objectForKey:@"baiji"];
    
  
    one.CentreLeftLabel.text = [str substringWithRange:NSMakeRange(0, 8)];
    one.CentreRightLabel.text= [str substringWithRange:NSMakeRange(8, 9)];
    
    [self.scrollView addSubview:one];
    
    [self iCarousel];
    [self.scrollView addSubview:_iCarousel];
    
    [self constellation];
    
    SolveLogo *solve = [[SolveLogo alloc]initWithFrame:CGRectMake(4, kSCREEN_HEIGHT*132/108, kSCREEN_WIDTH-8, kSCREEN_HEIGHT*3/4)];
    [self.scrollView addSubview:solve];
  
    
    
    
}

-(void)timeActiom:(NSNotification *)notification
{
    NSDictionary *dic = notification.userInfo;
    
   

    
    _urlTime = [dic objectForKey:@"dateTime"];
        
        
        for (UIView *view in self.scrollView.subviews) {
            
            [view removeFromSuperview];
            
            
        }
    
    
    UIView *vi = [self.navigationController.view viewWithTag:10086];
    
    [vi removeFromSuperview];
        [self requestData];
        

    
  
    
}




- (void)starButtonClicked:(id)sender
{
    
     [[NSNotificationCenter defaultCenter]postNotificationName:@"animation" object:nil];

    
//    [_UserDdfaults setObject:_urlTime forKey:@"tite"];

}


#pragma -mark titleTime
-(void)setTimeTitle
{
    
    
    
    
    NSArray *array = [_urlTime componentsSeparatedByString:@"-"];
    NSString *y = [NSString stringWithFormat:@"%@年",array[0]];
    NSString *m = [NSString stringWithFormat:@"%@月",array[1]];
    NSString *time = [y stringByAppendingString:m];
    
    _timeView =[[UIView alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH*17/48, 20, kSCREEN_WIDTH*7/24, 44)];
    _timeView.tag = 10086;
    [self.navigationController.view addSubview:_timeView];
    
    
    
    
    NSString *centuryString =[array[0] substringWithRange:NSMakeRange(0, 2)];
    NSString *yearString = [array[0] substringWithRange:NSMakeRange(2, 2)];
    
    NSString *monthString = array[1];
    NSString *dayString = [array lastObject];
    
    NSInteger century = [centuryString integerValue];
    NSInteger year = [yearString integerValue];
    NSInteger month = [monthString integerValue];
    NSInteger day = [dayString integerValue];
    
    
    
    
    
    NSInteger weekInt = [self AccordingToCentury:century Year:year Month:month Day:day];
    
    
    
    UILabel *upLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.timeView.bounds.size.width- self.timeView.bounds.size.height/2, self.timeView.bounds.size.height/2)];
    
    [_timeView addSubview:upLable];
    upLable.font= [UIFont systemFontOfSize:16];
    upLable.textAlignment=NSTextAlignmentCenter;
    upLable.text=time;
    upLable.adjustsFontSizeToFitWidth = YES;
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake( self.timeView.bounds.size.width-self.timeView.bounds.size.height/2, self.timeView.bounds.size.height/12, self.timeView.bounds.size.height/3, self.timeView.bounds.size.height/3)];
    image.image = [UIImage imageNamed:@"time"];
    [self.timeView addSubview:image];
    
    
    
    image.contentMode = UIViewContentModeScaleAspectFill;
    
    
    
    UILabel *NextLable = [[UILabel alloc]initWithFrame:CGRectMake(0, _timeView.bounds.size.height/2, _timeView.bounds.size.width, _timeView.bounds.size.height/2)];
    
    
    NextLable.text =[self ChangeWeek:weekInt];
    
    NextLable.textAlignment=NSTextAlignmentCenter;
    NextLable.font = [UIFont systemFontOfSize:16];
    NextLable.adjustsFontSizeToFitWidth = YES;
    [self.timeView addSubview:NextLable];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = CGRectMake(0, 0, _timeView.bounds.size.width, _timeView.bounds.size.height);
    
    
    [button addTarget:self action:@selector(titleTime) forControlEvents:UIControlEventTouchUpInside];
    [self.timeView addSubview:button];
    
}
#pragma -mark 转换星期的方法
-(NSString *)ChangeWeek:(NSInteger)week
{

    switch (week) {
        case 0:
            return @"星期日";
            break;
        case 1:
            return @"星期一";
            break;
        case 2:
            return @"星期二";
            break;
        case 3:
            return @"星期三";
            break;
        case 4:
            return @"星期四";
            break;
        case 5:
            return @"星期五";
            break;
        case 6:
            return @"星期六";
            break;
        
        default:
            break;
    }
    return @"不存在";

}


#pragma -mark 计算星期的方法
-(NSInteger)AccordingToCentury:(NSInteger)century Year:(NSInteger)year Month:(NSInteger)month Day:(NSInteger)day

{

    if (month==1) {
        
       year = year-1;
       month = month+12;
        
        
     NSInteger weeks= year +year/4+century/4 -2*century+26*(month+1)/10+day-1;
        if (weeks<0) {
            
            while (true) {
               
                if (weeks>0) {
                    return weeks%7;
                    break;
                }
             weeks =weeks + 7;
            }
            
        }else
        {
            return weeks%7;
        
        }
        
    }else if (month==2)
    {
        
        year = year -1;
         month = month+12;
        NSInteger weeks = (year +year/4+century/4 -2*century+26*(month+1)/10+day-1)%7;
        if (weeks<0) {
            
            while (true) {
                weeks =weeks + 7;
                if (weeks>0) {
                    return weeks%7;
                    break;
                }
                
            }
            
        }else
        {
            return weeks%7;
            
        }
        
    }else{
        
        NSInteger weeks = (year +year/4+century/4 -2*century+26*(month+1)/10+day-1)%7;
        if (weeks<0) {
            
            while (true) {
                weeks =weeks + 7;
                if (weeks>0) {
                    return weeks%7;
                     break;
                }
               
            }
            
        }else
        {
            return weeks%7;
            
        }
    }




}
-(void)titleTime
{
   
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TimeSelector" object:nil];
    
    

}
#pragma -mark  iCarousel代理

-(NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    
    
    return _constellationArray.count;
}
-(UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if (view == nil) {
       
    view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, kSCREEN_HEIGHT/6)];
    }
    ((UIImageView *)view).image = [_constellationArray objectAtIndex:index];
   
    return view;


}
-(CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform{
    static CGFloat max_sacle = 1.0f;
    static CGFloat min_scale = 0.7f;
    if (offset <= 1 && offset >= -1) {
        float tempScale = offset < 0 ? 1+offset : 1-offset;
        float slope = (max_sacle - min_scale) / 1;
        
        CGFloat scale = min_scale + slope*tempScale;
        transform = CATransform3DScale(transform, scale, scale, 1);
    }else{
        transform = CATransform3DScale(transform, min_scale, min_scale, 1);
    }
    
    return CATransform3DTranslate(transform, offset * self.iCarousel.itemWidth * 1.5, 0.0, 0.0);
}

-(void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{

    NSMutableArray *ConstellationArray =[NSMutableArray arrayWithObjects:@"白羊座",@"处女座",@"金牛座",@"巨蟹座",@"摩羯座",@"射手座",@"狮子座",@"双鱼座",@"双子座",@"水瓶座",@"天平座",@"天蝎座", nil];
    NSMutableArray *imageArray = [NSMutableArray array];
    for (int i = 1; i<=12; i++) {
        NSString *str = [NSString stringWithFormat:@"xing%d",i];
        
        
        [imageArray addObject:str];
        
    }
    
    NSMutableArray *dateArray = [NSMutableArray arrayWithObjects:@"3.21-4.19",@"8.23-9.22",@"4.20-5.20",@"6.22-7.22",@"12.22-1.19",@"11.23-12.21",@"7.23-8.22",@"2.19-3.20",@"5.21-6.21",@"1.20-2.18",@"9.23-10.23",@"10.24-11.22", nil];
    
    ConstellationViewController *constellation = [[ConstellationViewController alloc]init];
    
    constellation.Constellation = [ConstellationArray objectAtIndex:index];
    constellation.date= [dateArray objectAtIndex:index];
    constellation.image=[imageArray objectAtIndex:index];
    
    [self.navigationController pushViewController:constellation animated:YES];
    
    
 
}
-(CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{

    return kSCREEN_HEIGHT/6;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
