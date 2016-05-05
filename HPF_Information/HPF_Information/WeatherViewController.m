//
//  WeatherViewController.m
//  HPF_Information
//
//  Created by 小p on 16/5/4.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "WeatherViewController.h"
#import "AirAndHumidity.h"
#import "CurrentWeather.h"
#import "TwentyFourHoursWeather.h"
#import "WeatherAndLine.h"
#import "MinWeather.h"
#import "XPChartAndLineView.h"
#import "CurrentStatus.h"
#import "CurrentWindModel.h"
#import "CurrentWeatherModel.h"
#import "LifeModel.h"
#import "FiveDayWeatherModel.h"
#import "PM25Model.h"
@interface WeatherViewController ()
@property(nonatomic,strong)AirAndHumidity *airAndHumidity;
@property(nonatomic,strong)CurrentWeather *currentWeather;
@property(nonatomic,strong)TwentyFourHoursWeather *twentyFourHoursWeather;
@property(nonatomic,strong)UIScrollView *weatherScrollView;
@property(nonatomic,strong)HPFBaseView *weatherAndLineView;
@property(nonatomic,strong)HPFBaseView *maxLineView;
@property(nonatomic,strong)HPFBaseView *minLineView;
@property(nonatomic,strong)HPFBaseView *minWeatherView;
@property(nonatomic,strong)NSMutableArray *maxLineYArray;
@property(nonatomic,strong)NSMutableArray *minLineYArray;
@property(nonatomic,strong)NSMutableArray *maxAndMinLineXArray;
@property(nonatomic,strong)NSMutableArray *maxStringYArray;
@property(nonatomic,strong)NSMutableArray *minStringYarray;
@property(nonatomic,strong)CurrentStatus *currentStatus;
@property(nonatomic,strong)CurrentWindModel *currentWindModel;
@property(nonatomic,strong)CurrentWeatherModel *currentWeatherModel;
@property(nonatomic,strong)LifeModel *lifeModel;
@property(nonatomic,strong)NSMutableArray *fiveDayModelArray;
@property(nonatomic,strong)PM25Model *pm25Model;
@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    [self createNavgationLeftBarButton];
    
    [self requestData];
}
-(void)requestData
{
    [NetworkRequestManager requestWithType:POST urlString:@"http://op.juhe.cn/onebox/weather/query" ParDic:@{@"cityname":@"广州",@"key":@"6f7d1010d25efb9ee9417c39e5f94581"} Header:nil finish:^(NSData *data) {
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        NSDictionary *dicResult = [dic objectForKey:@"result"];
        NSDictionary *dicData = [dicResult objectForKey:@"data"];
        //赋值 1
        NSDictionary *dicRealtime = [dicData objectForKey:@"realtime"];
        [self.currentStatus setValuesForKeysWithDictionary:dicRealtime];
        [self.currentWindModel setValuesForKeysWithDictionary:self.currentStatus.wind];
        [self.currentWeatherModel setValuesForKeysWithDictionary:self.currentStatus.weather];
        //赋值 2
        NSDictionary *dicLife = [dicData objectForKey:@"life"];
        NSDictionary *dicInfo = [dicLife objectForKey:@"info"];
        [self.lifeModel setValuesForKeysWithDictionary:dicInfo];
      
        //赋值 3
        NSArray *weatherArray = [dicData objectForKey:@"weather"];
        for (NSDictionary *fiveDayDic in weatherArray) {
            FiveDayWeatherModel *fiveDayModel = [[FiveDayWeatherModel alloc] init];
            [fiveDayModel setValuesForKeysWithDictionary:fiveDayDic];
            [self.fiveDayModelArray addObject:fiveDayModel];
        }
        NSLog(@"%ld",self.fiveDayModelArray.count);
        
        //赋值 4
        NSDictionary *pm25Dic = [dicData objectForKey:@"pm25"];
        NSDictionary *pm25SecondDic = [pm25Dic objectForKey:@"pm25"];
        [self.pm25Model setValuesForKeysWithDictionary:pm25SecondDic];
        NSLog(@"%@",self.pm25Model.des);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view addSubview:self.weatherScrollView];
        });
        
    } err:^(NSError *error) {
        
    }];
 
}


#pragma mark- 懒加载
//懒加载PM25Model
-(PM25Model *)pm25Model
{
    if (!_pm25Model) {
        _pm25Model = [[PM25Model alloc] init];
    }
    return _pm25Model;
}
//懒加载装载最近5天天气的数组
-(NSMutableArray *)fiveDayModelArray
{
    if (!_fiveDayModelArray) {
        _fiveDayModelArray = [NSMutableArray array];
    }
    return _fiveDayModelArray;
}

//懒加载生活指数model
-(LifeModel *)lifeModel
{
    if (!_lifeModel) {
        _lifeModel = [[LifeModel alloc] init];
    }
    return _lifeModel;
}
//懒加载当前天气状态的model
-(CurrentStatus *)currentStatus
{
    if (!_currentStatus) {
        _currentStatus = [[CurrentStatus alloc] init];
    }
    return _currentStatus;
}
//懒加载当前风力的model
-(CurrentWindModel *)currentWindModel
{
    if (!_currentWindModel) {
        _currentWindModel = [[CurrentWindModel alloc] init];
    }
    return _currentWindModel;
}
//懒加载当前天气的model
-(CurrentWeatherModel *)currentWeatherModel
{
    if (!_currentWeatherModel) {
        _currentWeatherModel = [[CurrentWeatherModel alloc] init];
    }
    return _currentWeatherModel;
}
//懒加载最低温度和最高温度的X轴坐标
-(NSMutableArray *)maxAndMinLineXArray
{
    if (!_maxAndMinLineXArray) {
        _maxAndMinLineXArray = [NSMutableArray array];
        for (int i = 0; i<5; i++) {
            NSString *string = [NSString stringWithFormat:@"%f",kSCREEN_WIDTH/5*i+kSCREEN_WIDTH/5/2];
            [_maxAndMinLineXArray addObject:string];
        }
    }
    return _maxAndMinLineXArray;
}
//懒加载最高温度的Y轴坐标
-(NSMutableArray *)maxLineYArray
{
    if (!_maxLineYArray) {
        _maxLineYArray = [NSMutableArray arrayWithObjects:@"30",@"16",@"28",@"30",@"29", nil];
    }
    return _maxLineYArray;

}
//懒加载最低温度的Y轴坐标
-(NSMutableArray *)minLineYArray
{
    if (!_minLineYArray) {
        _minLineYArray = [NSMutableArray arrayWithObjects:@"23",@"23",@"22",@"25",@"25", nil];
    }
    return _minLineYArray;
}
//懒加载最高温度显示到线上的数字
-(NSMutableArray *)maxStringYArray
{
    if (!_maxStringYArray) {
        _maxStringYArray = [NSMutableArray arrayWithObjects:@"30°",@"16°",@"28°",@"30°",@"29°", nil];
    }
    return _maxStringYArray;
}
//懒加载最低温度显示到线上的数字
-(NSMutableArray *)minStringYarray
{
    if (!_minStringYarray) {
        _minStringYarray = [NSMutableArray arrayWithObjects:@"23°",@"23°",@"22°",@"25°",@"25°", nil];
    }
    return _minStringYarray;
}
//当前天气view
-(CurrentWeather *)currentWeather
{
    if (!_currentWeather) {
        _currentWeather = [[[NSBundle mainBundle] loadNibNamed:@"CurrentWeather" owner:self options:nil] lastObject];
        _currentWeather.frame = CGRectMake(0, 0, kSCREEN_WIDTH, 150);
        _currentWeather.currentDateLabel.text = self.currentStatus.date;
        _currentWeather.currentWeatherLabel.text = [NSString stringWithFormat:@"%@°",self.currentWeatherModel.temperature];
//        _currentWeather.currentMaxAndMinLabel = [NSString stringWithFormat:@"%@/%@",]
    }
    return _currentWeather;
}
//空气质量和湿度view
-(AirAndHumidity *)airAndHumidity
{
    if (!_airAndHumidity) {
        _airAndHumidity = [[[NSBundle mainBundle] loadNibNamed:@"AirAndHumidity" owner:self options:nil] lastObject];
        _airAndHumidity.frame = CGRectMake(0, 150, kSCREEN_WIDTH, 40);
    }
    return _airAndHumidity;
}
//24小时天气
-(TwentyFourHoursWeather *)twentyFourHoursWeather
{
    if (!_twentyFourHoursWeather) {
        _twentyFourHoursWeather = [[TwentyFourHoursWeather alloc] initWithFrame:CGRectMake(0, 190, kSCREEN_WIDTH, 80)];
    }
    return _twentyFourHoursWeather;
}
-(HPFBaseView *)weatherAndLineView
{
    if (!_weatherAndLineView) {
        _weatherAndLineView = [[HPFBaseView alloc] initWithFrame:CGRectMake(0, 275, kSCREEN_WIDTH, 135)];
        for (int i = 0; i<5; i++) {
            WeatherAndLine *maxWeather = [[[NSBundle mainBundle] loadNibNamed:@"WeatherAndLine" owner:self options:nil] lastObject];
            maxWeather.frame = CGRectMake(self.view.bounds.size.width/5*i, 0, self.view.bounds.size.width/5, 135);
            maxWeather.tag = i+1;
            [_weatherAndLineView addSubview:maxWeather];
        }
    }
    return _weatherAndLineView;
}
-(HPFBaseView *)maxLineView
{
    if (!_maxLineView) {
        _maxLineView = [[HPFBaseView alloc] initWithFrame:CGRectMake(0, 415, kSCREEN_WIDTH, 135)];
//        _maxLineView.backgroundColor = [UIColor redColor];
        XPChartAndLineView *max = [[XPChartAndLineView alloc] initWithFrame:self.view.bounds xValueArray:self.maxAndMinLineXArray yValueArray:self.maxLineYArray yStringArray:self.maxStringYArray maxY:40 viewHeight:135 lineIsCurve:NO];
        [max showLine];
        max.backgroundColor = [UIColor clearColor];
        [_maxLineView addSubview:max];
    }
    return _maxLineView;
}
-(HPFBaseView *)minLineView
{
    if (!_minLineView) {
        _minLineView = [[HPFBaseView alloc] initWithFrame:CGRectMake(0, 555, kSCREEN_WIDTH, 135)];
//        _minLineView.backgroundColor = [UIColor yellowColor];
        XPChartAndLineView *min = [[XPChartAndLineView alloc] initWithFrame:self.view.bounds xValueArray:self.maxAndMinLineXArray yValueArray:self.minLineYArray yStringArray:self.minStringYarray maxY:40 viewHeight:135 lineIsCurve:NO];
        [min showLine];
        min.backgroundColor = [UIColor clearColor];
        [_minLineView addSubview:min];
    }
    return _minLineView;
}
-(HPFBaseView *)minWeatherView
{
    if (!_minWeatherView) {
        _minWeatherView = [[HPFBaseView alloc] initWithFrame:CGRectMake(0, 695, kSCREEN_WIDTH, 135)];
        for (int i = 0; i<5; i++) {
            MinWeather *minWeather = [[[NSBundle mainBundle] loadNibNamed:@"MinWeather" owner:self options:nil] lastObject];
            minWeather.frame = CGRectMake(self.view.bounds.size.width/5*i, 0, self.view.frame.size.width/5, 135);
            minWeather.tag = i + 1;
            [_minWeatherView addSubview:minWeather];
        }
    }
    return _minWeatherView;
}


#pragma mark- 添加视图view
-(UIScrollView *)weatherScrollView
{
    if (!_weatherScrollView) {
        _weatherScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
        _weatherScrollView.bounces = NO;
        _weatherScrollView.pagingEnabled = NO
        ;
        _weatherScrollView.contentSize = CGSizeMake(kSCREEN_WIDTH, kSCREEN_HEIGHT*1.4);
//        _weatherScrollView.backgroundColor = [UIColor clearColor];
        
        [_weatherScrollView addSubview:self.airAndHumidity];
        [_weatherScrollView addSubview:self.twentyFourHoursWeather];
        [_weatherScrollView addSubview:self.currentWeather];
        [_weatherScrollView addSubview:self.weatherAndLineView];
        [_weatherScrollView addSubview:self.maxLineView];
        [_weatherScrollView addSubview:self.minLineView];
        [_weatherScrollView addSubview:self.minWeatherView];

    }
    return _weatherScrollView;
}

#pragma mark- 创建左上的返回按钮
-(void)createNavgationLeftBarButton
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(reback)];
}
//返回方法
-(void)reback
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
