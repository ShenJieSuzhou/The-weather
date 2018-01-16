//
//  FutureWeatherInfo.h
//  TheWeather
//
//  Created by shenjie on 2018/1/11.
//  Copyright © 2018年 com.snailgames. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface WeatherInfo : NSObject

@property (strong, nonatomic) NSString *temperature;
@property (strong, nonatomic) NSString *weather;
@property (strong, nonatomic) NSString *wind;
@property (strong, nonatomic) NSString *week;
@property (strong, nonatomic) NSString *date;

- (void)initWithTempture:(NSString *)temp weather:(NSString *)weather wind:(NSString *)wind week:(NSString *)week date:(NSString *)date;

@end


@interface FutureWeatherInfo : NSObject
@property (strong, nonatomic) NSMutableArray *weatherArray;

- (void)initWithWeatherInfo:(NSArray *)array;

@end
