//
//  FutureWeatherInfo.m
//  TheWeather
//
//  Created by shenjie on 2018/1/11.
//  Copyright © 2018年 com.snailgames. All rights reserved.
//

#import "FutureWeatherInfo.h"

@implementation WeatherInfo

- (void)initWithTempture:(NSString *)temp weather:(NSString *)weather wind:(NSString *)wind week:(NSString *)week date:(NSString *)date{
    
    self.temperature = temp;
    self.weather = weather;
    self.wind = wind;
    self.week = week;
    self.date = date;
}

@end


@implementation FutureWeatherInfo
@synthesize weatherArray = _weatherArray;

- (void)initWithWeatherInfo:(NSArray *)array{
    for (int i = 0; i < [array count]; i++) {
        NSDictionary *dic = [array objectAtIndex:i];
        NSString *temp = [dic objectForKey:@"temperature"];
        NSString *weather = [dic objectForKey:@"weather"];
        NSString *wind = [dic objectForKey:@"wind"];
        NSString *week = [dic objectForKey:@"week"];
        NSString *date = [dic objectForKey:@"date"];
        
        WeatherInfo *weatherModel = [[WeatherInfo alloc] init];
        [weatherModel initWithTempture:temp weather:weather wind:wind week:week date:date];
        
        [self.weatherArray addObject:weatherModel];
    }
    
}

@end
