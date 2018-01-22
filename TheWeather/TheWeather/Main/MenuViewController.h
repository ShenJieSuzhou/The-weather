//
//  MenuViewController.h
//  TheWeather
//
//  Created by shenjie on 2018/1/9.
//  Copyright © 2018年 com.snailgames. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol MenuChooseDelegate;
@interface MenuViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UIButton *closeBtn;
@property (nonatomic, strong) UITableView *menuTableView;
@property (nonatomic, strong) NSMutableArray *tableDataArray;
@property (strong, nonatomic) NSMutableArray *settingArray;
@property (strong, nonatomic) NSMutableArray *cityArray;
//@property (strong, nonatomic) id<MenuChooseDelegate> delegate;
@end

//@protocol MenuChooseDelegate <NSObject>
//@protocol MenuChooseDelegate <NSObject>
//- (void)MenuSetCityName:(NSString *)name;
//
//@end

