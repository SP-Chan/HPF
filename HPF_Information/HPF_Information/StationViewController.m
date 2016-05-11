//
//  StationViewController.m
//  HPF_Information
//
//  Created by XP on 16/5/9.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "StationViewController.h"
#import "StationResultViewController.h"
@interface StationViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)HPFBaseButton *selectButton;
@property(nonatomic,strong)UITextField *textFild;
@property(nonatomic,strong)UIAlertController *alert;
@end

@implementation StationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createSelectView];
}

-(void)createSelectView
{
    
    [self.view addSubview:self.textFild];
    [self.view addSubview:self.selectButton];
    
}

-(HPFBaseButton *)selectButton
{
    if (!_selectButton) {
        _selectButton = [HPFBaseButton buttonWithType:UIButtonTypeSystem];
        [_selectButton setTitle:@"查询" forState:UIControlStateNormal];
        _selectButton.frame = CGRectMake(kSCREEN_WIDTH*2/3+10+20, 10, kSCREEN_WIDTH/6, 40);
        _selectButton.backgroundColor = [UIColor redColor];
        _selectButton.layer.cornerRadius = 5;
        _selectButton.layer.masksToBounds = YES;
        [_selectButton addTarget:self action:@selector(selectBuses:) forControlEvents:UIControlEventTouchDown];
    }
    return _selectButton;
}

-(UITextField *)textFild
{
    if (!_textFild) {
        _textFild = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, kSCREEN_WIDTH*2/3, 35)];
        _textFild.layer.borderWidth = 1;
        _textFild.layer.borderColor = [UIColor blackColor].CGColor;
        _textFild.placeholder = @"请输入站名名称:";
        _textFild.delegate = self;
    }
    return _textFild;
}
#pragma mark- 查询按钮
-(void)selectBuses:(HPFBaseButton *)btn
{
//    if (_textFild.text.length > 0) {
                StationResultViewController *result = [[StationResultViewController alloc] init];
                result.busName = _textFild.text;
                [self.navigationController pushViewController:result animated:YES];
//    }else{
//        _alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请正确站名" preferredStyle:UIAlertControllerStyleAlert];
//        
//        [self presentViewController:_alert animated:YES completion:^{
//            [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(reBack) userInfo:nil repeats:NO];
//        }];
//    }
}
//返回方法
-(void)reBack
{
    [_alert dismissViewControllerAnimated:YES completion:^{
        
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
