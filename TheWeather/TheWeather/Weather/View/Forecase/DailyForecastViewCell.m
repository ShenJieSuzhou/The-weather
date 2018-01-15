//
//  DailyForecastViewCell.m
//  TheWeather
//
//  Created by shenjie on 2018/1/15.
//  Copyright © 2018年 com.snailgames. All rights reserved.
//

#import "DailyForecastViewCell.h"
#import "ForecastViewCell.h"

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

#pragma mark -tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ForecastViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ForecastViewCell"];
    
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}

#pragma mark -tableViewDataDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
