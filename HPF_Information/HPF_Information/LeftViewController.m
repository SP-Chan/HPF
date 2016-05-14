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

#import "AnswerViewController.h"

#import "SDImageCache.h"
#import "SDWebImageManager.h"


@interface LeftViewController ()
@property(nonatomic,strong)LeftViewTop *topView;
@property(nonatomic,strong)HPFBaseButton *setButton;
@property(nonatomic,strong)HPFBaseButton *nightThemeButton;
@property(nonatomic,strong)WeatherAndCity *weatherAndCity;
@property(nonatomic,strong)HPFBaseImageView *imageV;
@property(nonatomic,strong)NSMutableArray *buttonArray;
@property(nonatomic,strong)UIAlertController *alert;
@property(nonatomic,strong)UIAlertController *alertMe;
@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setImageViewImage) name:kChangeTheme object:nil];
    [self createBackgroundView];
    [self createLazyButton];
    [self createMiddleButton];
}

//创建背景图片
-(void)createBackgroundView
{
    self.view.backgroundColor = [UIColor brownColor];
    _imageV = [[HPFBaseImageView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
    _imageV.alpha = 0.4;
    [self setImageViewImage];
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
    NSArray *array = [NSArray arrayWithObjects:@"疑难解答",@"检查更新",@"意见反馈",@"清除缓存",@"关于我们", nil];
    for (int i = 0 ; i<5; i++) {
        HPFBaseButton *button = [HPFBaseButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 200+kSCREEN_HEIGHT/11*i, kSCREEN_WIDTH*2/3, kSCREEN_HEIGHT/11);
        button.tag = i;
//        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -button.bounds.size.width*1/5, 0, 0)];
        [button setImage:[UIImage imageNamed:@"drawer.png"] forState:UIControlStateNormal];
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, -button.bounds.size.width*2/5, 0, 0)];
        [button addTarget:self action:@selector(leftViewButtonMethod:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonArray addObject:button];
        [self.view addSubview:button];
        
        if ([button.titleLabel.text isEqualToString:@"清除缓存"]) {
            [button addTarget:self action:@selector(clearCache:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        
        
        
    }
}
-(void)leftViewButtonMethod:(UIButton *)button
{
    if (button.tag == 0) {//疑难解答
        
        AnswerViewController *answer = [[AnswerViewController alloc] init];
        HPFBaseNavigationController *navAnswer = [[HPFBaseNavigationController alloc] initWithRootViewController:answer];
        [self presentViewController:navAnswer animated:YES completion:^{
            
        }];
        
    }else if (button.tag == 1)//检查更新
    {
        _alert = [UIAlertController alertControllerWithTitle:@"版本信息" message:@"感谢客官支持,您使用的已经是当前的最新版本" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:_alert animated:YES completion:^{
            [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(reBack) userInfo:nil repeats:NO];
        }];
         
    }else if (button.tag == 2)//意见反馈
    {
        
        
        
    }else if (button.tag == 3)//清除缓存
    {
        
    }else//关于我们
    {
        _alertMe = [UIAlertController alertControllerWithTitle:@"关于我们" message:@"黄辉(HH)\n邓方(DF)\n陈少平(XP)" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [_alertMe dismissViewControllerAnimated:YES completion:^{
                
            }];
        }];
        [_alertMe addAction:action];
        [self presentViewController:_alertMe animated:YES completion:^{
        }];
    }
}
-(void)reBack
{
    [_alert dismissViewControllerAnimated:YES completion:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark- 懒加载
-(NSMutableArray *)buttonArray
{
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}
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


-(void)clearCache:(UIButton *)button
{
    {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
        
        NSEnumerator *imageFilesEnumerator = [[fileManager subpathsAtPath:cachePath] objectEnumerator];
        long long Size = 0;
        NSString* fileName;
        while ((fileName = [imageFilesEnumerator nextObject]) != nil){
            NSString* fileAbsolutePath = [cachePath stringByAppendingPathComponent:fileName];
            Size += [[fileManager attributesOfItemAtPath:fileAbsolutePath error:nil] fileSize];
        }
        
        
        NSString *cacheSize = [NSString stringWithFormat:@"缓存大小为%lldM\n是否清除?",Size/ 1024000 ];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:cacheSize preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[SDImageCache sharedImageCache]clearDisk];
            [[SDWebImageManager sharedManager].imageCache clearMemory];
            [fileManager removeItemAtPath:cachePath error:nil];
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:action];
        [alertController addAction:action2];
        
        [self presentViewController:alertController animated:YES completion:NULL];
        
        
    }

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
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCityName:) name:kLocationCity object:nil];
        NSString *string = [[NSUserDefaults standardUserDefaults] stringForKey:kLocationCity];
        if (string.length>0) {
            _weatherAndCity.cityLabel.text = string;
        }else{
            _weatherAndCity.cityLabel.text = @"广州";
        }
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeWeather:) name:kCurrentWeather object:nil];
        NSString *weatherString = [[NSUserDefaults standardUserDefaults] stringForKey:kCurrentWeather];
        if (weatherString.length>0) {
            _weatherAndCity.weatherLabel.text = [NSString stringWithFormat:@"%@°",weatherString];
        }else{
            _weatherAndCity.weatherLabel.text = @"26°";
        }

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Weather:)];
        [_weatherAndCity addGestureRecognizer:tap];
    }
    return _weatherAndCity;
}
-(void)changeCityName:(NSNotification *)notification
{
    NSString *string = [[NSUserDefaults standardUserDefaults] stringForKey:kLocationCity];
    if (string.length>0) {
        self.weatherAndCity.cityLabel.text = string;
    }else{
        self.weatherAndCity.cityLabel.text = @"广州";
    }
}
-(void)changeWeather:(NSNotification *)notification
{
    NSString *weatherString = [[NSUserDefaults standardUserDefaults] stringForKey:kCurrentWeather];
    if (weatherString.length>0) {
        _weatherAndCity.weatherLabel.text = [NSString stringWithFormat:@"%@°",weatherString];
    }else{
        _weatherAndCity.weatherLabel.text = @"26°";
    }
}
#pragma mark- 按钮方法
//天气按钮
-(void)Weather:(UITapGestureRecognizer *)tap
{
//    NSString *string = [[NSUserDefaults standardUserDefaults] stringForKey:kLocationCity];
    WeatherViewController *weather = [[WeatherViewController alloc] init];
//    if (string.length>0) {
//        weather.city = string;
//    }else{
//        weather.city = @"广州";
//    }
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

        [[NSUserDefaults standardUserDefaults] setObject:@"white" forKey:kChangeTheme];

        [[NSNotificationCenter defaultCenter] postNotificationName:kChangeTheme object:nil userInfo:nil];

        
        [[NSUserDefaults standardUserDefaults] setObject:@"white" forKey:kChangeTheme];
        [[NSNotificationCenter defaultCenter] postNotificationName:kChangeTheme object:nil userInfo:nil];
        
        [[NSUserDefaults standardUserDefaults] synchronize];

        [self setButtonStyleAndImageViewImage];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }else
    {

        [[NSUserDefaults standardUserDefaults] setObject:@"night" forKey:kChangeTheme];
        [[NSNotificationCenter defaultCenter] postNotificationName:kChangeTheme object:nil userInfo:nil];

        
        [[NSUserDefaults standardUserDefaults] setObject:@"night" forKey:kChangeTheme];
        [[NSNotificationCenter defaultCenter] postNotificationName:kChangeTheme object:nil userInfo:nil];
        
        [[NSUserDefaults standardUserDefaults] synchronize];

        [self setButtonStyleAndImageViewImage];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
//改变夜间模式按钮的样式
-(void)setButtonStyleAndImageViewImage
{
    NSString *string = [[NSUserDefaults standardUserDefaults] stringForKey:kChangeTheme];
    if ([string isEqualToString:@"night"]) {
        [_nightThemeButton setImage:[UIImage imageNamed:@"sun.png"] forState:UIControlStateNormal];
        [_nightThemeButton setTitle:@"日间模式" forState:UIControlStateNormal];
//         _imageV.image = [UIImage imageNamed:@"nightBackgroundView.jpg"];
    }else
    {
        [_nightThemeButton setImage:[UIImage imageNamed:@"night.png"] forState:UIControlStateNormal];
        [_nightThemeButton setTitle:@"夜间模式" forState:UIControlStateNormal];
//         _imageV.image = [UIImage imageNamed:@"LeftViewBackground.jpg"];
    }
}
-(void)setImageViewImage
{
    NSString *string = [[NSUserDefaults standardUserDefaults] stringForKey:kChangeTheme];
    if ([string isEqualToString:@"night"]) {
        _imageV.image = [UIImage imageNamed:@"nightBackgroundView.jpg"];
    }else if ([string isEqualToString:@"深绯"]){
        _imageV.image = [UIImage imageNamed:@"red.jpg"];
    }else if ([string isEqualToString:@"尼罗蓝"]){
        _imageV.image = [UIImage imageNamed:@"blue.jpg"];
    }else if ([string isEqualToString:@"热带橙"]){
        _imageV.image = [UIImage imageNamed:@"orange.jpg"];
    }else if ([string isEqualToString:@"月亮黄"]){
        _imageV.image = [UIImage imageNamed:@"yellow.jpg"];
    }else if ([string isEqualToString:@"草坪色"]){
        _imageV.image = [UIImage imageNamed:@"green.jpg"];
    }else
    {
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
