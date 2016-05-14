//
//  LocationManager.m
//  HPF_Information
//
//  Created by XP on 16/5/13.
//  Copyright © 2016年 HPF. All rights reserved.
//

#import "LocationManager.h"
static LocationManager *_manager = nil;

@interface LocationManager()<CLLocationManagerDelegate>
{
    UpdateLocationSuccessBlock _successBlock;
    
    UpdateLocationErrorBlock _errorBlock;
}



@end

@implementation LocationManager

#pragma mark -- 单例
+ (instancetype)shareLocationManager
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_manager == nil)
        {
            _manager = [[LocationManager alloc] init];
        }
        
    });
    return _manager;
    
}
#pragma mark -- 初始化
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _distanceFilter = 1000.f;
        _desiredAccuracy = kCLLocationAccuracyKilometer;
    }
    return self;
}

- (CLLocationManager *)locationManager
{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
    }
    return _locationManager;
}


#pragma maek -- 定位
- (void)startUpdatingLocationWithSuccess:(UpdateLocationSuccessBlock)success andFailure:(UpdateLocationErrorBlock)error WithViewcontroller:(UIViewController *)viewcontroller connotLocation:(connotLocationBlock)connotLocationBlock
{
    _successBlock = [success copy];
    _errorBlock = [error copy];
    //定位是否可用
    BOOL isLocationEnabled = [CLLocationManager locationServicesEnabled];
    if (!isLocationEnabled)
    {
        if (viewcontroller.view.window)
        {
            
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"如果您想要定位，请开启导航" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:NULL];
            [alertVC addAction:action];
            [viewcontroller presentViewController:alertVC animated:YES completion:NULL];
        }
        connotLocationBlock();
        return;
    }
    //没有给这个app授权
    else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
    {
        if (viewcontroller.view.window)
        {
            
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"亲，请给我个权限定位吧!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:NULL];
            [alertVC addAction:action];
            [viewcontroller presentViewController:alertVC animated:YES completion:NULL];
        }
        connotLocationBlock();
    }
    //说明可以定位
    else
    {
        self.locationManager.delegate = self;
        
    }
    
}

#pragma mark -- 改变状态时调用
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    //是否具有定位权限
    //开启永不的时候是2  使用期间的是4 始终是3
    //说明第一次进入这个程序，会询问它是否开启导航,这里只会询问，使用时开启
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        if (status == kCLAuthorizationStatusNotDetermined)
        {
            [manager requestWhenInUseAuthorization];
        }
        //如果状态是使用的时候用，就进行定位
        else if(status == kCLAuthorizationStatusAuthorizedWhenInUse)
        {
            //定位开始
            [manager startUpdatingLocation];
            //精度
            self.locationManager.desiredAccuracy = _desiredAccuracy;
            //更新距离
            self.locationManager.distanceFilter = _distanceFilter;
        }
    }
    //如果系统版本低于8.0
    else
    {
        //如果没有限制使用导航就开始导航
        if (status == kCLAuthorizationStatusAuthorized ||status == kCLAuthorizationStatusNotDetermined)
        {
            [manager startUpdatingLocation];
            //精度
            self.locationManager.desiredAccuracy = _desiredAccuracy;
            //更新距离
            self.locationManager.distanceFilter = _distanceFilter;
        }
        
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation * location = locations.firstObject;
    CLGeocoder * geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark * placemark = placemarks.firstObject;
        _successBlock(location,placemark);
    }];
    [manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error
{
    _errorBlock(region, error);
}




@end

