//
//  TripViewController.m
//  HPF_Information
//
//  Created by XP on 16/4/29.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "TripViewController.h"
#import "NetworkRequestManager.h"
#import "textViewController.h"

@interface TripViewController ()

@end

@implementation TripViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"出行";
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
    [button addTarget:self action:@selector(jump) forControlEvents:UIControlEventTouchDown];
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
}
-(void)jump
{
    textViewController *text = [[textViewController alloc] init];
    
    [self.navigationController pushViewController:text animated:YES];
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
