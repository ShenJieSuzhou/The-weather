//
//  WeatherViewController.m
//  TheWeather
//
//  Created by shenjie on 2018/1/9.
//  Copyright © 2018年 com.snailgames. All rights reserved.
//

#import "WeatherViewController.h"
#import "GYZChooseCityController.h"
#import "LocationController.h"
#import <AFNetworking/AFURLRequestSerialization.h>
#import <AFNetworking/AFHTTPSessionManager.h>
#import "JSONKit.h"


@interface WeatherViewController ()

@end

@implementation WeatherViewController
@synthesize guesture = _guesture;
@synthesize customWeatherView = _customWeatherView;
@synthesize screenImage = _screenImage;
@synthesize locationView = _locationView;
@synthesize currentWeatherInfo = _currentWeatherInfo;
@synthesize futureWeatherInfo = _futureWeatherInfo;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    [self.view setBackgroundColor:[UIColor clearColor]];
    [self automaticLocation];
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
 *@brief 自动定位地理位置
 */
- (void)automaticLocation{
    __weak typeof(self) weakSelf = self;
    [[LocationController getInstance] startLocation:^(NSString *cityName) {
        [weakSelf.locationView.locationTitle setText:cityName];
        [weakSelf requestWeatherInfo:cityName];
    }];
}

/*
 *@brief 请求天气数据
 */
- (void)requestWeatherInfo:(NSString *)city{
    //转菊花
    __weak typeof(self) weakSelf = self;
    
    NSString *URLString = @"http://v.juhe.cn/weather/index";
    NSDictionary *parameters = @{@"cityname": city, @"key": @"6a307cf1b884c41f6d3abe0c21f63469"};
   
    //初始化manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *weatherData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        
        //解析天气数据
        [weakSelf paraseWeatherData:weatherData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //提示网络请求失败，检查网络
        NSLog(@"请求失败");
    }];
}

- (CustomCollectionView *)customWeatherView{
    if(!_customWeatherView){
        _customWeatherView = [[CustomCollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    }
    
    return _customWeatherView;
}

/*
 * @brief 初始化壁纸（随机显示）
 */
- (void)initScreenImage{
    self.screenImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Eiffel"]];
    self.screenImage.contentMode = UIViewContentModeScaleAspectFill;
    [self.screenImage setFrame:self.view.bounds];
    [self.view addSubview:self.screenImage];
}

/*
 * @brief 解析天气数据
 */
- (void)paraseWeatherData:(NSDictionary *)weather{
    NSDictionary *result = [weather objectForKey:@"result"];
    NSDictionary *sk = [result objectForKey:@"sk"];
    NSDictionary *today = [result objectForKey:@"today"];
    NSDictionary *future = [result objectForKey:@"future"];
    
    //初始化未来几天天气
    [self initForecastWeather:future];
    //初始化当前的天气
    [self initCurrentWeather:today withSK:sk];
}

/*
 * @brief 初始化当前天气
 */
- (void)initCurrentWeather:(NSDictionary *)weather withSK:(NSDictionary *)sk{
    self.currentWeatherInfo = [[CurrentWeatherInfo alloc] init];
    [self.currentWeatherInfo initWeatherWithSK:sk];
    [self.currentWeatherInfo initWithWeatherInfo:weather];
}

/*
 *@brief 初始化未来几天天气
 */
- (void)initForecastWeather:(NSDictionary *)weather{
    NSArray *futureArray = [weather objectForKey:@"future"];
    self.futureWeatherInfo = [[FutureWeatherInfo alloc] init];
    [self.futureWeatherInfo initWithWeatherInfo:futureArray];
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
    
    self.shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.shareBtn setFrame:CGRectMake(self.view.bounds.size.width - 40- 20, 20, 40, 40)];
    [self.shareBtn setBackgroundImage:[UIImage imageNamed:@"icon-flyout-iphone"] forState:UIControlStateNormal];
    [self.shareBtn setBackgroundColor:[UIColor clearColor]];
    [self.shareBtn addTarget:self action:@selector(shareWeather:) forControlEvents:UIControlEventTouchUpInside];
    
    self.locationView = [[LocationView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 150)/2, 30, 150, 20)];
    [self.locationView.locationTitle setText:@"正在定位"];
    [self.locationView.addImage setImage:[UIImage imageNamed:@"editlocplus"]];
    [self.locationView.locateImage setImage:[UIImage imageNamed:@"currentlocation"]];
    
    self.settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.settingBtn setFrame:CGRectMake(20, 30, 20, 20)];
    [self.settingBtn setBackgroundImage:[UIImage imageNamed:@"icon-moreinfo-ipad"] forState:UIControlStateNormal];
    [self.settingBtn setBackgroundColor:[UIColor clearColor]];
    [self.settingBtn addTarget:self action:@selector(slideControllerView:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.headerView addSubview:self.settingBtn];
    [self.headerView addSubview:self.locationView];
     [self.headerView addSubview:self.shareBtn];
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

/*
 * @brief  分享天气
 */
- (void)shareWeather:(id)sender{
    NSLog(@"分享");
}

#pragma mark - GYZCityPickerDelegate
- (void) cityPickerController:(GYZChooseCityController *)chooseCityController didSelectCity:(GYZCity *)city
{
    [chooseCityController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void) cityPickerControllerDidCancel:(GYZChooseCityController *)chooseCityController
{
    [chooseCityController dismissViewControllerAnimated:YES completion:^{
        
    }];
}
@end
