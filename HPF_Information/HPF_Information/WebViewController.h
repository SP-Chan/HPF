//
//  WebViewController.h
//  HPF_Information
//
//  Created by 邓方 on 16/5/5.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"
#import "HPFBaseViewController.h"

@interface WebViewController : HPFBaseViewController<UIWebViewDelegate>

@property(nonatomic,strong)NewsModel *news;

@property(nonatomic,strong)UIWebView *webV;

@end
