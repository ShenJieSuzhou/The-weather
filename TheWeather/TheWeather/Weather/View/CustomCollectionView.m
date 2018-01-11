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

@implementation CustomCollectionView
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _itemArray = [[NSMutableArray alloc] init];
        [self setBackgroundColor:[UIColor whiteColor]];
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
        [_collectionView registerClass:[CurrentWeatherViewCell class] forCellWithReuseIdentifier:@"CurrentWeatherViewCell"];
//        [_collectionView registerClass:[CurrentWeatherViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CurrentWeatherViewCell"];
        UINib *nib = [UINib nibWithNibName:@"CurrentWeatherViewCell"
                                    bundle: [NSBundle mainBundle]];
        [_collectionView registerNib:nib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CurrentWeatherViewCell"];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }

    return _collectionView;
}

- (void)setItemArray:(NSMutableArray *)itemArray{
    _itemArray = [itemArray copy];
}

/*
 * @brief 设置 HeadCollectionViewCell frame 大小
 */
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(self.bounds.size.width, self.bounds.size.height); // 设置headerView的宽高
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

    CurrentWeatherViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentWeatherViewCell" forIndexPath:indexPath];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    CurrentWeatherViewCell *cell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CurrentWeatherViewCell" forIndexPath:indexPath];

    return cell;
}

@end
