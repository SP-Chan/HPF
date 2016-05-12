//
//  PassStationTableViewCell.h
//  HPF_Information
//
//  Created by XP on 16/5/11.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PassStationTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *busNumber;
@property (weak, nonatomic) IBOutlet UILabel *frontName;
@property (weak, nonatomic) IBOutlet UILabel *terminalName;
@property (weak, nonatomic) IBOutlet UILabel *startTime;
@property (weak, nonatomic) IBOutlet UILabel *endTime;
@property (weak, nonatomic) IBOutlet UILabel *basePrice;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
@property (weak, nonatomic) IBOutlet UILabel *length;

@end
