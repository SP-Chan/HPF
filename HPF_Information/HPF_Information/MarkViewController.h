//
//  MarkViewController.h
//  Uivew
//
//  Created by hui on 16/5/8.
//  Copyright © 2016年 黄辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarkViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchControllerDelegate,UISearchResultsUpdating>
@property(nonatomic,strong)UISearchController *searchController;
@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)NSString *identifier;
@end
