//
//  MenuViewController.m
//  TheWeather
//
//  Created by shenjie on 2018/1/9.
//  Copyright © 2018年 com.snailgames. All rights reserved.
//

#import "MenuViewController.h"
#import "MainViewController.h"
#import "GlobalDefine.h"
#import "MenuViewCell.h"


@interface MenuViewController ()
@property (strong, nonatomic) MainViewController *mainView;

@end

@implementation MenuViewController
@synthesize closeBtn = _closeBtn;
@synthesize tableDataArray = _tableDataArray;
@synthesize menuTableView = _menuTableView;
@synthesize settingArray = _settingArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.closeBtn setFrame:CGRectMake(200, 50, 50, 50)];
//    [self.closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
//    [self.closeBtn setBackgroundColor:[UIColor blueColor]];
//    [self.closeBtn addTarget:self action:@selector(closeTheMenus:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.closeBtn];
    
    // 添加监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addCityCallBack:) name:CITYNAME_CALLBACK object:nil];
    
    //初始化 “城市”
    self.tableDataArray = [[NSMutableArray alloc] init];
    
    //初始化 “工具” 菜单
    self.settingArray = [[NSMutableArray alloc] initWithObjects:@"设置", @"意见和建议", @"给此应用程序打分", nil];
    
    //添加菜单视图
    _menuTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    _menuTableView.delegate = self;
    _menuTableView.dataSource = self;
    [_menuTableView setBackgroundColor:RGB(220, 220, 220)];
    [self.view addSubview:_menuTableView];
    
    //添加天气主界面
    _mainView = [MainViewController new];
    [self.view setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:_mainView.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)closeTheMenus:(id)sender{
    [UIView animateWithDuration:0.5 animations:^{
        [_mainView.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    }];
}


#pragma mark -tableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //根据 json 模版 决定每个 section 要显示几行数据
    int tid = (int)section;
    int rows = 0;
    
    if(tid == 0){
        rows = 1;
    }else if(tid == 1){
        rows = (int)_tableDataArray.count;
    }else if(tid == 2){
        rows = 3;
    }
    
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    /*
     *  default cell pattern
     */
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    if(indexPath.section == 0){
        MenuViewCell *productCell = [tableView dequeueReusableCellWithIdentifier:@"loginmenucell"];
        if(!productCell){
            productCell = [[MenuViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"loginmenucell"];
        }
    
         [productCell.textLabel1 setText:@"登录"];
        
        return productCell;
        
    }else if(indexPath.section == 1){
        MenuViewCell *productCell = [tableView dequeueReusableCellWithIdentifier:@"citymenucell"];
        if(!productCell){
            productCell = [[MenuViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"citymenucell"];
        }
        
        NSString *cityName = [_tableDataArray objectAtIndex:indexPath.row];
        [productCell.textLabel1 setText:cityName];
        
        return productCell;
    }else if(indexPath.section == 2){
        MenuViewCell *productCell = [tableView dequeueReusableCellWithIdentifier:@"toolmenucell"];
        if(!productCell){
            productCell = [[MenuViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"toolmenucell"];
        }
        
        NSString *settingName = [_settingArray objectAtIndex:indexPath.row];
        [productCell.textLabel1 setText:settingName];
        
        return productCell;
    }
    
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"defaultCell"];
    return cell;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
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
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 42.0f)];
    [headView setBackgroundColor:[UIColor whiteColor]];
    headView.layer.borderWidth = 0;
    
    UILabel *headviewTitle = [[UILabel alloc] init];
    [headviewTitle setFont:[UIFont systemFontOfSize:15.0f]];
    headviewTitle.backgroundColor = [UIColor clearColor];
    
    //添加栏目名称
    [headView addSubview:headviewTitle];
    
    int tid = (int)section;
    if(tid == 0 || tid == 1){
        return nil;
    }
    
    NSString *headTitle = @"工具";
    [headviewTitle setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13]];
    [headviewTitle setFrame:CGRectMake(20, 12, 80, 20)];
    [headviewTitle setText:headTitle];
    return headView;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

#pragma -mark notification
- (void)addCityCallBack:(NSNotification *)notification {
    NSString *cityname = (NSString *)notification.object;
    [self.tableDataArray addObject:cityname];
    [_menuTableView reloadData];
}

@end
