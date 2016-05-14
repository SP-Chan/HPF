//
//  LocationManager.h
//  HPF_Information
//
//  Created by XP on 16/5/13.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

#pragma mark -- plist文件添加
/*
 NSLocationAlwaysUsageDescription  应用程序始终使用定位服务
 NSLocationWhenInUseUsageDescription  使用应用程序期间，可以使用定位服务
 */


//block传值
typedef void(^UpdateLocationSuccessBlock) (CLLocation * location, CLPlacemark * placemark);
typedef void(^UpdateLocationErrorBlock) (CLRegion * region, NSError * error);

typedef void(^connotLocationBlock)(void);
@interface LocationManager : NSObject
//定位管理器
@property (nonatomic, strong)CLLocationManager *locationManager;
//单例
+ (instancetype)shareLocationManager;

//精度 默认 kCLLocationAccuracyKilometer
@property (nonatomic, assign) CGFloat desiredAccuracy;

//更新距离 默认1000米
@property (nonatomic, assign) CGFloat distanceFilter;

//开始定位
- (void)startUpdatingLocationWithSuccess:(UpdateLocationSuccessBlock)success andFailure:(UpdateLocationErrorBlock)error WithViewcontroller:(UIViewController *)viewcontroller connotLocation:(connotLocationBlock)connotLocationBlock;

@end

