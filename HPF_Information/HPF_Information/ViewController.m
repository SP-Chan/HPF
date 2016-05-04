//
//  ViewController.m
//  HPF_Information
//
//  Created by XP on 16/4/29.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "ViewController.h"
#import "LeftViewController.h"
#import "HPFBaseTabBarController.h"
#import "TimeSelector.h"
@interface ViewController ()
@property(nonatomic,strong)HPFBaseTabBarController *hpfTabBar;
@property(nonatomic,strong)LeftViewController *left;
@property(nonatomic,strong)UIPanGestureRecognizer *panG;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showLeftView:) name:@"showLeftView" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hidden:) name:@"hiddenLeftView" object:nil];
    [self createSubView];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(time:) name:@"TimeSelector" object:nil];

}
-(void)time:(NSNotification *)time
{
    TimeSelector *timeS = [[TimeSelector alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
    
    [self.tabBarController.view bringSubviewToFront:timeS];
    //
    timeS.backgroundColor= [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:0.4];
    
    [self.view addSubview:timeS];
    
}


#pragma mark- 收到通知 推出左视图
-(void)showLeftView:(NSNotification *)nsnotification
{
    _left = [[LeftViewController alloc] init];
    [self.view insertSubview:_left.view atIndex:0];
    [UIView animateWithDuration:0.5 animations:^{
         _hpfTabBar.view.frame = CGRectMake(kSCREEN_WIDTH*2/3, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
    }];
   
    
    _panG = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenLeftView:)];
    [_hpfTabBar.view addGestureRecognizer:_panG];
    _panG.enabled = YES;
}
#pragma mark- 手势隐藏左视图方法
-(void)hiddenLeftView:(UIPanGestureRecognizer *)pan
{
    UIView *view = (UIView *)pan.view;
    CGPoint point = [pan translationInView:view];
    //    NSLog(@"%f",point.x);
    //设置当前可拖拽范围
    if (point.x > 0) {
        if (view.frame.origin.x<kSCREEN_WIDTH*2/3) {
            view.transform = CGAffineTransformTranslate(view.transform, point.x, 0);
            [pan setTranslation:CGPointZero inView:view];
        }else{
        }
    }
    else
    {
        view.transform = CGAffineTransformTranslate(view.transform, point.x, 0);
        [pan setTranslation:CGPointZero inView:view];
        
    }
    //判断拖拽结束后的位置
    if (pan.state == UIGestureRecognizerStateEnded) {
        if (view.frame.origin.x<kSCREEN_WIDTH/3) {
            [UIView animateWithDuration:0.5 animations:^{
                view.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
                
            } completion:^(BOOL finished) {
                //移除手势,视图,发送重现左上角按钮的通知
                [view removeGestureRecognizer:pan];
                [_left.view removeFromSuperview];
                //发送通知到 NewsViewController 改变isShowLeftView
                [[NSNotificationCenter defaultCenter] postNotificationName:@"changeIsShowLeftView" object:nil];
            }];
        }else
        {
            //返回原来的位置
            [UIView animateWithDuration:0.5 animations:^{
                view.frame = CGRectMake(kSCREEN_WIDTH*2/3, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
            }];
        }
    }
}
#pragma mark- 点击隐藏左视图
-(void)hidden:(NSNotification *)notification
{
    [UIView animateWithDuration:0.5 animations:^{
        _hpfTabBar.view.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
        
    } completion:^(BOOL finished) {
        //移除手势,视图,发送重现左上角按钮的通知
        [_hpfTabBar.view removeGestureRecognizer:_panG];
        [_left.view removeFromSuperview];
    }];
}

#pragma mark- 创建子视图
-(void)createSubView
{
    _hpfTabBar = [[HPFBaseTabBarController alloc] init];
    [self addChildViewController:_hpfTabBar];
    [self.view addSubview:_hpfTabBar.view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
