//
//  WeatherIconIdentifier.m
//  TheWeather
//
//  Created by shenjie on 2018/1/18.
//  Copyright © 2018年 com.snailgames. All rights reserved.
//

#import "WeatherIconIdentifier.h"

@implementation WeatherIconIdentifier

+ (WeatherIconIdentifier *)getInstance{
    static WeatherIconIdentifier *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [WeatherIconIdentifier new];
    });
    
    return _instance;
}

- (NSString *)requestWeatherIcon:(NSString *)weather{

    if([weather isEqualToString:@"晴"]){
        return @"clear_day";
    }else if([weather isEqualToString:@"多云"]){
        return @"cloudy_day_night";
    }else if([weather isEqualToString:@"阴"]){
        return @"cloudy_day_night";
    }else if([weather isEqualToString:@"阵雨"]){
        return @"light_rain_day_night";
    }else if([weather isEqualToString:@"雷阵雨"]){
        return @"scattered_thundershowers_day";
    }else if([weather isEqualToString:@"雷阵雨伴有冰雹"]){
        return @"freezing_rain_day_night";
    }else if([weather isEqualToString:@"雨夹雪"]){
        return @"flurries_day_night";
    }else if([weather isEqualToString:@"小雨"]){
        return @"light_rain_day_night";
    }else if([weather isEqualToString:@"中雨"]){
        return @"scattered_showers_day_night";
    }else if([weather isEqualToString:@"大雨"]){
        return @"thunderstorm_day_night";
    }else if([weather isEqualToString:@"暴雨"]){
        return @"thunderstorm_day_night";
    }else if([weather isEqualToString:@"大暴雨"]){
        return @"thunderstorm_day_night";
    }else if([weather isEqualToString:@"特大暴雨"]){
        return @"thunderstorm_day_night";
    }else if([weather isEqualToString:@"阵雪"]){
        return @"flurries_day_night";
    }else if([weather isEqualToString:@"小雪"]){
        return @"flurries_day_night";
    }else if([weather isEqualToString:@"中雪"]){
        return @"flurries_day_night";
    }else if([weather isEqualToString:@"大雪"]){
        return @"snow_day_night";
    }else if([weather isEqualToString:@"暴雪"]){
        return @"snow_day_night";
    }else if([weather isEqualToString:@"雾"]){
        return @"fog_day_night";
    }else if([weather isEqualToString:@"冻雨"]){
        return @"freezing_rain_day_night";
    }else if([weather isEqualToString:@"沙尘暴"]){
        return @"dust_day_night";
    }else if([weather isEqualToString:@"小雨转中雨"]){
        return @"light_rain_day_night";
    }else if([weather isEqualToString:@"中雨转大雨"]){
        return @"scattered_showers_day_night";
    }else if([weather isEqualToString:@"大雨转暴雨"]){
        return @"scattered_showers_day_night";
    }else if([weather isEqualToString:@"暴雨转大暴雨"]){
        return @"thunderstorm_day_night";
    }else if([weather isEqualToString:@"大暴雨转特大暴雨"]){
        return @"thunderstorm_day_night";
    }else if([weather isEqualToString:@"小雪转中雪"]){
        return @"flurries_day_night";
    }else if([weather isEqualToString:@"中雪转大雪"]){
        return @"flurries_day_night";
    }else if([weather isEqualToString:@"大雪转暴雪"]){
        return @"snow_day_night";
    }else if([weather isEqualToString:@"浮尘"]){
        return @"dust_day_night";
    }else if([weather isEqualToString:@"扬沙"]){
        return @"dust_day_night";
    }else if([weather isEqualToString:@"强沙尘暴"]){
        return @"dust_day_night";
    }else if([weather isEqualToString:@"霾"]){
        return @"fog_day_night";
    }else if([weather isEqualToString:@"多云转阴"]){
        return @"cloudy_day_night";
    }else if([weather isEqualToString:@"阴转多云"]){
        return @"cloudy_day_night";
    }else if([weather isEqualToString:@"多云转小雨"]){
        return @"light_rain_day_night";
    }else if([weather isEqualToString:@"中雨转小雨"]){
        return @"light_rain_day_night";
    }else if([weather isEqualToString:@"暴雪转大雪"]){
        return @"snow_day_night";
    }else if([weather isEqualToString:@"雨夹雪转大雪"]){
        return @"snow_day_night";
    }else if([weather isEqualToString:@"晴转多云"]){
        return @"cloudy_day_night";
    }else if([weather isEqualToString:@"小雪转阴"]){
        return @"flurries_day_night";
    }else if([weather isEqualToString:@"多云转晴"]){
        return @"clear_day";
    }else if([weather isEqualToString:@"小雪转雨夹雪"]){
        return @"flurries_day_night";
    }else if([weather isEqualToString:@"阴转小雨"]){
        return @"light_rain_day_night";
    }else if([weather isEqualToString:@"雨夹雪转小雪"]){
        return @"flurries_day_night";
    }else if([weather isEqualToString:@"阴转小雪"]){
        return @"flurries_day_night";
    }
    
    return @"";
}

@end
