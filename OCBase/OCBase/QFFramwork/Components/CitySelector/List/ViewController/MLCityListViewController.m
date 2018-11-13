//
//  MLCityListViewController.m
//  CityListDemo
//
//  Created by midland on 2018/11/12.
//  Copyright © 2018年 midland. All rights reserved.
//

#import "MLCityListViewController.h"
#import "MLCityListHeaderView.h"
#import "MLCityListTableViewCell.h"
#import "MLCityListHotTableViewCell.h"
#import "MLLocationManager.h"

@interface MLCityListViewController () <UITableViewDataSource, UITableViewDelegate, MLLocationManagerDelegate>
{
    /* 热门城市 */
    NSArray *_hotCities;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) MLLocationManager *locationManager;
@property (nonatomic, copy) NSString *cityNow;

@end

@implementation MLCityListViewController

static NSString *kCityHeaderViewID = @"MLCityListHeaderView";
static NSString *kCityListCellID = @"MLCityListTableViewCell";
static NSString *kCityListHotCellID = @"MLCityListHotTableViewCell";

// MARK: - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self  setupUI];
    [self getLocationInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// MARK: - Private methods
- (void) setupUI {
    [self setupTableView];
}

- (void) initData {
    _hotCities = @[@"深圳市", @"重庆", @"北京", @"上海"];
}

- (void) setupTableView {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerNib:[UINib nibWithNibName:kCityListCellID bundle:nil] forCellReuseIdentifier:kCityListCellID];
    [self.tableView registerNib:[UINib nibWithNibName:kCityListHotCellID bundle:nil] forCellReuseIdentifier:kCityListHotCellID];
    [self.tableView registerNib:[UINib nibWithNibName:kCityHeaderViewID bundle:nil] forHeaderFooterViewReuseIdentifier:kCityHeaderViewID];
}

// 获取定位信息
- (void) getLocationInfo {
    self.locationManager = [[MLLocationManager alloc] init];
    _locationManager.delegate = self;
}

// MARK: - Event response
- (IBAction)backButtonAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma: - UITableViewDataSource methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 20;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return 1;
    } else {
        return 10;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) { // 当前定位城市
        MLCityListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCityListCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:kCityListCellID owner:self options:nil].lastObject;
        }
        cell.nameLabel.text = _cityNow ? _cityNow : @"正在定位中...";
        return cell;
    } else if (indexPath.section == 1) { // 热门城市
        MLCityListHotTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCityListHotCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:kCityListHotCellID owner:self options:nil].lastObject;
        }
        cell.datas = _hotCities;
        return cell;
    } else {
        MLCityListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCityListCellID];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:kCityListCellID owner:self options:nil].lastObject;
        }
        cell.nameLabel.text = @"城市列表";
        return cell;
    }
    return nil;
}

#pragma: - UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) { // 热门城市
        int row = _hotCities.count % 3 == 0 ? _hotCities.count / 3 : _hotCities.count / 3 + 1;
        CGFloat contentHeight = row * 30 + (row - 1) * 10 + 20;
        if (_hotCities.count != 0) {
            return contentHeight;
        }
        return 0;
    }
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    } else {
        return 35;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

// 设置右侧索引的标题，这里返回的是一个数组哦！
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return @[@"A",@"B"];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MLCityListHeaderView *headerView = [MLCityListHeaderView loadNib];
    if (section > 0) {
        if (section == 1) {
            headerView.nameLabel.text = @"热门城市";
        } else {
            headerView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
            headerView.nameLabel.text = @"A";
        }
    }
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section > 1) {
        
    }
}

#pragma mark - MLLocationManagerDelegate 方法

- (void)locating {
    NSLog(@"定位中。。。");
}

//定位成功
- (void)currentLocation:(NSDictionary *)locationDictionary {
    
    NSString *city = [locationDictionary valueForKey:@"City"];
 //   [kCurrentCityInfoDefaults setObject:city forKey:@"locationCity"];
//    [_manager cityNumberWithCity:city cityNumber:^(NSString *cityNumber) {
//        [kCurrentCityInfoDefaults setObject:cityNumber forKey:@"cityNumber"];
//    }];
    _cityNow = city;
    //[self historyCity:city];
    [self.tableView reloadData];
}

@end
