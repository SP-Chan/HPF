//
//  ViewController.m
//  Location
//
//  Created by XP on 16/5/6.
//  Copyright © 2016年 P. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface ViewController ()<CLLocationManagerDelegate>

@property(nonatomic,strong)CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*手机定位方式
     1.手机基站:根据手机信号塔的位置定位,手机基站越密集,定位越准确.根据手机上网选择最近的手机基站定位
     2.GPS:卫星定位,这个是精确度最高,但是耗电费流量
     3.WiFi:根据上网的IP定位需要有网络

     
     */
    
    
    
    
    //初始化位置管理者
    self.locationManager = [[CLLocationManager alloc] init];
    //设置用户访问权限
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager requestWhenInUseAuthorization];
    
    //和定位有关的一些设置
    //每隔十米就跟新一下位置(让代理方法重新走)
    self.locationManager.distanceFilter = 10.0f;
    self.locationManager.delegate = self;
   
    //开启定位服务
    [self.locationManager startUpdatingLocation];
    //开启手机头朝向的服务
    
  
    
}
#pragma mark- 定位的代理方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    //得到最新的位置
    CLLocation *location = [locations lastObject];
    NSLog(@"lat = %f ,log = %f",location.coordinate.latitude,location.coordinate.longitude);
    
    //位置反编码
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        //在block里面获取位置信息
        for (CLPlacemark *place in placemarks) {
            NSLog(@"name = %@",place.name);
            NSLog(@"thoroughfare = %@",place.thoroughfare);
            NSLog(@"subThoroughfare = %@",place.subThoroughfare);
            NSLog(@"locality = %@",place.locality);
            NSLog(@"region = %@",place.region);
        }
        
    }];
}

#pragma mark- 更新手机朝向的方法
-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    int degree = newHeading.magneticHeading;
    NSLog(@"degree = %d",degree);
    
    if ((315 <= degree && degree <360) || (0 <= degree && degree <45)) {
        NSLog(@"你的手机朝向北方的");
    }else if (45 <= degree && degree < 135)
    {
        NSLog(@"你的手机朝向东方的");
    }else if (135 <= degree && degree < 225)
    {
        NSLog(@"你的手机朝向南方的");
    }else
    {
        NSLog(@"你的手机朝向西方的");
    }
    
    
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
