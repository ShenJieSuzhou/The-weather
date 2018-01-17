//
//  LocationController.h
//  TheWeather
//
//  Created by silicon on 2018/1/14.
//  Copyright © 2018年 com.snailgames. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

typedef void(^locationBlock)(NSString *cityName);

@interface LocationController : NSObject<CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager* locationManager;
@property (nonatomic, strong) locationBlock mBlock;
@property (nonatomic, strong) UIViewController *rootView;
@property (assign) BOOL flag;

+ (LocationController *)getInstance;

- (void)startLocation:(UIViewController *)rootView  block:(locationBlock)_block;

- (void)locatemap;

@end
