//
//  WeatherViewController.m
//  TheWeather
//
//  Created by shenjie on 2018/1/9.
//  Copyright © 2018年 com.snailgames. All rights reserved.
//

#import "WeatherViewController.h"
#import "GYZChooseCityController.h"

@interface WeatherViewController ()

@end

@implementation WeatherViewController
@synthesize guesture = _guesture;
@synthesize customWeatherView = _customWeatherView;
@synthesize screenImage = _screenImage;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    [self.view setBackgroundColor:[UIColor clearColor]];
    [self requestWeatherInfo];
    [self initScreenImage];
    [self initWeatherVisibleView];
    [self initHerderView];
    [self addGuestureCtrl];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 *@brief 请求天气数据
 */
- (void)requestWeatherInfo{
    
}

- (CustomCollectionView *)customWeatherView{
    if(!_customWeatherView){
        _customWeatherView = [[CustomCollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    }
    
    return _customWeatherView;
}

/*
 * @brief 初始化壁纸
 */
- (void)initScreenImage{
    self.screenImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Eiffel"]];
    self.screenImage.contentMode = UIViewContentModeScaleAspectFill;
    [self.screenImage setFrame:self.view.bounds];
    [self.view addSubview:self.screenImage];
}

/*
 *@brief 初始化天气可视化视图
 */
- (void)initWeatherVisibleView{
    [self.view addSubview:[self customWeatherView]];
}

/*
 * @brief 初始化headerView
 */
- (void)initHerderView{
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];
    [self.headerView setBackgroundColor:[UIColor clearColor]];
    
    self.settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.settingBtn setFrame:CGRectMake(20, 30, 50, 30)];
    [self.settingBtn setTitle:@"设置" forState:UIControlStateNormal];
    [self.settingBtn setBackgroundColor:[UIColor blueColor]];
    [self.settingBtn addTarget:self action:@selector(slideControllerView:) forControlEvents:UIControlEventTouchUpInside];
    
    self.addCityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addCityBtn setFrame:CGRectMake(self.view.bounds.size.width - 50 - 30, 30, 50, 30)];
    [self.addCityBtn setTitle:@"添加" forState:UIControlStateNormal];
    [self.addCityBtn setBackgroundColor:[UIColor blueColor]];
    [self.addCityBtn addTarget:self action:@selector(addCityTempture:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.headerView addSubview:self.settingBtn];
    [self.headerView addSubview:self.addCityBtn];
    [self.view addSubview:self.headerView];
}

/*
 * @brief 添加手势控制
 */
- (void)addGuestureCtrl{
    self.view.userInteractionEnabled = YES;
    _guesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToCloseMenu)];
    _guesture.delegate = self;
    _guesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:_guesture];
}

- (void)tapToCloseMenu{
    [UIView animateWithDuration:0.15f animations:^{
        [_delegate closeMenuController];
    }];
}

/*
 * @brief 主视图侧滑，显示设置视图，
 */
- (void)slideControllerView:(id)sender{
    [UIView animateWithDuration:0.15f animations:^{
        [_delegate openMenuViewController];
    }];
}

/*
 * @brief 添加城市天气信息
 */
- (void)addCityTempture:(id)sender{
    GYZChooseCityController *cityPickerVC = [[GYZChooseCityController alloc] init];
    [cityPickerVC setDelegate:self];

    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:cityPickerVC] animated:YES completion:^{
        
    }];
}

#pragma mark - GYZCityPickerDelegate
- (void) cityPickerController:(GYZChooseCityController *)chooseCityController didSelectCity:(GYZCity *)city
{
//    [chooseCityBtn setTitle:city.cityName forState:UIControlStateNormal];
    [chooseCityController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void) cityPickerControllerDidCancel:(GYZChooseCityController *)chooseCityController
{
    [chooseCityController dismissViewControllerAnimated:YES completion:^{
        
    }];
}
@end
