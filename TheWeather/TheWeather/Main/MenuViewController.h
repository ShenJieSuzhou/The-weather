//
//  MenuViewController.h
//  TheWeather
//
//  Created by shenjie on 2018/1/9.
//  Copyright © 2018年 com.snailgames. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UIButton *closeBtn;
@property (nonatomic, strong) UITableView *menuTableView;
@property (nonatomic, strong) NSMutableArray *tableDataArray;
@property (strong, nonatomic) NSMutableArray *settingArray;
@property (strong, nonatomic) NSMutableArray *cityArray;
@end
