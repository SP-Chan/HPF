//
//  HPFBaseNavigationController.m
//  HPF_Information
//
//  Created by XP on 16/4/29.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "HPFBaseNavigationController.h"

@interface HPFBaseNavigationController ()

@end

@implementation HPFBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.translucent = NO;
//    self.tabBarController.tabBar.translucent = NO;
//    [self createNavigationController];
    //接收通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeNightTheme:) name:kChangeTheme object:nil];
    [self setNavigationControllerColor];
}
/*
#pragma mark- 创建导航控制器
-(void)createNavigationController
{
    self.navigationBarView = [[HPFBaseImageView alloc] initWithFrame:CGRectMake(0, -20, kSCREEN_WIDTH, 64)];
    [self setNavigationControllerColor];
    [self.navigationBar addSubview:self.navigationBarView];
}
*/
#pragma mark- 夜间模式设置
//从 LeftViewController 接收通知
-(void)changeNightTheme:(NSNotification *)notification
{
    //更新背景色
    [self setNavigationControllerColor];

}
//设定背景色
-(void)setNavigationControllerColor
{
  
        NSString *string = [[NSUserDefaults standardUserDefaults] stringForKey:kChangeTheme];
        if ([string isEqualToString:@"night"]) {
            self.navigationBar.barTintColor = [UIColor colorWithRed:81/255.0 green:77/255.0 blue:77/255.0 alpha:1];
        }else if ([string isEqualToString:@"深绯"]){
            self.navigationBar.barTintColor = [UIColor colorWithRed:200/255.0 green:22/255.0 blue:29/255.0 alpha:1];
        }else if ([string isEqualToString:@"尼罗蓝"]){
            self.navigationBar.barTintColor = [UIColor colorWithRed:82/255.0 green:170/255.0 blue:193/255.0 alpha:1];
        }else if ([string isEqualToString:@"热带橙"]){
            self.navigationBar.barTintColor = [UIColor colorWithRed:243/255.0 green:152/255.0 blue:57/255.0 alpha:1];
        }else if ([string isEqualToString:@"月亮黄"]){
            self.navigationBar.barTintColor = [UIColor colorWithRed:255/255.0 green:237/255.0 blue:97/255.0 alpha:1];
        }else if ([string isEqualToString:@"草坪色"]){
            self.navigationBar.barTintColor = [UIColor colorWithRed:189/255.0 green:203/255.0 blue:77/255.0 alpha:1];
        }else{
            self.navigationBar.barTintColor = [UIColor colorWithRed:146/255.0 green:115/255.0 blue:173/255.0 alpha:1];
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
