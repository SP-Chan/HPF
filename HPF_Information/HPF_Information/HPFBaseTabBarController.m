//
//  HPFBaseTabBarController.m
//  HPF_Information
//
//  Created by XP on 16/4/29.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "HPFBaseTabBarController.h"
#import "NewsViewController.h"
#import "TripViewController.h"
#import "AlmanacViewController.h"
#import "VideoViewController.h"
#import "HPFBaseNavigationController.h"

@interface HPFBaseTabBarController ()
@property(nonatomic,strong)NewsViewController *news;
@property(nonatomic,strong)TripViewController *trip;
@property(nonatomic,strong)AlmanacViewController *almanac;
@property(nonatomic,strong)VideoViewController *video;
@property(nonatomic,strong)HPFBaseView *tabBarView;
@property(nonatomic,strong)HPFBaseImageView *tabBarBackgroundImageView;
@end

@implementation HPFBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTabBarSubControllers];
    [self createTabBar];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeNightTheme:) name:kChangeTheme object:nil];
}
#pragma mark- 添加子控制器
-(void)addTabBarSubControllers
{
    _news = [[NewsViewController alloc] init];
    HPFBaseNavigationController *navNews = [[HPFBaseNavigationController alloc] initWithRootViewController:_news];
    navNews.navigationBar.translucent = NO;
    
    _trip = [[TripViewController alloc] init];
    HPFBaseNavigationController *navTrip = [[HPFBaseNavigationController alloc] initWithRootViewController:_trip];
    navTrip.navigationBar.translucent = NO;
    
    _almanac = [[AlmanacViewController alloc] init];
    HPFBaseNavigationController *navAlmanac = [[HPFBaseNavigationController alloc] initWithRootViewController:_almanac];
    navAlmanac.navigationBar.translucent = NO;
    
    _video = [[VideoViewController alloc] init];
    HPFBaseNavigationController *navVideo = [[HPFBaseNavigationController alloc] initWithRootViewController:_video];
    navVideo.navigationBar.translucent = NO;
    
    self.viewControllers = @[navNews,navAlmanac,navVideo,navTrip];
    self.tabBar.translucent = NO;
}
#pragma mark- 创建底部的自定义tabBar
-(void)createTabBar
{
    self.tabBarView = [[HPFBaseView alloc] initWithFrame:CGRectMake(0, kSCREEN_HEIGHT-49, kSCREEN_WIDTH, 49)];
    _tabBarBackgroundImageView = [[HPFBaseImageView alloc] initWithFrame:self.tabBarView.bounds];
//    _tabBarBackgroundImageView.backgroundColor = [UIColor yellowColor];
    [self setTabBarBackgroundImageColor];
    [self.tabBarView addSubview:_tabBarBackgroundImageView];
    
    [self.view addSubview:self.tabBarView];
    [self createTabBarButton];
}
#pragma mark- 夜间模式设置
//从 LeftViewController 接收通知
-(void)changeNightTheme:(NSNotification *)notification
{
    //更新背景色
    [self setTabBarBackgroundImageColor];

}
//设定底部tabbar背景色
-(void)setTabBarBackgroundImageColor
{
    NSString *string = [[NSUserDefaults standardUserDefaults] stringForKey:kChangeTheme];
    if ([string isEqualToString:@"night"]) {
        _tabBarBackgroundImageView.backgroundColor = [UIColor colorWithRed:81/255.0 green:77/255.0 blue:77/255.0 alpha:1];
    }else if ([string isEqualToString:@"深绯"]){
        _tabBarBackgroundImageView.backgroundColor = [UIColor colorWithRed:200/255.0 green:22/255.0 blue:29/255.0 alpha:1];
    }else if ([string isEqualToString:@"尼罗蓝"]){
        _tabBarBackgroundImageView.backgroundColor = [UIColor colorWithRed:82/255.0 green:170/255.0 blue:193/255.0 alpha:1];
    }else if ([string isEqualToString:@"热带橙"]){
        _tabBarBackgroundImageView.backgroundColor = [UIColor colorWithRed:243/255.0 green:152/255.0 blue:57/255.0 alpha:1];
    }else if ([string isEqualToString:@"月亮黄"]){
       _tabBarBackgroundImageView.backgroundColor = [UIColor colorWithRed:255/255.0 green:237/255.0 blue:97/255.0 alpha:1];
    }else if ([string isEqualToString:@"草坪色"]){
       _tabBarBackgroundImageView.backgroundColor = [UIColor colorWithRed:189/255.0 green:203/255.0 blue:77/255.0 alpha:1];
    }else{
        _tabBarBackgroundImageView.backgroundColor = [UIColor colorWithRed:146/255.0 green:115/255.0 blue:173/255.0 alpha:1];
    }
 }


//创建底部tabBar的Button
-(void)createTabBarButton
{
    NSArray *imageArray = [NSArray arrayWithObjects:@"news.png",@"almanac.png",@"video.png",@"trip.png" ,nil];
    NSArray *titleArray = [NSArray arrayWithObjects:@"新闻",@"黄历",@"视频",@"出行", nil];
    for (int i = 0; i<imageArray.count; i++) {
        HPFBaseButton *button = [HPFBaseButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((kSCREEN_WIDTH/4-40)/2+(kSCREEN_WIDTH/4)*i, (self.tabBarView.bounds.size.height-40)/2, 40, 40);
        button.tag = i + 1;
        //tabbar的图片
        [button setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        [button setImageEdgeInsets:UIEdgeInsetsMake(-15, 0, 0, 0)];
        //tabbar的标题
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:10];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -35, -30, 0)];
        [button addTarget:self action:@selector(changeController:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabBarView addSubview:button];
        
    }
}
-(void)changeController:(HPFBaseButton *)button
{
    if (button.tag == 1) {
        self.selectedViewController = self.viewControllers[0];
    }else if (button.tag == 2){
        self.selectedViewController = self.viewControllers[1];
    }else if (button.tag == 3){
        self.selectedViewController = self.viewControllers[2];
    }else{
        self.selectedViewController = self.viewControllers[3];
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
