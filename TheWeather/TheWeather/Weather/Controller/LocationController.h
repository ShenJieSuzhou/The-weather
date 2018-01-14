//
//  LocationController.h
//  TheWeather
//
//  Created by silicon on 2018/1/14.
//  Copyright © 2018年 com.snailgames. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^locationBlock)();

@interface LocationController : NSObject<CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager* locationManager;

+ (LocationController *)getInstance;

- (void)startLocation:(locationBlock)_block;

@end
