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
@property (strong, nonatomic) NSString *temptureRange;
@property (strong, nonatomic) NSString *dressingIndex;
@property (strong, nonatomic) NSString *dressingAdvice;
@property (strong, nonatomic) NSString *uvIndex;
@property (strong, nonatomic) NSString *washIndex;
@property (strong, nonatomic) NSString *travelIndex;
@property (strong, nonatomic) NSString *exerciseIndex;

@property (strong, nonatomic) NSMutableArray *indexArray;


- (void)initWeatherWithSK:(NSDictionary *)sk;

- (void)initWithWeatherInfo:(NSDictionary *)info;

@end
