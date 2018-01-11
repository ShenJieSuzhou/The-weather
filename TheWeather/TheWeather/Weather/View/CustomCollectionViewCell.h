//
//  CustomCollectionViewCell.h
//  CoolFrame
//
//  Created by shenjie on 2017/9/29.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TodayWeatherView.h"
#import "CurrentWeatherInfo.h"

@interface CustomCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) TodayWeatherView *todayWeather;

@property (strong, nonatomic) CurrentWeatherInfo *currentWeather;

@end
