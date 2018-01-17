//
//  WeatherDetailViewCell.h
//  TheWeather
//
//  Created by shenjie on 2018/1/15.
//  Copyright © 2018年 com.snailgames. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CurrentWeatherInfo.h"

@interface WeatherDetailViewCell : UICollectionViewCell<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *indexTableView;
@property (strong, nonatomic) CurrentWeatherInfo *currentWeather;

@end
