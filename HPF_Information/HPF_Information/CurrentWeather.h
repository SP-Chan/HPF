//
//  CurrentWeather.h
//  HPF_Information
//
//  Created by XP on 16/5/4.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "HPFBaseView.h"

@interface CurrentWeather : HPFBaseView
@property (weak, nonatomic) IBOutlet UILabel *currentDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentWeatherLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentCityLabel;

@property (weak, nonatomic) IBOutlet UIImageView *currentImageView;
@property (weak, nonatomic) IBOutlet UILabel *currentMaxAndMinLabel;
@property (weak, nonatomic) IBOutlet UILabel *updateLabel;

@end
