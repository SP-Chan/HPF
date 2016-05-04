//
//  ThreeImageCell.h
//  HPF_Information
//
//  Created by 邓方 on 16/5/4.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThreeImageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage1;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage2;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage3;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *followLabel;




@end
