//
//  TodayWeatherView.h
//  TheWeather
//
//  Created by shenjie on 2018/1/11.
//  Copyright © 2018年 com.snailgames. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodayWeatherView : UIView
@property (strong, nonatomic) UILabel *tempture;
@property (strong, nonatomic) UILabel *digree;
@property (strong, nonatomic) UILabel *weather;
@property (strong, nonatomic) UILabel *windDirection;
@property (strong, nonatomic) UILabel *windStrength;
@property (strong, nonatomic) UILabel *humidity;
@property (strong, nonatomic) UILabel *time;

@property (strong, nonatomic) UIImageView *horiSeparte;
@property (strong, nonatomic) UIImageView *veriSeparte;
@property (strong, nonatomic) UILabel *today;
@property (strong, nonatomic) UILabel *tommorrow;
@property (strong, nonatomic) UILabel *temptureRange1;
@property (strong, nonatomic) UILabel *temptureRange2;
@property (strong, nonatomic) UIImageView *icon1;
@property (strong, nonatomic) UIImageView *icon2;
@property (strong, nonatomic) UILabel *weather1;
@property (strong, nonatomic) UILabel *weather2;


@end
