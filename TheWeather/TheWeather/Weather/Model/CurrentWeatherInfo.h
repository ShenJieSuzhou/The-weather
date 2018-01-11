//
//  CurrentWeatherInfo.h
//  TheWeather
//
//  Created by shenjie on 2018/1/11.
//  Copyright © 2018年 com.snailgames. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrentWeatherInfo : NSObject
@property (strong, nonatomic) NSString *tempture;
@property (strong, nonatomic) NSString *weather;
@property (strong, nonatomic) NSString *windDirection;
@property (strong, nonatomic) NSString *windStrength;
@property (strong, nonatomic) NSString *humidity;
@property (strong, nonatomic) NSString *time;

@end
