//
//  LocationView.m
//  TheWeather
//
//  Created by shenjie on 2018/1/15.
//  Copyright © 2018年 com.snailgames. All rights reserved.
//

#import "LocationView.h"

@implementation LocationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = YES;
        _guesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabToAddCity)];
        _guesture.delegate = self;
        _guesture.numberOfTapsRequired = 1;
        [self addGestureRecognizer:_guesture];
        
        [self addSubview:self.addImage];
        [self addSubview:self.locationTitle];
        [self addSubview:self.locateImage];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.addImage setFrame:CGRectMake(0, 0, self.frame.size.height, self.frame.size.height)];
    [self.locateImage setFrame:CGRectMake(self.frame.size.width - self.frame.size.height, 0, self.frame.size.height, self.frame.size.height)];
    [self.locationTitle setFrame:CGRectMake(self.frame.size.height, 0, self.frame.size.width - self.frame.size.height - self.frame.size.height, self.frame.size.height)];
}

- (UIImageView *)addImage{
    if(!_addImage){
        _addImage = [[UIImageView alloc] init];
    }
    
    return _addImage;
}

- (UILabel *)locationTitle{
    if(!_locationTitle){
        _locationTitle = [UILabel new];
        [_locationTitle setTextAlignment:NSTextAlignmentCenter];
        [_locationTitle setTextColor:[UIColor whiteColor]];
        [_locationTitle setFont:[UIFont boldSystemFontOfSize:20.0f]];
    }
    return _locationTitle;
}

- (UIImageView *)locateImage{
    if(!_locateImage){
        _locateImage = [UIImageView new];
    }
    
    return _locateImage;
}

//响应事件
- (void)tabToAddCity{
    [_delegate LocationDidTapView:self];
}

@end
