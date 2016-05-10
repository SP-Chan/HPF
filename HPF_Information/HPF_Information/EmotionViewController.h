//
//  EmotionViewController.h
//  HPF_Information
//
//  Created by 邓方 on 16/5/4.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "HPFBaseViewController.h"
#import "NewsModel.h"
#import "CommonCell.h"
#import "WebViewController.h"
@interface EmotionViewController : HPFBaseViewController<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong)UITableView *tabView;

@property(nonatomic,strong)NewsModel *news;


@end
