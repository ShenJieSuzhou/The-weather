//
//  DailyForecastViewCell.m
//  TheWeather
//
//  Created by shenjie on 2018/1/15.
//  Copyright © 2018年 com.snailgames. All rights reserved.
//

#import "DailyForecastViewCell.h"
#import "ForecastViewCell.h"
#import "FutureWeatherInfo.h"
#import "WeatherIconIdentifier.h"

@implementation DailyForecastViewCell
@synthesize forecastArray = _forecastArray;


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.forecastTableView.delegate = self;
    self.forecastTableView.dataSource = self;
    
    [self.forecastTableView setBackgroundColor:[UIColor clearColor]];
//    [self.forecastTableView registerClass:[ForecastViewCell class] forCellReuseIdentifier:@"ForecastViewCell"];
    [self.forecastTableView registerNib:[UINib nibWithNibName:@"ForecastViewCell" bundle:nil] forCellReuseIdentifier:@"ForecastViewCell"];
}

- (void)setForecastArray:(NSMutableArray *)forecastArray{
    if(!forecastArray){
        return;
    }
    
    _forecastArray = forecastArray;
    [_forecastTableView reloadData];
}

#pragma mark -tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ForecastViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ForecastViewCell"];
    [cell setBackgroundColor:[UIColor clearColor]];
    
    WeatherInfo *weather = [self.forecastArray objectAtIndex:indexPath.row];
    [cell.date setText:weather.week];
    [cell.weather setText:weather.weather];
    [cell.range setText:weather.temperature];
    [cell.icon setImage:[UIImage imageNamed:[[WeatherIconIdentifier getInstance] requestWeatherIcon:weather.weather]]];
    
    return cell;
}

#pragma mark -tableViewDataDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 10)];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 10, 0, 10)];
    }
}

@end
