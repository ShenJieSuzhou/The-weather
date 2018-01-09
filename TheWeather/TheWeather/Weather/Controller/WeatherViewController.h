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
@interface WeatherViewController : BaseViewController<UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) UIButton *settingBtn;
@property (strong, nonatomic) UIButton *addCityBtn;
@property (strong, nonatomic) id<MenusDelegate> delegate;
@property (strong, nonatomic) UITapGestureRecognizer *guesture;

@end
