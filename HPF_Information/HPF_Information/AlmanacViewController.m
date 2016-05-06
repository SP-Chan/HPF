//
//  AlmanacViewController.m
//  HPF_Information
//
//  Created by XP on 16/4/29.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "AlmanacViewController.h"
#import "UIImageView+WebCache.h"

#import "AlmanacContentThree.h"
#import "AlmanacContentTwo.h"
#import "AlmanacImage.h"
#import "AlmanacContentOne.h"
@interface AlmanacViewController ()
@property(nonatomic,strong)UIScrollView *scrollView;
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
        self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
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
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self SetMainInterface];
    [self setTimeTitle];
    

    
    
    
}

-(void)SetMainInterface
{

    AlmanacImage *imageV = [[AlmanacImage alloc]init];;
    imageV.frame =CGRectMake(0, 0, kSCREEN_WIDTH, 200);
    
    NSURL *url = [NSURL URLWithString:@"http://img4.tiboo.cn/1008/481757_12823573491.jpg"];
//    
    [self.scrollView addSubview:imageV];
    [imageV.imageV sd_setImageWithURL:url];
    
    AlmanacContentThree *three = [[AlmanacContentThree alloc]init];
    three.frame = CGRectMake(4, 200, kSCREEN_WIDTH-8, 60);
  
    [self.scrollView addSubview:three];
    
    AlmanacContentTwo *ContentTwo = [[AlmanacContentTwo alloc]init];;
  
    ContentTwo.frame = CGRectMake(4, 264, kSCREEN_WIDTH-8,120);
    [self.scrollView addSubview:ContentTwo];
   
    

    
    AlmanacContentOne *one  = [[AlmanacContentOne alloc]initWithFrame:CGRectMake(4, 390, kSCREEN_WIDTH-8, 140)];
    
    [self.scrollView addSubview:one];
    
    
    
}

-(void)timeActiom:(NSNotification *)notification
{
    NSDictionary *dic = notification.userInfo;
    
    NSLog(@"%@",[dic objectForKey:@"year"]);
    
}
-(void)setTimeTitle
{

    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY年MM月"];
    
    NSString *  today=[dateformatter stringFromDate:senddate];
    
    [dateformatter setDateFormat:@"EEEE"];
    NSString *Week = [dateformatter stringFromDate:senddate];
   
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = CGRectMake(kSCREEN_WIDTH/3, 20, kSCREEN_WIDTH/3, 24);
    [self.navigationController.view addSubview:button];
    [button setTitle:today forState:UIControlStateNormal];
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
