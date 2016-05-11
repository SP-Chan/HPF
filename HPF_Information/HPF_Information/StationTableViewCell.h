//
//  StationTableViewCell.h
//  UI行讯通
//
//  Created by lanou on 16/3/28.
//  Copyright © 2016年 陈少平. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StationTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *stationLabel;
@property (weak, nonatomic) IBOutlet UILabel *stationNumber;
@property (weak, nonatomic) IBOutlet UIImageView *stopBusButton;
@property (weak, nonatomic) IBOutlet UIImageView *runningBusButton;

@end
