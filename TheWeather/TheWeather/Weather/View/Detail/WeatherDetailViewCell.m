//
//  WeatherDetailViewCell.m
//  TheWeather
//
//  Created by shenjie on 2018/1/15.
//  Copyright © 2018年 com.snailgames. All rights reserved.
//

#import "WeatherDetailViewCell.h"
#import "WeatherIndexViewCell.h"

@implementation WeatherDetailViewCell

@synthesize indexTableView = _indexTableView;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _indexTableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
    [_indexTableView setBackgroundColor:[UIColor clearColor]];
    _indexTableView.dataSource = self;
    _indexTableView.delegate = self;
    [self addSubview:self.indexTableView];
}

- (void)layoutSubviews{
    [super layoutSubviews];

}

#pragma mark -tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int rows = 5;
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WeatherIndexViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WeatherIndexViewCell"];
    if (!cell) {
         cell = (WeatherIndexViewCell *)[[[NSBundle mainBundle] loadNibNamed:@"WeatherIndexViewCell" owner:self options:nil] lastObject];
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma mark -tableViewDelegate
// Variable height support
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if([self tableView:tableView viewForHeaderInSection:section]){
        return [self tableView:tableView viewForHeaderInSection:section].frame.size.height;
    }else{
        return 0.0;
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 60.0f)];
    [headView setBackgroundColor:[UIColor clearColor]];
    headView.layer.borderWidth = 0;
    
    UILabel *headviewTitle = [[UILabel alloc] init];
    [headView addSubview:headviewTitle];
    
    NSString *headTitle = @"天气冷，建议着棉服、羽绒服、皮夹克加羊毛衫等冬季服装。年老体弱者宜着厚棉衣、冬大衣或厚羽绒服。";
    [headviewTitle setFrame:CGRectMake(20, 10, tableView.frame.size.width - 40, 40)];
    [headviewTitle setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    [headviewTitle setTextColor:[UIColor whiteColor]];
    [headviewTitle setText:headTitle];
    headviewTitle.numberOfLines = 0;
    return headView;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 10)];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 10, 0, 10)];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


@end
