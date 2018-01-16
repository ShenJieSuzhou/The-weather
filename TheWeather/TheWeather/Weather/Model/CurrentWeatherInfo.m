//
//  CurrentWeatherInfo.m
//  TheWeather
//
//  Created by shenjie on 2018/1/11.
//  Copyright © 2018年 com.snailgames. All rights reserved.
//

#import "CurrentWeatherInfo.h"

@implementation CurrentWeatherInfo
@synthesize tempture = _tempture;
@synthesize weather = _weather;
@synthesize windStrength = _windStrength;
@synthesize windDirection = _windDirection;
@synthesize humidity = _humidity;
@synthesize time = _time;
@synthesize temptureRange = _temptureRange;
@synthesize dressingIndex = _dressingIndex;
@synthesize dressingAdvice = _dressingAdvice;
@synthesize uvIndex = _uvIndex;
@synthesize washIndex = _washIndex;
@synthesize travelIndex = _travelIndex;
@synthesize exerciseIndex = _exerciseIndex;


- (void)initWeatherWithSK:(NSDictionary *)sk{
    self.tempture = [sk objectForKey:@"temp"];
    self.windDirection = [sk objectForKey:@"wind_direction"];
    self.windStrength = [sk objectForKey:@"wind_strength"];
    self.humidity = [sk objectForKey:@"humidity"];
    self.time = [sk objectForKey:@"time"];
}

- (void)initWithWeatherInfo:(NSDictionary *)info{
    self.temptureRange = [info objectForKey:@"temperature"];
    self.dressingIndex = [info objectForKey:@"dressing_index"];
    self.dressingAdvice = [info objectForKey:@"dressing_advice"];
    self.uvIndex = [info objectForKey:@"uv_index"];
    self.washIndex = [info objectForKey:@"wash_index"];
    self.travelIndex = [info objectForKey:@"travel_index"];
    self.exerciseIndex = [info objectForKey:@"exercise_index"];
}


@end
