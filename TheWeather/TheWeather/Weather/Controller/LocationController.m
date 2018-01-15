//
//  LocationController.m
//  TheWeather
//
//  Created by silicon on 2018/1/14.
//  Copyright © 2018年 com.snailgames. All rights reserved.
//

#import "LocationController.h"

@implementation LocationController
@synthesize locationManager = _locationManager;
@synthesize mBlock = _mBlock;

+ (LocationController *)getInstance{
    static LocationController *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [LocationController new];
    });
    
    return _instance;
}

- (void)startLocation:(locationBlock)_block{
    _mBlock = _block;
    if([CLLocationManager locationServicesEnabled]){
        
        if(!_locationManager){
            
            self.locationManager = [[CLLocationManager alloc] init];
            
            if([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
                [self.locationManager requestWhenInUseAuthorization];
                [self.locationManager requestAlwaysAuthorization];
            }
            
            //设置代理
            [self.locationManager setDelegate:self];
            //设置定位精度
            [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
            //设置距离筛选
            [self.locationManager setDistanceFilter:100];
            //开始定位
            [self.locationManager startUpdatingLocation];
            //设置开始识别方向
            [self.locationManager startUpdatingHeading];
        }
    }
}

#pragma mark - CLLocationManangerDelegate
//定位成功以后调用
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    [self.locationManager stopUpdatingLocation];
    CLLocation* location = locations.lastObject;
    
    [self reverseGeocoder:location];
}

#pragma mark Geocoder
//反地理编码
- (void)reverseGeocoder:(CLLocation *)currentLocation {
    
    CLGeocoder* geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if(error || placemarks.count == 0){
            NSLog(@"error = %@",error);
        }else{
            
            CLPlacemark* placemark = placemarks.firstObject;
            NSLog(@"placemark:%@",[[placemark addressDictionary] objectForKey:@"City"]);
            NSString *cityname = [[placemark addressDictionary] objectForKey:@"City"];

            _mBlock(cityname);
        }
    }];
}


@end
