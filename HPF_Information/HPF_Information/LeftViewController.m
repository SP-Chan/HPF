//
//  LeftViewController.m
//  HPF_Information
//
//  Created by XP on 16/4/29.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "LeftViewController.h"
#import "LeftViewTop.h"
#import "WeatherAndCity.h"
#import "HPFBaseNavigationController.h"
#import "SettingViewController.h"
#import "WeatherViewController.h"
@interface LeftViewController ()
@property(nonatomic,strong)LeftViewTop *topView;
@property(nonatomic,strong)HPFBaseButton *setButton;
@property(nonatomic,strong)HPFBaseButton *nightThemeButton;
@property(nonatomic,strong)WeatherAndCity *weatherAndCity;
@property(nonatomic,strong)HPFBaseImageView *imageV;
@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createBackgroundView];
    [self createLazyButton];
    [self createMiddleButton];
}

//创建背景图片
-(void)createBackgroundView
{
    self.view.backgroundColor = [UIColor brownColor];
    _imageV = [[HPFBaseImageView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
   
    [self.view insertSubview:_imageV atIndex:0];
 
}
//处理懒加载的button
-(void)createLazyButton
{
    [self.view addSubview:self.topView];
    [self.view addSubview:self.setButton];
    [self.view addSubview:self.nightThemeButton];
    [self.view addSubview:self.weatherAndCity];
}
//创建中间的Button
-(void)createMiddleButton
{
    NSArray *array = [NSArray arrayWithObjects:@"关于我们",@"关于我们",@"关于我们",@"清除缓存",@"关于我们", nil];
    for (int i = 0 ; i<5; i++) {
        HPFBaseButton *button = [HPFBaseButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 150+kSCREEN_HEIGHT/11*i, kSCREEN_WIDTH*2/3, kSCREEN_HEIGHT/11);
        button.tag = i + 1;
//        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -button.bounds.size.width*1/5, 0, 0)];
        [button setImage:[UIImage imageNamed:@"drawer.png"] forState:UIControlStateNormal];
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, -button.bounds.size.width*2/5, 0, 0)];
        [self.view addSubview:button];
    }
}
#pragma mark- 懒加载
//懒加载顶部View
-(LeftViewTop *)topView
{
    if (!_topView) {
        _topView = [[[NSBundle mainBundle] loadNibNamed:@"LeftViewTop" owner:nil options:nil] lastObject];
        _topView.frame = CGRectMake(0, 30, kSCREEN_WIDTH*2/3, 100);
        _topView.backgroundColor = [UIColor clearColor];
    }
    return _topView;
}

//懒加载底部的的设置按钮
-(HPFBaseButton *)setButton
{
    if (!_setButton) {
        _setButton = [HPFBaseButton buttonWithType:UIButtonTypeCustom];
        _setButton.frame = CGRectMake(10, kSCREEN_HEIGHT-30-10, kSCREEN_WIDTH/6, 30);
        [_setButton setTitle:@"设置" forState:UIControlStateNormal];
        _setButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_setButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -8)];
//        _setButton.backgroundColor = [UIColor redColor];
        [_setButton setImage:[UIImage imageNamed:@"set.png"] forState:UIControlStateNormal];
        [_setButton setImageEdgeInsets:UIEdgeInsetsMake(0, -8, 0, 0)];
        [_setButton addTarget:self action:@selector(skipToSettingViewController:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _setButton;
}
//懒加载底部的夜间模式
-(HPFBaseButton *)nightThemeButton
{
    if (!_nightThemeButton) {
        _nightThemeButton = [HPFBaseButton buttonWithType:UIButtonTypeCustom];
        _nightThemeButton.frame = CGRectMake(10+kSCREEN_WIDTH/6+15, kSCREEN_HEIGHT-30-10, kSCREEN_WIDTH*2/9, 30);
        //设置Button样式
        [self setButtonStyleAndImageViewImage];
//        [_nightThemeButton setTitle:@"夜间模式" forState:UIControlStateNormal];
        _nightThemeButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_nightThemeButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -8)];
//        _nightThemeButton.backgroundColor = [UIColor redColor];
//        [_nightThemeButton setImage:[UIImage imageNamed:@"night.png"] forState:UIControlStateNormal];
        
        [_nightThemeButton addTarget:self action:@selector(changeNightTheme) forControlEvents:UIControlEventTouchUpInside];
        [_nightThemeButton setImageEdgeInsets:UIEdgeInsetsMake(0, -8, 0, 0)];
    }
    return _nightThemeButton;
}
//懒加载底部的天气
-(WeatherAndCity *)weatherAndCity
{
    if (!_weatherAndCity) {
        _weatherAndCity = [[[NSBundle mainBundle] loadNibNamed:@"WeatherAndCity" owner:nil options:nil] lastObject];
        _weatherAndCity.frame = CGRectMake(kSCREEN_WIDTH*2/3-kSCREEN_WIDTH/6-5, kSCREEN_HEIGHT-60-5, kSCREEN_WIDTH/6, kSCREEN_WIDTH/6);
        _weatherAndCity.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Weather:)];
        [_weatherAndCity addGestureRecognizer:tap];
    }
    return _weatherAndCity;
}
#pragma mark- 按钮方法
//天气按钮
-(void)Weather:(UITapGestureRecognizer *)tap
{
    WeatherViewController *weather = [[WeatherViewController alloc] init];
    HPFBaseNavigationController *navWeather = [[HPFBaseNavigationController alloc] initWithRootViewController:weather];
    navWeather.modalPresentationStyle = UIModalTransitionStylePartialCurl;
    [self.view.window.rootViewController presentViewController:navWeather animated:YES completion:^{
        
    }];
    NSLog(@"111");
}
//设置按钮
-(void)skipToSettingViewController:(HPFBaseButton *)button
{
    SettingViewController *setting = [[SettingViewController alloc] init];
    HPFBaseNavigationController *navSetting = [[HPFBaseNavigationController alloc] initWithRootViewController:setting];
    navSetting.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.view.window.rootViewController presentViewController:navSetting animated:YES completion:^{
        
    }];
    
}
#pragma mark- 夜间模式设置
//切换夜间模式
-(void)changeNightTheme
{
    NSString *string = [[NSUserDefaults standardUserDefaults] stringForKey:kChangeTheme];
    if ([string isEqualToString:@"night"]) {
        //发送通知到 HPFBaseViewController HPFBaseNavigationController HPFBaseTabBarController
        [[NSNotificationCenter defaultCenter] postNotificationName:kChangeTheme object:nil userInfo:nil];
        [[NSUserDefaults standardUserDefaults] setObject:@"white" forKey:kChangeTheme];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self setButtonStyleAndImageViewImage];
    }else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kChangeTheme object:nil userInfo:nil];
        [[NSUserDefaults standardUserDefaults] setObject:@"night" forKey:kChangeTheme];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self setButtonStyleAndImageViewImage];
    }
}
//改变夜间模式按钮的样式
-(void)setButtonStyleAndImageViewImage
{
    NSString *string = [[NSUserDefaults standardUserDefaults] stringForKey:kChangeTheme];
    if ([string isEqualToString:@"night"]) {
        [_nightThemeButton setImage:[UIImage imageNamed:@"sun.png"] forState:UIControlStateNormal];
        [_nightThemeButton setTitle:@"日间模式" forState:UIControlStateNormal];
         _imageV.image = [UIImage imageNamed:@"nightBackgroundView.jpg"];
    }else
    {
        [_nightThemeButton setImage:[UIImage imageNamed:@"night.png"] forState:UIControlStateNormal];
        [_nightThemeButton setTitle:@"夜间模式" forState:UIControlStateNormal];
         _imageV.image = [UIImage imageNamed:@"LeftViewBackground.jpg"];
    }
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
