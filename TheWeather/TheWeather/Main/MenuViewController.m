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
#import "FileUtil.h"


@interface MenuViewController ()
@property (strong, nonatomic) MainViewController *mainView;

@end

@implementation MenuViewController
@synthesize closeBtn = _closeBtn;
@synthesize tableDataArray = _tableDataArray;
@synthesize menuTableView = _menuTableView;
@synthesize settingArray = _settingArray;
@synthesize cityArray = _cityArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 添加监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addCityCallBack:) name:CITYNAME_CALLBACK object:nil];
    
    //初始化 “城市”    
    self.tableDataArray = [[NSMutableArray alloc] initWithContentsOfFile:[FileUtil getFilePath:CITY_CONFIG_FILE]];

    //初始化 “工具” 菜单
    self.settingArray = [[NSMutableArray alloc] initWithObjects:@"设置", @"意见和建议", @"给此应用程序打分", nil];
    
    //添加菜单视图
    _menuTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 300, self.view.frame.size.height) style:UITableViewStyleGrouped];
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
//    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    if(indexPath.section == 0){
        UITableViewCell *loginCell = [tableView dequeueReusableCellWithIdentifier:@"loginmenucell"];
        if(!loginCell){
            loginCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"loginmenucell"];
        }
        
        [loginCell setFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
        [loginCell.textLabel setText:@"登录/注册"];
        [loginCell.textLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [loginCell.imageView setImage:[UIImage imageNamed:@"Dark-Sidebar-Identity-Anonymous-Signed-In"]];
        return loginCell;
        
    }else if(indexPath.section == 1){
         UITableViewCell *cityCell = [tableView dequeueReusableCellWithIdentifier:@"citymenucell"];
        if(!cityCell){
            cityCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"citymenucell"];
        }
        [cityCell setFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
        NSString *cityName = [_tableDataArray objectAtIndex:indexPath.row];
        [cityCell.textLabel setText:cityName];
        [cityCell.textLabel setFont:[UIFont systemFontOfSize:15.0f]];
        
        return cityCell;
    }else if(indexPath.section == 2){
        MenuViewCell *productCell = [tableView dequeueReusableCellWithIdentifier:@"toolmenucell"];
        if(!productCell){
            productCell = [[MenuViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"toolmenucell"];
        }
        [productCell setFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
        NSString *settingName = [_settingArray objectAtIndex:indexPath.row];
        [productCell.textLabel1 setText:settingName];
        [productCell.textLabel1 setFont:[UIFont systemFontOfSize:15.0f]];
        return productCell;
    }
    
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"defaultCell"];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

#pragma mark -tableViewDelegate
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
    [headviewTitle setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    [headviewTitle setFrame:CGRectMake(20, 12, 80, 20)];
    [headviewTitle setText:headTitle];
    return headView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:
(NSIndexPath *)indexPath{
    return @"删除";
}

//设置进入编辑状态时，Cell不会缩进
- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

// UITableViewDataSource协议中定义的方法。该方法的返回值决定某行是否可编辑
- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0 || indexPath.section == 2){
        return NO;
    }
    
    if([_tableDataArray count] <= 1){
        return NO;
    }
    
    return YES;
}

//设置具体的编辑操作（新增，删除）
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ////删除数组中的对应数据,注意list 要是可变的集合才能够进行删除或新增操作
    [_tableDataArray removeObjectAtIndex:indexPath.row];
    
    //tableView刷新 设置tableView带动画效果 删除数据
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]  withRowAnimation:UITableViewRowAnimationFade];
    
    //取消编辑状态
    [tableView setEditing:NO animated:YES];
}


#pragma -mark notification
- (void)addCityCallBack:(NSNotification *)notification {
    NSString *cityname = (NSString *)notification.object;
    if([self.tableDataArray containsObject:cityname]){
        return;
    }
    
    [self.tableDataArray addObject:cityname];
    
    //刷新
    [_menuTableView reloadData];

    //将需要添加的城市写入文件
    NSString *filePath = [FileUtil getFilePath:CITY_CONFIG_FILE];
   if([self.tableDataArray writeToFile:filePath atomically:YES]){

   }
}

@end
