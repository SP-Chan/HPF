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


-(instancetype)init
{
    if ([super init]) {
         [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(timeActiom:) name:@"time" object:nil];
    }
    return self;
    
}
-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    }
    _scrollView.contentSize = CGSizeMake(0, kSCREEN_HEIGHT*2);
    _scrollView.bounces=NO;
    _scrollView.showsVerticalScrollIndicator=NO;
    _scrollView.backgroundColor = [UIColor colorWithRed:255/255.0 green:251/255.0 blue:232/255.0 alpha:1];
    [self.view addSubview:_scrollView];
    return _scrollView;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    _activity = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    _activity.layer.position=CGPointMake(kSCREEN_WIDTH/2, kSCREEN_HEIGHT/2-64);
    [_activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [_activity setColor:[UIColor blackColor]];
    [self.view addSubview:_activity];
    [_activity startAnimating];
    
 
   

    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    
    _urlTime=[dateformatter stringFromDate:senddate];
    
    _UserDdfaults = [NSUserDefaults standardUserDefaults];

  

   
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Actiom:) name:@"标签" object:nil];

    

    
    [_UserDdfaults removeObjectForKey:@"time"];
    
    [_UserDdfaults setObject:_urlTime forKey:@"time"];
    
    NSLog(@"主要===%@",_urlTime);
    
    
     [self requestData];
     [self setTimeTitle];
     _constellationArray = [NSMutableArray array];
    for (int i = 0; i<12; i++) {
        NSString *str = [NSString stringWithFormat:@"8432807_%d.jpg",i+1];
        UIImage *image = [UIImage imageNamed:str];
        [_constellationArray addObject:image];
    }
    
   
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
    _dataDic = [NSDictionary dictionary];
   
    
    
    
    NSString *url = [NSString stringWithFormat:@"http://v.juhe.cn/laohuangli/d?date=%@&key=b45f8bf8fd8c3132a47890b409ae984d",_urlTime];

    [NetworkRequestManager requestWithType:GET urlString:url ParDic:nil Header:nil finish:^(NSData *data) {
        
        
        
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
       self.dataDic = [dic objectForKey:@"result"];
     
        
         [NSThread detachNewThreadSelector:@selector(doMain) toTarget:self withObject:nil];
        
    } err:^(NSError *error) {
        
    }];
    
    

}
-(void)doMain
{
    [self SetMainInterface];
    [_activity stopAnimating];
    
}
-(void)doData
{
    [self requestData];

}

-(void)SetMainInterface
{

    
    AlmanacImage *imageV = [[AlmanacImage alloc]init];;
    imageV.frame =CGRectMake(0, 0, kSCREEN_WIDTH,kSCREEN_HEIGHT/3);
    
    NSURL *url = [NSURL URLWithString:@"http://img4.tiboo.cn/1008/481757_12823573491.jpg"];
//
    imageV.layer.borderWidth = 1;
    imageV.layer.borderColor=[UIColor redColor].CGColor;
    imageV.layer.cornerRadius=5;
    imageV.layer.masksToBounds=YES;
    [self.scrollView addSubview:imageV];
    [imageV.imageV sd_setImageWithURL:url];
    
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
    
    NSString *y =[dic objectForKey:@"year"];
    
    NSString*year = [y substringToIndex:4];
    
    NSString *m =[dic objectForKey:@"month"];
    
    NSString*month = [m substringToIndex:1];
    
    NSString *d =[dic objectForKey:@"day"];
    
    NSString*day = [d substringToIndex:1];
    
     NSString *time =  [[year stringByAppendingString:@"-"] stringByAppendingString:month];
    
    
    _urlTime = [[time stringByAppendingString:@"-"] stringByAppendingString:day];
    NSLog(@"timeSelectpr== %@",_urlTime);
    
    
    [_UserDdfaults setObject:_urlTime forKey:@"time"];
    [self.contenTwo removeFromSuperview];
    
    for (UIView *view in self.scrollView.subviews) {
        
        [view removeFromSuperview];
            }
    [self requestData];
    
  
    
}




- (void)starButtonClicked:(id)sender
{
    
     [[NSNotificationCenter defaultCenter]postNotificationName:@"animation" object:nil];

    
    [_UserDdfaults setObject:_urlTime forKey:@"tite"];

}


#pragma -mark titleTime
-(void)setTimeTitle
{

    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY年MM月"];
    
      NSString *time =[dateformatter stringFromDate:senddate];
    
    [dateformatter setDateFormat:@"EEEE"];
    NSString *Week = [dateformatter stringFromDate:senddate];
   
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = CGRectMake(kSCREEN_WIDTH/3, 20, kSCREEN_WIDTH/3, 24);
    [self.navigationController.view addSubview:button];
    [button setTitle:time forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(titleTime) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    button.titleLabel.numberOfLines=2;
    [button setImage:[UIImage imageNamed:@"Unknown-1"] forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0,100, 0, 0)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -25, 0, 0)];
    
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH/3, 40, kSCREEN_WIDTH/3, 24)];
    lable.text =Week;
    lable.textAlignment=NSTextAlignmentCenter;
    lable.font = [UIFont systemFontOfSize:15];
    [self.navigationController.view addSubview:lable];
  
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
       
    view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 160, kSCREEN_HEIGHT/6)];
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

//    NSLog(@"%ld",index);
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"SolveDream" object:nil];
    
//    ConstellationViewController *con  =[[ConstellationViewController alloc]init];
//    [self.navigationController pushViewController:con animated:YES];
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
