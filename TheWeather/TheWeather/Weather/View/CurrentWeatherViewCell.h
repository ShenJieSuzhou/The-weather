//
//  CurrentWeatherViewCell.h
//  TheWeather
//
//  Created by shenjie on 2018/1/11.
//  Copyright © 2018年 com.snailgames. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrentWeatherViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *quickLookView;

@property (weak, nonatomic) IBOutlet UILabel *tempture;

@property (weak, nonatomic) IBOutlet UILabel *digree;

@property (weak, nonatomic) IBOutlet UILabel *weather;

@property (weak, nonatomic) IBOutlet UILabel *windOritation;

@property (weak, nonatomic) IBOutlet UILabel *windStrength;

@property (weak, nonatomic) IBOutlet UILabel *humidity;

@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UIView *todayVIew;

@property (weak, nonatomic) IBOutlet UIView *tommorrowView;

@property (weak, nonatomic) IBOutlet UILabel *data1;

@property (weak, nonatomic) IBOutlet UILabel *range1;

@property (weak, nonatomic) IBOutlet UILabel *weather1;

@property (weak, nonatomic) IBOutlet UIImageView *icon1;


@property (weak, nonatomic) IBOutlet UILabel *data2;

@property (weak, nonatomic) IBOutlet UILabel *range2;

@property (weak, nonatomic) IBOutlet UILabel *weather2;

@property (weak, nonatomic) IBOutlet UIImageView *icon2;

@property (weak, nonatomic) IBOutlet UIImageView *seperate;

@property (weak, nonatomic) IBOutlet UIImageView *seperateHor;
@end
