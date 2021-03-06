//
//  LocalViewController.h
//  HPF_Information
//
//  Created by 邓方 on 16/5/3.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "HPFBaseViewController.h"
#import "NewsModel.h"
#import "CommonCell.h"
#import "ThreeImageCell.h"
#import "WebViewController.h"
#import "ScrollViewController.h"

@interface LocalViewController : HPFBaseViewController<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong)UITableView *tabView;

@property(nonatomic,strong)NewsModel *news;

@property(nonatomic,strong)UIActivityIndicatorView *ActivityIndicator;
@property(nonatomic,strong)UIView *actiView;
@property(nonatomic,strong)UILabel *label;



@end
