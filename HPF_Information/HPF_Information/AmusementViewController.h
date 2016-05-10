//
//  AmusementViewController.h
//  HPF_Information
//
//  Created by 邓方 on 16/5/3.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "HPFBaseViewController.h"
#import "NewsModel.h"
#import "CommonCell.h"
#import "WebViewController.h"
@interface AmusementViewController : HPFBaseViewController<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong)UITableView *tabView;

@property(nonatomic,strong)NewsModel *news;


@end
