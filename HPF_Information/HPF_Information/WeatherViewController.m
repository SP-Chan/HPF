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
@interface WeatherViewController ()
@property(nonatomic,strong)AirAndHumidity *airAndHumidity;
@property(nonatomic,strong)CurrentWeather *currentWeather;
@property(nonatomic,strong)TwentyFourHoursWeather *twentyFourHoursWeather;
@property(nonatomic,strong)UIScrollView *weatherScrollView;
@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    [self createNavgationLeftBarButton];
    [self.view addSubview:self.weatherScrollView];
}

#pragma mark- 懒加载
-(AirAndHumidity *)airAndHumidity
{
    if (!_airAndHumidity) {
        _airAndHumidity = [[[NSBundle mainBundle] loadNibNamed:@"AirAndHumidity" owner:self options:nil] lastObject];
        _airAndHumidity.frame = CGRectMake(0, 0, kSCREEN_WIDTH, 40);
    }
    return _airAndHumidity;
}
-(CurrentWeather *)currentWeather
{
    if (!_currentWeather) {
        _currentWeather = [[[NSBundle mainBundle] loadNibNamed:@"CurrentWeather" owner:self options:nil] lastObject];
        _currentWeather.frame = CGRectMake(0, 40, kSCREEN_WIDTH, 150);
    }
    return _currentWeather;
}
-(TwentyFourHoursWeather *)twentyFourHoursWeather
{
    if (!_twentyFourHoursWeather) {
        _twentyFourHoursWeather = [[TwentyFourHoursWeather alloc] initWithFrame:CGRectMake(0, 190, kSCREEN_WIDTH, 80)];
    }
    return _twentyFourHoursWeather;
}
-(UIScrollView *)weatherScrollView
{
    if (!_weatherScrollView) {
        _weatherScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
        _weatherScrollView.bounces = NO;
        _weatherScrollView.pagingEnabled = NO;
        _weatherScrollView.contentSize = CGSizeMake(_weatherScrollView.frame.size.width, _weatherScrollView.frame.size.width*1.5);
        
        [_weatherScrollView addSubview:self.airAndHumidity];
        [_weatherScrollView addSubview:self.twentyFourHoursWeather];
        [_weatherScrollView addSubview:self.currentWeather];
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
