//
//  VideoRecordViewController.h
//  HPF_Information
//
//  Created by lanou on 16/5/14.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "HPFBaseViewController.h"

@interface VideoRecordViewController : HPFBaseViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *DataArray;
@property(nonatomic,strong)UITableView *tableView;

@end
