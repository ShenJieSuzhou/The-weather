//
//  WeatherIconIdentifier.h
//  TheWeather
//
//  Created by shenjie on 2018/1/18.
//  Copyright © 2018年 com.snailgames. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherIconIdentifier : NSObject

+ (WeatherIconIdentifier *)getInstance;

- (NSString *)requestWeatherIcon:(NSString *)weather;

@end
