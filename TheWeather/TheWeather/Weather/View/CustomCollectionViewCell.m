//
//  CustomCollectionViewCell.m
//  CoolFrame
//
//  Created by shenjie on 2017/9/29.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import "CustomCollectionViewCell.h"

@implementation CustomCollectionViewCell

@synthesize todayWeather = _todayWeather;
@synthesize currentWeather = _currentWeather;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.todayWeather];
    }
    
    return self;
}

- (id)init{
    return [self initWithFrame:CGRectZero];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.todayWeather setFrame:CGRectMake(0, self.frame.size.height - 200, self.frame.size.width, 200)];
}

- (TodayWeatherView *)todayWeather{
    if(!_todayWeather){
        _todayWeather = [TodayWeatherView new];
    }
    
    return _todayWeather;
}

- (void)setCurrentWeather:(CurrentWeatherInfo *)currentWeather{
    [_todayWeather.tempture setText:@"-100"];
    [_todayWeather.weather setText:@"晴"];
    [_todayWeather.windDirection setText:@"西风"];
    [_todayWeather.windStrength setText:@"4级"];
    [_todayWeather.humidity setText:@"50%"];
    [_todayWeather.time setText:@"13:15发布"];
    [_todayWeather.digree setText:@"°"];
}

@end
