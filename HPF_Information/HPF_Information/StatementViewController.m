//
//  StatementViewController.m
//  HPF_Information
//
//  Created by XP on 16/5/14.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "StatementViewController.h"

@interface StatementViewController ()

@end

@implementation StatementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"声明";
    self.view.backgroundColor = [UIColor brownColor];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT-64)];
    imageView.image = [UIImage imageNamed:@"banquanshegnming.png"];
    [self.view addSubview:imageView];
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
