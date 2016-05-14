//
//  SettingViewController.m
//  HPF_Information
//
//  Created by XP on 16/5/3.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "SettingViewController.h"
#import "StatementViewController.h"
#import "VersionViewController.h"
#import "ThemeViewController.h"
@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor redColor];
    self.navigationItem.title = @"设置";
    [self createUI];
    [self createNavigationLeftView];
}
-(void)createNavigationLeftView
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(reback)];
    
}
-(void)createUI
{
    [self createCenterCircle];
    [self createBottomButtonFirest];
//    [self createBottomButtonSecond];
    [self createBottomButtonThird];
    [self createBottomButtonForth];
}
-(void)createCenterCircle
{
    HPFBaseImageView *centerCircle = [[HPFBaseImageView alloc] initWithFrame:CGRectMake((kSCREEN_WIDTH-150)/2, kSCREEN_HEIGHT/10, 150, 150)];
    centerCircle.backgroundColor = [UIColor yellowColor];
    centerCircle.layer.cornerRadius = 70;
    centerCircle.layer.masksToBounds = YES;
    [self.view addSubview:centerCircle];
}
-(void)createBottomButtonFirest
{
    HPFBaseButton *button = [HPFBaseButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(20, kSCREEN_HEIGHT/2+50*kSCREEN_HEIGHT/667, kSCREEN_WIDTH-40, 35*kSCREEN_HEIGHT/667);
    button.layer.cornerRadius = 10;
    button.layer.masksToBounds = YES;
    [button setTitle:@"声明" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(jumpStatement:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
//-(void)createBottomButtonSecond
//{
//    HPFBaseButton *button = [HPFBaseButton buttonWithType:UIButtonTypeSystem];
//    button.frame = CGRectMake(20, kSCREEN_HEIGHT/2+50*kSCREEN_HEIGHT/667, kSCREEN_WIDTH-40, 35*kSCREEN_HEIGHT/667);
//    button.layer.cornerRadius = 10;
//    button.layer.masksToBounds = YES;
//    [button setTitle:@"清除缓存" forState:UIControlStateNormal];
//    button.backgroundColor = [UIColor redColor];
//    [self.view addSubview:button];
//}
-(void)createBottomButtonThird
{
    HPFBaseButton *button = [HPFBaseButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(20, kSCREEN_HEIGHT/2+100*kSCREEN_HEIGHT/667, kSCREEN_WIDTH-40, 35*kSCREEN_HEIGHT/667);
    button.layer.cornerRadius = 10;
    button.layer.masksToBounds = YES;
    [button setTitle:@"切换风格" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(jumpTheme:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
}
-(void)createBottomButtonForth
{
    HPFBaseButton *button = [HPFBaseButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(20, kSCREEN_HEIGHT/2+150*kSCREEN_HEIGHT/667, kSCREEN_WIDTH-40, 35*kSCREEN_HEIGHT/667);
    button.layer.cornerRadius = 10;
    button.layer.masksToBounds = YES;
    [button setTitle:@"版本内容" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(jumpVersion:) forControlEvents:UIControlEventTouchDown];
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
}
#pragma mark- 切换风格
-(void)jumpTheme:(HPFBaseButton *)button
{
    ThemeViewController *theme = [[ThemeViewController alloc] init];
    [self.navigationController pushViewController:theme animated:YES];
}
#pragma mark- 当前版本
-(void)jumpVersion:(HPFBaseButton *)button
{
    VersionViewController *version = [[VersionViewController alloc] init];
    [self.navigationController pushViewController:version animated:YES];
}
#pragma mark- 声明
-(void)jumpStatement:(HPFBaseButton *)button
{
    StatementViewController *statement = [[StatementViewController alloc] init];
    [self.navigationController pushViewController:statement animated:YES];
}
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
