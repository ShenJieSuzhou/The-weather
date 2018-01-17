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
    _flag = NO;
    
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
//-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
//
//    [_locationManager stopUpdatingLocation];
//    CLLocation *currentLocation = [locations lastObject];
//    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
//    //这里的代码是为了判断didUpdateLocations调用了几次 有可能会出现多次调用 为了避免不必要的麻烦 在这里加个if判断 如果大于1.0就return
//    NSTimeInterval locationAge = -[currentLocation.timestamp timeIntervalSinceNow];
//    if (locationAge > 1.0){//如果调用已经一次，不再执行
//        return;
//    }
//    //地理反编码 可以根据坐标(经纬度)确定位置信息(街道 门牌等)
//    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//        if (placemarks.count >0) {
//            CLPlacemark *placeMark = placemarks[0];
//            _mBlock(placeMark.locality);
//
////            _currentCity = placeMark.locality;
////            if (!_currentCity) {
////                _currentCity = @"无法定位当前城市";
////            }
//            //看需求定义一个全局变量来接收赋值
////            NSLog(@"当前国家 - %@",placeMark.country);//当前国家
////            NSLog(@"当前城市 - %@",_currentCity);//当前城市
////            NSLog(@"当前位置 - %@",placeMark.subLocality);//当前位置
////            NSLog(@"当前街道 - %@",placeMark.thoroughfare);//当前街道
////            NSLog(@"具体地址 - %@",placeMark.name);//具体地址
////            NSString *message = [NSString stringWithFormat:@"%@,%@,%@,%@,%@",placeMark.country,_currentCity,placeMark.subLocality,placeMark.thoroughfare,placeMark.name];
////
////            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"好", nil];
////            [alert show];
//        }else if (error == nil && placemarks.count){
//
//            NSLog(@"NO location and error return");
//        }else if (error){
//
//            NSLog(@"loction error:%@",error);
//        }
//    }];
//}


#pragma mark - CLLocationManangerDelegate
//定位成功以后调用
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    if(_flag){
        return;
    }
    
    _flag = YES;
    [self.locationManager stopUpdatingLocation];
    CLLocation* location = locations.lastObject;
    
//    //这里的代码是为了判断didUpdateLocations调用了几次 有可能会出现多次调用 为了避免不必要的麻烦 在这里加个if判断 如果大于1.0就return
//    NSTimeInterval locationAge = -[location.timestamp timeIntervalSinceNow];
//    if (locationAge > 1.0){//如果调用已经一次，不再执行
//        return;
//    }
    
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
