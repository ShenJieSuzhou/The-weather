//
//  LocationController.m
//  TheWeather
//
//  Created by silicon on 2018/1/14.
//  Copyright © 2018年 com.snailgames. All rights reserved.
//

#import "LocationController.h"
#import "ConstantIndex.h"

@implementation LocationController
@synthesize locationManager = _locationManager;
@synthesize mBlock = _mBlock;
@synthesize rootView = _rootView;
@synthesize flag = _flag;

+ (LocationController *)getInstance{
    static LocationController *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [LocationController new];
    });

    return _instance;
}

- (void)startLocation:(UIViewController *)rootView  block:(locationBlock)_block{
    _mBlock = _block;
    _rootView = rootView;
    
    if ([CLLocationManager locationServicesEnabled]) {
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
        
         if([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
            [_locationManager requestAlwaysAuthorization];
            [_locationManager requestWhenInUseAuthorization];
         }
        
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 5.0;
        [_locationManager startUpdatingLocation];
    }
}

#pragma mark - 定位失败
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *settingURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication]openURL:settingURL];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

    }];
    [alert addAction:cancel];
    [alert addAction:ok];
    [_rootView presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 定位成功
#pragma mark - CLLocationManangerDelegate
//定位成功以后调用
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    if([ConstantIndex getInstance].locationFlag){
        return;
    }
    [ConstantIndex getInstance].locationFlag = YES;
    
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
