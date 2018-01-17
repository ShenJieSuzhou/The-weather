//
//  FutureWeatherInfo.m
//  TheWeather
//
//  Created by shenjie on 2018/1/11.
//  Copyright © 2018年 com.snailgames. All rights reserved.
//

#import "FutureWeatherInfo.h"

static NSMutableArray *dateArray;
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

- (void)initWithWeatherInfo:(NSDictionary *)futureDic{
    self.weatherArray = [[NSMutableArray alloc] init];
    NSArray *sortedDate = [self sortDate:[futureDic allKeys]];
    
    for (int i = 0; i < [[futureDic allKeys] count]; i++) {
        NSString *day = [sortedDate objectAtIndex:i];
        NSString *key = [NSString stringWithFormat:@"day_%@", day];
        
        NSDictionary *dic = [futureDic objectForKey:key];
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

/*
 * @brief 日期排序
 **/
- (NSArray *)sortDate:(NSArray *)keys{
    NSMutableArray *sortedArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < [keys count]; i++) {
        NSString *temp = [keys objectAtIndex:i];
        NSArray *arr = [temp componentsSeparatedByString:@"_"];
        NSString *value = [arr objectAtIndex:1];
        
        [sortedArray addObject:value];
    }
    
    NSComparator cmptr = ^(id obj1, id obj2){
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        
        return (NSComparisonResult)NSOrderedSame;
    };
    
    NSArray *array = [sortedArray sortedArrayUsingComparator:cmptr];
    return array;
}

/*
 * @brief 插入排序
 */
- (void)insertSort:(NSMutableArray *)arr count:(int)num{
    dateArray = [arr copy];
    for(int i= 1; i< num ; i++){
        if([dateArray objectAtIndex:i] < [dateArray objectAtIndex:i-1]){
            int j = i-1;
            int x = [[dateArray objectAtIndex:i] intValue];
            [dateArray insertObject:[dateArray objectAtIndex:i-1] atIndex:i];
            
            while(x < [[dateArray objectAtIndex:j] longValue]){  //查找在有序表的插入位置
                [dateArray insertObject:[dateArray objectAtIndex:j] atIndex:j+1];
                j--;         //元素后移
            }
            [dateArray insertObject:[NSNumber numberWithInt:x] atIndex:j+1];
        }
    }
    
    NSLog(@"%@", dateArray);
}

@end
