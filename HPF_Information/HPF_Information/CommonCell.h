//
//  CommonCell.h
//  HPF_Information
//
//  Created by 邓方 on 16/5/4.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NewsModel.h"

@interface CommonCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *followLabel;

@property(nonatomic,strong)NewsModel *news;


@end
