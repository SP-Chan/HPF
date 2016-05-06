//
//  WebViewController2.m
//  HPF_Information
//
//  Created by 邓方 on 16/5/6.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "WebViewController.h"
//#import "SXDetailModel.h"
//#import "SXDetailImgModel.h"


@interface WebViewController ()

//@property (nonatomic, strong)SXDetailModel *detailModel;
@property(nonatomic,strong)UIActivityIndicatorView *ActivityIndicator;
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
    
    //    [self showInWebView];
    
    
    // Do any additional setup after loading the view.
}



- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
    //在屏幕中间创建一个红色的菊花;
    if (_ActivityIndicator == nil) {
        //菊花;
        _ActivityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _ActivityIndicator.center = CGPointMake(200, 195);
        [self.view addSubview:_ActivityIndicator];
        [_ActivityIndicator startAnimating]; // 开始旋转
    }
    
    
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(stopActivityIndicator) userInfo:self repeats:YES];
    
    
}

-(void)stopActivityIndicator
{
        [_ActivityIndicator stopAnimating]; // 结束旋转
        [_ActivityIndicator setHidesWhenStopped:YES];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
//        [_ActivityIndicator stopAnimating]; // 结束旋转
//        [_ActivityIndicator setHidesWhenStopped:YES]; //当旋转结束时隐藏
}

//- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
//{

//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"网页无法加载" message:@"请稍后重试" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
//    [alert addAction:action];
//    [self presentViewController:alert animated:YES completion:^{
//        
//    }];
//}




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
    [body appendFormat:@"<div class=\"title\">%@</div>",self.detailModel.title];
    [body appendFormat:@"<div class=\"time\">%@         %@</div>",self.detailModel.ptime,self.detailModel.source];
    
    if (self.detailModel.body != nil)
    {
        [body appendString:self.detailModel.body];
    }
    // 遍历img
    for (SXDetailImgModel *detailImgModel in self.detailModel.img)
    {
        NSMutableString *imgHtml = [NSMutableString string];
        
        // 设置img的div
        [imgHtml appendString:@"<div class=\"img-parent\">"];
        
        // 数组存放被切割的像素
        NSArray *pixel = [detailImgModel.pixel componentsSeparatedByString:@"*"];
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
        [imgHtml appendFormat:@"<img onload=\"%@\" width=\"%f\" height=\"%f\" src=\"%@\">",onload,width,height,detailImgModel.src];
        
        // 结束标记
        [imgHtml appendString:@"</div>"];
        // 替换标记
        [body replaceOccurrencesOfString:detailImgModel.ref withString:imgHtml options:NSCaseInsensitiveSearch range:NSMakeRange(0, body.length)];
    }
    return body;
}

//#pragma mark - ******************** 将发出通知时调用
//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
//{
//    NSString *url = request.URL.absoluteString;
//    NSRange range = [url rangeOfString:@"sx:src="];
//    if (range.location != NSNotFound)
//    {
//        NSInteger begin = range.location + range.length;
//        NSString *src = [url substringFromIndex:begin];
//        [self savePictureToAlbum:src];
//        return NO;
//    }
//    return YES;
//}

*/



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
