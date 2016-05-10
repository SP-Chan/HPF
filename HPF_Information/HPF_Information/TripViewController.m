//
//  TripViewController.m
//  HPF_Information
//
//  Created by XP on 16/4/29.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "TripViewController.h"
#import "NetworkRequestManager.h"
#import "QueryViewController.h"
#import "LineViewController.h"
#import "StationViewController.h"
@interface TripViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *transportScrollView;
@property(nonatomic,strong)NSMutableArray *buttonArray;
@property(nonatomic,strong)NSMutableArray *titleArray;
@property(nonatomic,strong)HPFBaseView *topBackgroundView;
@property(nonatomic,strong)QueryViewController *query;
@end

@implementation TripViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"实时公交";
    [self createUI];
    self.tabBarController.tabBar.hidden = YES;
//    self.hidesBottomBarWhenPushed = YES;
}
-(void)createUI
{
    [self.view addSubview:self.topBackgroundView];
    [self.view addSubview:self.transportScrollView];
    
}

-(UIScrollView *)transportScrollView
{
    if (!_transportScrollView) {
        _transportScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, kSCREEN_WIDTH, kSCREEN_HEIGHT-50)];
        _transportScrollView.backgroundColor = [UIColor grayColor];
        
        _query = [[QueryViewController alloc] init];
        LineViewController *line = [[LineViewController alloc] init];
        StationViewController *station = [[StationViewController alloc] init];
        [self addChildViewController:_query];
        [self addChildViewController:line];
        [self addChildViewController:station];
        
        for (int i = 0; i < self.childViewControllers.count; i++) {
            HPFBaseViewController *viewControll = self.childViewControllers[i];
            viewControll.view.frame = CGRectMake(self.transportScrollView.frame.size.width*i, 0, self.transportScrollView.frame.size.width, self.transportScrollView.frame.size.height-50);
            [_transportScrollView addSubview:viewControll.view];

        }
        _transportScrollView.contentSize = CGSizeMake(self.transportScrollView.frame.size.width*0, self.transportScrollView.frame.size.height-50);
        _transportScrollView.pagingEnabled = YES;
        _transportScrollView.bounces = NO;
        _transportScrollView.delegate = self;
        
    }
    return _transportScrollView;
}
-(NSMutableArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = [NSMutableArray arrayWithObjects:@"实时公交",@"公交线路",@"公交站查询", nil];
    }
    return _titleArray;
}
-(HPFBaseView *)topBackgroundView
{
    if (!_topBackgroundView) {
        _topBackgroundView = [[HPFBaseView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 50)];
        _topBackgroundView.backgroundColor = [UIColor redColor];
        _topBackgroundView.layer.cornerRadius = 5;
        _topBackgroundView.layer.masksToBounds = YES;
        for(int i = 0; i<3; i++) {
            HPFBaseButton *button = [HPFBaseButton buttonWithType:UIButtonTypeCustom];
            button.tag = i;
            button.frame = CGRectMake((i+1)*5+(kSCREEN_WIDTH-20)/3*i, 5, (kSCREEN_WIDTH-20)/3, 40);
            button.backgroundColor = [UIColor yellowColor];
            [_topBackgroundView addSubview:button];
            [button addTarget:self action:@selector(changeController:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitle:self.titleArray[i] forState:UIControlStateNormal];
            if (i == 0) {
                [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:20];
                
            }else
            {
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:16];
            }
            [self.buttonArray addObject:button];
        }

    }
    return _topBackgroundView;
}
-(NSMutableArray *)buttonArray
{
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

-(void)changeController:(HPFBaseButton *)btn
{
    for (int i = 0; i<3; i++) {
        if (btn.tag == i) {
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:20];
            self.navigationItem.title = btn.titleLabel.text;
            self.transportScrollView.contentOffset = CGPointMake(kSCREEN_WIDTH*i, 0);
        }else
        {
            //还原被点击的字体颜色
            UIButton *button = [self.buttonArray objectAtIndex:i];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:16];
          
         
        }

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
