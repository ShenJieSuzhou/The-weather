//
//  CustomCollectionView.m
//  CoolFrame
//
//  Created by silicon on 2017/10/2.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import "CustomCollectionView.h"
#import "CustomFlowLayout.h"
#import "CustomCollectionViewCell.h"
#import "GlobalDefine.h"
#import "CurrentWeatherViewCell.h"
#import "DailyForecastViewCell.h"
#import "WeatherDetailViewCell.h"
#import "Masonry.h"
#import "WeatherIconIdentifier.h"


@implementation CustomCollectionView
@synthesize delegate = _delegate;
@synthesize currentWeather = _currentWeather;
@synthesize futureWeather = _futureWeather;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _itemArray = [[NSMutableArray alloc] init];
        [self setBackgroundColor:[UIColor clearColor]];
        [self addSubview:[self collectionView]];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_collectionView setFrame:self.bounds];
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        //自动网格布局
        CustomFlowLayout * flowLayout = [[CustomFlowLayout alloc] init];
        //网格布局
        _collectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:flowLayout];
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.backgroundColor = [UIColor clearColor];
        
        // 注册cell
        UINib *dailyForecastNib = [UINib nibWithNibName:@"DailyForecastViewCell"
                                                      bundle: [NSBundle mainBundle]];
        [_collectionView registerNib:dailyForecastNib forCellWithReuseIdentifier:@"DailyForecastViewCell"];
        
        UINib *nib = [UINib nibWithNibName:@"CurrentWeatherViewCell"
                                    bundle: [NSBundle mainBundle]];
        [_collectionView registerNib:nib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CurrentWeatherViewCell"];
        
        UINib *indexWeatherNib = [UINib nibWithNibName:@"WeatherDetailViewCell"
                                    bundle: [NSBundle mainBundle]];
        [_collectionView registerNib:indexWeatherNib forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"WeatherDetailViewCell"];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }

    return _collectionView;
}

- (void)setItemArray:(NSMutableArray *)itemArray{
    _itemArray = [itemArray copy];
}

- (void)setFutureWeather:(FutureWeatherInfo *)futureWeather{
    if(!futureWeather){
        return;
    }
    
    _futureWeather = futureWeather;
    [_collectionView reloadData];
}

- (void)setCurrentWeather:(CurrentWeatherInfo *)currentWeather{
    if(!currentWeather){
        return;
    }
    
    _currentWeather = currentWeather;
    [_collectionView reloadData];
}
/*
 * @brief 设置 HeadCollectionViewCell frame 大小
 */
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(self.bounds.size.width, self.bounds.size.height - 120); // 设置headerView的宽高
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    return CGSizeMake(self.bounds.size.width, 450);
}

#pragma mark - collectionViewDelegate
//有多少的分组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//每个分组里有多少个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   
    if([[self delegate] respondsToSelector:@selector(collectionView:didSelectItemAtIndex:)]){
        [_delegate collectionView:self didSelectItemAtIndex:indexPath.item];
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DailyForecastViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DailyForecastViewCell" forIndexPath:indexPath];
    
    [cell setForecastArray:self.futureWeather.weatherArray];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
         CurrentWeatherViewCell *headerCell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CurrentWeatherViewCell" forIndexPath:indexPath];
        
        //加载数据
        [headerCell.tempture setText:[NSString stringWithFormat:@"%@℃",self.currentWeather.tempture]];
        [headerCell.weather setText:self.currentWeather.weather];
        [headerCell.windOritation setText:self.currentWeather.windDirection];
        [headerCell.windStrength setText:self.currentWeather.windStrength];
        [headerCell.humidity setText:self.currentWeather.humidity];
        [headerCell.time setText:[NSString stringWithFormat:@"%@发布",self.currentWeather.time]];
        
        WeatherInfo *today = [self.futureWeather.weatherArray objectAtIndex:0];
        WeatherInfo *tommorrow = [self.futureWeather.weatherArray objectAtIndex:1];
        [headerCell.range1 setText:today.temperature];
        [headerCell.weather1 setText:today.weather];
        [headerCell.icon1 setImage:[UIImage imageNamed:[[WeatherIconIdentifier getInstance] requestWeatherIcon:today.weather]]];
        
        [headerCell.range2 setText:tommorrow.temperature];
        [headerCell.weather2 setText:tommorrow.weather];
        [headerCell.icon2 setImage:[UIImage imageNamed:[[WeatherIconIdentifier getInstance] requestWeatherIcon:tommorrow.weather]]];
        return headerCell;
        
    }else if([kind isEqualToString:UICollectionElementKindSectionFooter]){
        WeatherDetailViewCell *footerCell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"WeatherDetailViewCell" forIndexPath:indexPath];
        [footerCell.indexTableView setFrame:CGRectMake(0, 0, self.bounds.size.width, 450)];
        [footerCell setCurrentWeather:self.currentWeather];
        return footerCell;
    }
   
    return nil;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_delegate collectionView:self didScroll:YES];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [_delegate collectionView:self endScroll:NO];
}


@end
