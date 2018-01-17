//
//  WeatherViewController.h
//  TheWeather
//
//  Created by shenjie on 2018/1/9.
//  Copyright © 2018年 com.snailgames. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "MenuDelegate.h"
#import "CustomCollectionView.h"
#import "GYZChooseCityDelegate.h"
#import "LocationView.h"
#import "CurrentWeatherInfo.h"
#import "FutureWeatherInfo.h"

@interface WeatherViewController : BaseViewController<UIGestureRecognizerDelegate,GYZChooseCityDelegate>

@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) UIButton *settingBtn;
@property (strong, nonatomic) UIButton *shareBtn;
@property (strong, nonatomic) id<MenusDelegate> delegate;
@property (strong, nonatomic) UITapGestureRecognizer *guesture;
@property (nonatomic, strong) CustomCollectionView *customWeatherView;
@property (strong, nonatomic) LocationView *locationView;
@property (strong, nonatomic) CurrentWeatherInfo *currentWeatherInfo;
@property (strong, nonatomic) FutureWeatherInfo *futureWeatherInfo;

@property (strong, nonatomic) UIImageView *screenImage;




@end
