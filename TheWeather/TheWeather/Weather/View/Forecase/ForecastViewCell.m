//
//  ForecastViewCell.m
//  TheWeather
//
//  Created by shenjie on 2018/1/15.
//  Copyright © 2018年 com.snailgames. All rights reserved.
//

#import "ForecastViewCell.h"

@implementation ForecastViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _weather.adjustsFontSizeToFitWidth = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
