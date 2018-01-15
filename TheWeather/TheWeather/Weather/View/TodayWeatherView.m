//
//  TodayWeatherView.m
//  TheWeather
//
//  Created by shenjie on 2018/1/11.
//  Copyright © 2018年 com.snailgames. All rights reserved.
//

#import "TodayWeatherView.h"

@implementation TodayWeatherView
@synthesize tempture = _tempture;
@synthesize weather = _weather;
@synthesize windDirection = _windDirection;
@synthesize windStrength = _windStrength;
@synthesize humidity = _humidity;
@synthesize time = _time;
@synthesize digree = _digree;

@synthesize horiSeparte = _horiSeparte;
@synthesize veriSeparte = _veriSeparte;
@synthesize today = _today;
@synthesize tommorrow = _tommorrow;
@synthesize temptureRange1 = _temptureRange1;
@synthesize temptureRange2 = _temptureRange2;
@synthesize icon1 = _icon1;
@synthesize icon2 = _icon2;
@synthesize weather1 = _weather1;
@synthesize weather2 = _weather2;


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setBackgroundColor:[UIColor clearColor]];
        
        [self addSubview:self.tempture];
        [self addSubview:self.digree];
        [self addSubview:self.weather];
        [self addSubview:self.windStrength];
        [self addSubview:self.windDirection];
        [self addSubview:self.humidity];
        [self addSubview:self.time];
        [self addSubview:self.today];
        [self addSubview:self.tommorrow];
        [self addSubview:self.horiSeparte];
        [self addSubview:self.veriSeparte];
        [self addSubview:self.temptureRange1];
        [self addSubview:self.temptureRange2];
        [self addSubview:self.icon1];
        [self addSubview:self.icon2];
        [self addSubview:self.weather1];
        [self addSubview:self.weather2];
    }
    
    return self;
}

- (id)init{
    return [self initWithFrame:CGRectZero];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.tempture setFrame:CGRectMake(0, 0, 140, 100)];
    [self.digree setFrame:CGRectMake(140, 0, 30, 100)];
    [self.weather setFrame:CGRectMake(170, 40, 60, 60)];
    [self.windDirection setFrame:CGRectMake(20, 100, 40, 40)];
    [self.windStrength setFrame:CGRectMake(60, 100, 40, 40)];
    [self.humidity setFrame:CGRectMake(100, 100, 40, 40)];
    [self.time setFrame:CGRectMake(self.frame.size.width - 100, 100, 100, 40)];
}

/*
 * @brief 类成员懒加载
 */

- (UILabel *)tempture{
    if(!_tempture){
        _tempture = [UILabel new];
        [_tempture setTextAlignment:NSTextAlignmentRight];
//        [_tempture setFont:[UIFont fontWithName:@"Helvetica-Bold" size:60.0f]];
        [_tempture setFont:[UIFont systemFontOfSize:60.0f]];
        [_tempture setTextColor:[UIColor whiteColor]];
    }
    
    return _tempture;
}

- (UILabel *)digree{
    if(!_digree){
        _digree = [UILabel new];
        [_digree setTextAlignment:NSTextAlignmentLeft];
//        [_digree setFont:[UIFont fontWithName:@"Helvetica-Bold" size:60.0f]];
        [_digree setFont:[UIFont systemFontOfSize:60.0f]];
        [_digree setTextColor:[UIColor whiteColor]];
    }
    
    return _digree;
}


- (UILabel *)weather{
    if(!_weather){
        _weather = [UILabel new];
        [_weather setTextAlignment:NSTextAlignmentCenter];
        [_weather setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20.0f]];
        [_weather setTextColor:[UIColor whiteColor]];
    }
    
    return _weather;
}


- (UILabel *)windDirection{
    if(!_windDirection){
        _windDirection = [UILabel new];
        [_windDirection setTextAlignment:NSTextAlignmentCenter];
        [_windDirection setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15.0f]];
        [_windDirection setTextColor:[UIColor whiteColor]];
    }
    
    return _windDirection;
}

- (UILabel *)windStrength{
    if(!_windStrength){
        _windStrength = [UILabel new];
        [_windStrength setTextAlignment:NSTextAlignmentCenter];
        [_windStrength setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15.0f]];
        [_windStrength setTextColor:[UIColor whiteColor]];
    }
    
    return _windStrength;
}

- (UILabel *)humidity{
    if(!_humidity){
        _humidity = [UILabel new];
        [_humidity setTextAlignment:NSTextAlignmentCenter];
        [_humidity setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15.0f]];
        [_humidity setTextColor:[UIColor whiteColor]];
    }
    
    return _humidity;
}

- (UILabel *)time{
    if(!_time){
        _time = [UILabel new];
        [_time setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15.0f]];
        [_time setTextColor:[UIColor whiteColor]];
    }
    
    return _time;
}

- (UILabel *)today{
    if(_today){
        _today = [UILabel new];
    }
    return _today;
}

- (UILabel *)tommorrow{
    if(!_tommorrow){
        _tommorrow = [UILabel new];
    }
    return _tommorrow;
}

- (UILabel *)temptureRange1{
    if(!_temptureRange1){
        _temptureRange1 = [UILabel new];
    }
    return _temptureRange1;
}

- (UILabel *)temptureRange2{
    if(!_temptureRange2){
        _temptureRange2 = [UILabel new];
    }
    return _temptureRange2;
}

- (UIImageView *)icon1{
    if(!_icon1){
        _icon1 = [UIImageView new];
    }
    return _icon1;
}

- (UIImageView *)icon2{
    if(!_icon2){
        _icon2 = [UIImageView new];
    }
    return _icon2;
}

- (UILabel *)weather1{
    if(!_weather1){
        _weather1 = [UILabel new];
    }
    return _weather1;
}

- (UILabel *)weather2{
    if(!_weather2){
        _weather2 = [UILabel new];
    }
    return _weather2;
}

@end
