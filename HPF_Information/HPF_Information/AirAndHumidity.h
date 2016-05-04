//
//  AirAndHmidity.h
//  HPF_Information
//
//  Created by XP on 16/5/4.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "HPFBaseView.h"

@interface AirAndHumidity : HPFBaseView
@property (weak, nonatomic) IBOutlet UILabel *AirQuality;
@property (weak, nonatomic) IBOutlet UILabel *humidity;

@end
