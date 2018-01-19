//
//  MainViewController.m
//  TheWeather
//
//  Created by shenjie on 2018/1/9.
//  Copyright © 2018年 com.snailgames. All rights reserved.
//

#import "MainViewController.h"
#import "BaseNavigationViewController.h"
#import "WeatherViewController.h"
#import "SportsInfoViewController.h"
#import "NewsViewController.h"
#import "MenuDelegate.h"

@interface MainViewController ()<MenusDelegate>

@property (strong, nonatomic) WeatherViewController *weatherView;
@property (strong, nonatomic) SportsInfoViewController *sportsView;
@property (strong, nonatomic) NewsViewController *newsView;

@end


@implementation MainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _weatherView = [WeatherViewController new];
    _sportsView = [SportsInfoViewController new];
    _newsView = [NewsViewController new];

    _weatherView.delegate = self;
    
    [self setupChildViewController:@"天气" viewController:_weatherView image:@"v2_home" selectedImage:@"v2_home_r"];
    [self setupChildViewController:@"体育" viewController:_sportsView image:@"v2_order" selectedImage:@"v2_order_r"];
    [self setupChildViewController:@"头条" viewController:_newsView image:@"shopCart" selectedImage:@"shopCart_r"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupChildViewController:(NSString *)title
                  viewController:(UIViewController *)controller
                           image:(NSString *)image
                   selectedImage:(NSString *)selectedImage {
    
    UITabBarItem *item = [[UITabBarItem alloc]init];
    item.image = [UIImage imageNamed:image];
    item.selectedImage = [UIImage imageNamed:selectedImage];
    item.title = title;
    controller.tabBarItem = item;
    controller.title = title;
    BaseNavigationViewController *naController = [[BaseNavigationViewController alloc] initWithRootViewController:controller];
    [self addChildViewController:naController];
}

#pragma -mark MenusDelegate
- (void)openMenuViewController{
    [UIView animateWithDuration:0.5 animations:^{
        [self.view setFrame:CGRectMake(300, 0, self.view.frame.size.width, self.view.frame.size.height)];
    }];
}

- (void)closeMenuController{
    [UIView animateWithDuration:0.5 animations:^{
        [self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    }];
}

- (void)cityWeatherCallBack:(NSString *)cityname{
//    NSLog(@"cityname:%@", cityname);
    
}

@end
