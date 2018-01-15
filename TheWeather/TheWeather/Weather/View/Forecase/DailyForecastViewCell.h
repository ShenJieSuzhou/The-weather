//
//  DailyForecastViewCell.h
//  TheWeather
//
//  Created by shenjie on 2018/1/15.
//  Copyright © 2018年 com.snailgames. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DailyForecastViewCell : UICollectionViewCell<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *forecastTableView;
@property (strong, nonatomic) NSMutableArray *forecastArray;

@end
