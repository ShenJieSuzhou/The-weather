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
#import <SDWebImage/SDWebImageManager.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "GlobalDefine.h"
#import "ConstantIndex.h"
#import "MainViewController.h"


@interface WeatherViewController ()

@end

@implementation WeatherViewController
@synthesize guesture = _guesture;
@synthesize customWeatherView = _customWeatherView;
@synthesize screenImage = _screenImage;
@synthesize locationView = _locationView;
@synthesize currentWeatherInfo = _currentWeatherInfo;
@synthesize futureWeatherInfo = _futureWeatherInfo;
@synthesize freshTimer = _freshTimer;
@synthesize hudView = _hudView;
@synthesize hudView1 = _hudView1;
@synthesize locateCity = _locateCity;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    [self.view setBackgroundColor:[UIColor clearColor]];

    //初始化数据
    [self initLocationBingAndWeather];
}

- (CustomCollectionView *)customWeatherView{
    if(!_customWeatherView){
        _customWeatherView = [[CustomCollectionView alloc] initWithFrame:CGRectMake(0, 70, self.view.bounds.size.width, self.view.bounds.size.height)];
    }
    
    return _customWeatherView;
}

/*
 * @brief 初始化定位，壁纸以及天气数据信息
 */
- (void)initLocationBingAndWeather{
    //设置加载项
    self.hudView = [[JHUD alloc]initWithFrame:self.view.bounds];
    self.hudView1 = [[JHUD alloc]initWithFrame:self.view.bounds];
    
    __weak typeof(self)  _weakSelf = self;
    [self.hudView setJHUDReloadButtonClickedBlock:^() {
        NSLog(@"refreshButton");
        [_weakSelf requestWeatherInfo:_weakSelf.locateCity];
    }];
    
    [self.hudView1 setJHUDReloadButtonClickedBlock:^() {
        NSLog(@"refreshButton");
        [_weakSelf initScreenImage];
    }];
    
    
    //初始化数据
    [self automaticLocation];
    [self initScreenImage];
    [self initHerderView];
    [self addGuestureCtrl];
    
    //添加一个定时器，每一个小时刷新一遍数据
    _freshTimer = [NSTimer scheduledTimerWithTimeInterval:60*60.0 target:self selector:@selector(freshData) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_freshTimer forMode:NSDefaultRunLoopMode];
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
    [ConstantIndex getInstance].locationFlag = NO;
    [[LocationController getInstance] startLocation:self block:^(NSString *cityName) {
        weakSelf.locateCity = cityName;
        [weakSelf.locationView.locationTitle setText:cityName];
        [weakSelf requestWeatherInfo:cityName];
    }];
}

/*
 *@brief 请求天气数据
 */
- (void)requestWeatherInfo:(NSString *)city{
    //转菊花
    [_hudView showAtView:self.view hudType:JHUDLoadingTypeCircle];
    _hudView.messageLabel.text = @"";
    _hudView.indicatorViewSize = CGSizeMake(100, 100);
    
    __weak typeof(self) weakSelf = self;
    
    NSString *URLString = @"http://v.juhe.cn/weather/index";
    NSDictionary *parameters = @{@"cityname": city, @"key": @"6a307cf1b884c41f6d3abe0c21f63469"};
   
    //初始化manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *weatherData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        
        if(!weatherData) return ;
        
        if([[weatherData objectForKey:@"error_code"] intValue] != 0){
            weakSelf.hudView.indicatorViewSize = CGSizeMake(100, 100);
            weakSelf.hudView.messageLabel.text = @"请求数据失败!";
            [weakSelf.hudView.refreshButton setTitle:@"刷新" forState:UIControlStateNormal];
            weakSelf.hudView.customImage = [UIImage imageNamed:@"failed"];
            [weakSelf.hudView showAtView:self.view hudType:JHUDLoadingTypeFailure];
            return;
        }
        
        //回调给 MainViewController 添加城市
        [[NSNotificationCenter defaultCenter] postNotificationName:CITYNAME_CALLBACK object:city];
        
        //解析天气数据
        [weakSelf paraseWeatherData:weatherData];
        //hide
        [weakSelf.hudView hide];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //提示网络请求失败，检查网络
        weakSelf.hudView.indicatorViewSize = CGSizeMake(100, 100);
        weakSelf.hudView.messageLabel.text = @"网络请求失败，请检查网络!";
        [weakSelf.hudView.refreshButton setTitle:@"刷新" forState:UIControlStateNormal];
        weakSelf.hudView.customImage = [UIImage imageNamed:@"failed"];
        [weakSelf.hudView showAtView:self.view hudType:JHUDLoadingTypeFailure];
    }];
}

/*
 * @brief 获取bing每日壁纸
 */
- (void)initScreenImage{
    
    self.screenImage = [[UIImageView alloc] init];
    self.screenImage.contentMode = UIViewContentModeScaleAspectFill;
    [self.screenImage setFrame:self.view.bounds];
    [self.screenImage setImage:[UIImage imageNamed:@"placeholder"]];
    [self.view addSubview:self.screenImage];
    
    __weak typeof(self) weakSelf = self;
    _xmlUtil = [[XMLUtil alloc] init];

    //初始化manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:BING parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf.xmlUtil parse:responseObject block:^(NSString *imageName) {
            NSString *url = [[NSString stringWithFormat:@"http://s.cn.bing.net%@", imageName] stringByAppendingString:@"_720x1280.jpg"];
            
            [weakSelf.screenImage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeholder"] options:SDWebImageRetryFailed];
        }];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //提示网络请求失败，检查网络
        NSLog(@"壁纸加载失败");
    }];
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
    
    [self initWeatherVisibleView];
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
    self.futureWeatherInfo = [[FutureWeatherInfo alloc] init];
    [self.futureWeatherInfo initWithWeatherInfo:weather];
}

/*
 *@brief 初始化天气可视化视图
 */
- (void)initWeatherVisibleView{
    self.customWeatherView.delegate = self;
    [[self customWeatherView] setCurrentWeather:self.currentWeatherInfo];
    [[self customWeatherView] setFutureWeather:self.futureWeatherInfo];
    [self.view addSubview:[self customWeatherView]];
}

/*
 * @brief 初始化headerView
 */
- (void)initHerderView{
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];
    [self.headerView setBackgroundColor:[UIColor clearColor]];
    
    self.shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.shareBtn setFrame:CGRectMake(self.view.bounds.size.width - 40- 20, 28, 18, 22)];
    [self.shareBtn setBackgroundImage:[UIImage imageNamed:@"GiftShare_icon_18x22_"] forState:UIControlStateNormal];
    [self.shareBtn setBackgroundColor:[UIColor clearColor]];
    [self.shareBtn addTarget:self action:@selector(shareWeather:) forControlEvents:UIControlEventTouchUpInside];
    
    self.locationView = [[LocationView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 150)/2, 30, 150, 20)];
    self.locationView.delegate = self;
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

/*
 * @brief 设置城市名称
 */
- (void)setCityName:(NSString *)name{
    self.locateCity = name;
    [self.locationView.locationTitle setText:self.locateCity];
    [self requestWeatherInfo:self.locateCity];
}

#pragma mark - freshData
- (void)freshData{
    //刷新地理位置
    [self automaticLocation];
    //刷新壁纸
    [self initScreenImage];
}

#pragma mark - LocationTapDelegate
- (void)LocationDidTapView:(LocationView *)view{
    // 添加城市天气信息
    GYZChooseCityController *cityPickerVC = [[GYZChooseCityController alloc] init];
    [cityPickerVC setDelegate:self];
    
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:cityPickerVC] animated:YES completion:^{
        
    }];
}

#pragma mark - GYZCityPickerDelegate
- (void) cityPickerController:(GYZChooseCityController *)chooseCityController didSelectCity:(GYZCity *)city
{
    [self.locationView.locationTitle setText:city.cityName];
    [self requestWeatherInfo:city.cityName];
    
    [chooseCityController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void) cityPickerControllerDidCancel:(GYZChooseCityController *)chooseCityController
{
    [chooseCityController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - CustomCollectionViewDelegate
- (void)collectionView:(CustomCollectionView *)collectionView didSelectItemAtIndex:(NSInteger)index{
    
}

- (void)collectionView:(CustomCollectionView *)collectionView didScroll:(BOOL)scroll{
    MainViewController *main = (MainViewController *)self.parentViewController.parentViewController;
    [UIView animateWithDuration:0.5 animations:^{
        [main.tabBar setHidden:YES];
    }];
}

- (void)collectionView:(CustomCollectionView *)collectionView endScroll:(BOOL)scroll{
    MainViewController *main = (MainViewController *)self.parentViewController.parentViewController;
    [UIView animateWithDuration:0.5 animations:^{
         [main.tabBar setHidden:NO];
    }];
}

@end
