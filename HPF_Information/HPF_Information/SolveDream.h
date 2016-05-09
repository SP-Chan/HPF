//
//  SolveDream.h
//  icon
//
//  Created by lanou on 16/5/6.
//  Copyright © 2016年 黄辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SolveDream : UIView<UITableViewDelegate,UITableViewDataSource,UISearchControllerDelegate,UISearchResultsUpdating>
@property(nonatomic,strong)UISearchController *searchController;
@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *FindArray;
@property(nonatomic,strong)NSMutableArray *contentArray;
@end
