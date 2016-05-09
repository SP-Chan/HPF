//
//  ViewController.m
//  MapView
//
//  Created by XP on 16/5/9.
//  Copyright © 2016年 P. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Annotation.h"
@interface ViewController ()<CLLocationManagerDelegate,MKMapViewDelegate>

@property(nonatomic,strong)CLLocationManager *locationManager;
@property(nonatomic,strong)MKMapView *mapView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc] init];
    //获得权限
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager requestWhenInUseAuthorization];
    self.locationManager.delegate = self;
    
    
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.mapView];
    
    
    
    
    //地图的类型
    self.mapView.mapType  = MKMapTypeStandard;
    //显示用户所在的位置
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self.mapView addGestureRecognizer:longPress];
    
    
}
#pragma makr- 长按手势执行的方法
-(void)longPress:(UILongPressGestureRecognizer *)longPress
{
    //获取长按点的位置
    CGPoint point = [longPress locationInView:longPress.view];
    //将获得的点转化为2D经纬度的坐标
    CLLocationCoordinate2D coordinate = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
    
    //创建一个标注视图(大头针)
    Annotation *anno = [[Annotation alloc] init];
    //为标注视图设置经纬度的坐标
    anno.coordinate = coordinate;
    anno.title = @"China";
    anno.subtitle = @"GZ,TianHe";
    
//    static NSInteger a = 1;
//    anno.tag = a;
//    a++;
    
    //将大头针放在地图上
    [self.mapView addAnnotation:anno];
    
    
}
#pragma mark- 更新用户位置的代理方法
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    userLocation.title = @"中国广东";
    userLocation.subtitle = @"广州市天河区";
    
    //1.设置一个地图上的跨度(比例尺)
    MKCoordinateSpan span = MKCoordinateSpanMake(0.01, 0.01);
    //2.设置地图上显示的范围
    MKCoordinateRegion region = MKCoordinateRegionMake(userLocation.location.coordinate, span);
    
    //3.将制定好的范围赋值给地图上
    [mapView setRegion:region];
}

#pragma mark- 自定义标注视图的方法
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    //如果是系统的标注视图就不做任何操作
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    //创建重用标识符
    static NSString * identifier = @"annotation";
    //创建重用队列
    MKPinAnnotationView *pin = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (pin == nil) {
        pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
    }
    //对大头针设置一些效果
    pin.pinTintColor = [UIColor yellowColor];
    pin.animatesDrop = YES;
    pin.canShowCallout = YES;
    static NSInteger a = 1;
    pin.tag = a;
    a++;
    
    //气泡的两边有两个附件视图
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 30, 30);
    [leftButton setImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
    leftButton.tag = 10086;
    pin.leftCalloutAccessoryView = leftButton;
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 30, 30);
    [rightButton setImage:[UIImage imageNamed:@"2.png"] forState:UIControlStateNormal];
    leftButton.tag = 10010;
    pin.rightCalloutAccessoryView = rightButton;
    
    return pin;
    
}
#pragma mark- 点击气泡执行的方法
-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    NSLog(@"view = %ld",view.tag);
}
#pragma mark- 点击气泡左右两边附件视图执行方法
-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    if (control == [self.view viewWithTag:10086]) {
        NSLog(@"你点击的是左边");
    }else
    {
        NSLog(@"你点击的是右边");
    }
}

-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    NSLog(@"地图上位置发生改变的代理方法");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
