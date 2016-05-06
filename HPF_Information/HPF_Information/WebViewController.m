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


/*
#pragma mark - ******************** 拼接html语言
- (void)showInWebView
{
    
    NSMutableString *html = [NSMutableString string];
    [html appendString:@"<html>"];
    [html appendString:@"<head>"];
    [html appendFormat:@"<link rel=\"stylesheet\" href=\"%@\">",[[NSBundle mainBundle] URLForResource:@"SXDetails.css" withExtension:nil]];
    [html appendString:@"</head>"];
    
    [html appendString:@"<body>"];
    [html appendString:[self touchBody]];
    [html appendString:@"</body>"];
    
    [html appendString:@"</html>"];
    
    [self.webV loadHTMLString:html baseURL:nil];
    [self.view addSubview:self.webV];
}


- (NSString *)touchBody
{
    NSMutableString *body = [NSMutableString string];
    [body appendFormat:@"<div class=\"title\">%@</div>",self.news.title];
    [body appendFormat:@"<div class=\"time\">%@         %@</div>",self.news.ptime,self.news.source];
    
    if (self.news.body != nil)
    {
        [body appendString:self.news.body];
    }
    // 遍历img
    for (NewsModel *news in self.news.img)
    {
        NSMutableString *imgHtml = [NSMutableString string];
        
        // 设置img的div
        [imgHtml appendString:@"<div class=\"img-parent\">"];
        
        // 数组存放被切割的像素
        NSArray *pixel = [news.pixel componentsSeparatedByString:@"*"];
        CGFloat width = [[pixel firstObject]floatValue];
        CGFloat height = [[pixel lastObject]floatValue];
        // 判断是否超过最大宽度
        CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width * 0.96;
        if (width > maxWidth) {
            height = maxWidth / width * height;
            width = maxWidth;
        }
        
        NSString *onload = @"this.onclick = function() {"
        "  window.location.href = 'sx:src=' + this.src;"
        "};";
        [imgHtml appendFormat:@"<img onload=\"%@\" width=\"%f\" height=\"%f\" src=\"%@\">",onload,width,height,news.src];
        
        // 结束标记
        [imgHtml appendString:@"</div>"];
        // 替换标记
        [body replaceOccurrencesOfString:news.ref withString:imgHtml options:NSCaseInsensitiveSearch range:NSMakeRange(0, body.length)];
    }
    return body;
}

 */

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    
//    NSString *headerStr = @"document.getElementsByTagName('h1')[0].innerText = '测试文字';";
//    [webView stringByEvaluatingJavaScriptFromString:headerStr];
    
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
