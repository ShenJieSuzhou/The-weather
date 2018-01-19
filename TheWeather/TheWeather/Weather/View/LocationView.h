//
//  LocationView.h
//  TheWeather
//
//  Created by shenjie on 2018/1/15.
//  Copyright © 2018年 com.snailgames. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LocationTapDelegate;

@interface LocationView : UIView<UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIImageView *addImage;
@property (strong, nonatomic) UILabel *locationTitle;
@property (strong, nonatomic) UIImageView *locateImage;
@property (strong, nonatomic) UITapGestureRecognizer *guesture;
@property (strong, nonatomic) id<LocationTapDelegate> delegate;
@end

@protocol LocationTapDelegate <NSObject>
@optional

- (void)LocationDidTapView:(LocationView *)view;

@end
