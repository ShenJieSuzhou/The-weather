//
//  CurrentWeatherViewCell.m
//  TheWeather
//
//  Created by shenjie on 2018/1/11.
//  Copyright © 2018年 com.snailgames. All rights reserved.
//

#import "CurrentWeatherViewCell.h"
#import "Masonry.h"

@implementation CurrentWeatherViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _tempture.adjustsFontSizeToFitWidth = YES;
    _weather1.adjustsFontSizeToFitWidth = YES;
    _weather2.adjustsFontSizeToFitWidth = YES;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect rect = self.frame;
    CGFloat base_Y = self.seperateHor.frame.origin.y;

    [self.todayVIew setFrame:CGRectMake(0, base_Y + 1, (rect.size.width -  1) / 2, rect.size.height - base_Y - 1)];
    [self.tommorrowView setFrame:CGRectMake((rect.size.width -  1) / 2 + 1, base_Y + 1, (rect.size.width -  1) / 2, rect.size.height - base_Y - 1)];
    [self.seperate setFrame:CGRectMake((rect.size.width -  1) / 2, base_Y + 1, 1, rect.size.height - base_Y - 1)];
    
    [self.data1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_todayVIew).with.offset(20);
        make.left.equalTo(_todayVIew).with.offset(20);
    }];
    
    [self.range1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_todayVIew).with.offset(20);
        make.right.equalTo(_todayVIew).with.offset(-20);
    }];
    
//    [self.weather1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_data1).with.offset(40);
//        make.left.equalTo(_todayVIew).with.offset(20);
//    }];
    
    [self.data2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tommorrowView).with.offset(20);
        make.left.equalTo(_tommorrowView).with.offset(20);
    }];
    
    [self.range2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tommorrowView).with.offset(20);
        make.right.equalTo(_tommorrowView).with.offset(-20);
    }];
    
//    [self.weather2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_data2).with.offset(40);
//        make.left.equalTo(_tommorrowView).with.offset(20);
//    }];
 
    [self.icon1 setFrame:CGRectMake(self.todayVIew.frame.size.width - 20 - self.icon1.frame.size.width, self.weather1.frame.origin.y, self.icon1.frame.size.width, self.icon1.frame.size.height)];
    
    [self.icon2 setFrame:CGRectMake(_tommorrowView.frame.size.width - 20 - self.icon2.frame.size.width, self.weather2.frame.origin.y, self.icon2.frame.size.width, self.icon2.frame.size.height)];
    
}

@end
