//
//  CustomCollectionView.h
//  CoolFrame
//
//  Created by silicon on 2017/10/2.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CurrentWeatherInfo.h"
#import "FutureWeatherInfo.h"

@protocol CustomCollectionViewDelegate;
@interface CustomCollectionView : UIView<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

//callback delegate
@property (strong, nonatomic) id<CustomCollectionViewDelegate> delegate;
//datasource
@property (strong,nonatomic) NSMutableArray *itemArray;
//UICollectionView
@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) CurrentWeatherInfo *currentWeather;

@property (strong, nonatomic) FutureWeatherInfo *futureWeather;

@end

@protocol CustomCollectionViewDelegate <NSObject>
- (void)collectionView:(CustomCollectionView *)collectionView didSelectItemAtIndex:(NSInteger)index;
- (void)collectionView:(CustomCollectionView *)collectionView didScroll:(BOOL)scroll;
- (void)collectionView:(CustomCollectionView *)collectionView endScroll:(BOOL)scroll;
@end
