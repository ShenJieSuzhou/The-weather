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
@synthesize indexArray = _indexArray;

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
    
    NSDictionary * dic1 = @{@"index":@"气温",@"value":self.temptureRange};
    NSDictionary * dic2 = @{@"index":@"穿衣",@"value":self.dressingIndex};
    NSDictionary * dic3 = @{@"index":@"紫外线",@"value":self.uvIndex};
    NSDictionary * dic4 = @{@"index":@"洗衣",@"value":self.washIndex};
    NSDictionary * dic5 = @{@"index":@"旅行",@"value":self.travelIndex};
    NSDictionary * dic6 = @{@"index":@"运动",@"value":self.exerciseIndex};
    
    self.indexArray = [[NSMutableArray alloc] init];
    [self.indexArray addObject:dic1];
    [self.indexArray addObject:dic2];
    [self.indexArray addObject:dic3];
    [self.indexArray addObject:dic4];
    [self.indexArray addObject:dic5];
    [self.indexArray addObject:dic6];
}


@end
