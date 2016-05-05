//
//  WebViewController.m
//  HPF_Information
//
//  Created by 邓方 on 16/5/5.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _webV = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
    [self.view addSubview:_webV];
    NSURL *url = [NSURL URLWithString:self.news.url];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [_webV loadRequest:request];
    
    _webV.delegate = self;
    
    
    
    // Do any additional setup after loading the view.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *headerStr = @"document.getElementsByTagName('h1')[0].innerText = '测试文字';";
    [webView stringByEvaluatingJavaScriptFromString:headerStr];
    
    
//    NSString *downLoadStr = @"document.getElementById('xiazaiapp').getElementsByTagName('a')[0].innerText = '下个鸡蛋';";
//    [webView stringByEvaluatingJavaScriptFromString:downLoadStr];
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
