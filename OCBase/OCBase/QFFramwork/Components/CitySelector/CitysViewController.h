//
//  CitysViewController.h
//  MainProject
//
//  Created by MacKun on 16/5/16.
//  Copyright © 2016年 com.soullon.EnjoyLearning. All rights reserved.
//


#import <UIKit/UIKit.h>

/**
 *  城市选择
 */
@interface CitysViewController : UIViewController

@end

/* 数据处理
- (void) initData {
    _hotCities = @[@"全国", @"海外"];
 
     1.接口返回数据处理
     将接口返回的的数据按A~Z进行归类
     [ {"A": [{城市列表的数据}]} ]
     
     2.本地数据处理
     A~Z
     [ {"A": [{暂无数据}]} ]
     
     3.遍历替换
     将接口返回的数据和本地的比较（A-Z）
     如果接口返回数据数据有返回本地的字母，用接口返回的集合替换本地集合
    
    for (char i = 'A'; i <= 'Z'; i++) {
        NSString *key = [NSString stringWithFormat:@"%c", i];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        
        NSMutableArray *cityArray = [NSMutableArray array];
        NSMutableDictionary *itemCity = [NSMutableDictionary dictionary];
        itemCity[@"name"] = @"暂无数据";
        itemCity[@"id"] = @"-1";
        itemCity[@"pinyin"] = @"zanwushuju";
        [cityArray addObject:itemCity];
        dict[@"key"] = key;
        dict[@"items"] = cityArray;
        [self.localCityList addObject:dict];
        [self.sectionIndexList addObject:key];
    }
    
}

// 处理接口成功返回的数据
- (NSArray *) handleRequestSuccess:(NSArray *) dataList {
    
    // 数据进行归类
    NSMutableArray *tempList = [NSMutableArray array];
    [dataList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if(obj[@"pinyin"]) {
            // 获取到拼音字段并截取第一个字段转成大写
            NSString *key = [[obj[@"pinyin"] substringToIndex:1] uppercaseString];
            
            NSMutableDictionary *dict;
            NSMutableArray *cityItem;
            // 是否已经存在
            if ([self isContainKey:key datas:tempList]) {
                dict = [self isContainKey:key datas:tempList];
                cityItem = [NSMutableArray arrayWithArray:dict[@"items"]];
                [cityItem addObject:obj];
                dict[@"key"] = key;
                dict[@"items"] = cityItem;
                
            } else {
                dict = [NSMutableDictionary dictionary];
                cityItem = [NSMutableArray array];
                [cityItem addObject:obj];
                dict[@"key"] = key;
                dict[@"items"] = cityItem;
                [tempList addObject:dict];
            }
            
        } else { // 如果返回的拼音是空（其他）
            
        }
    }];
    // 排序
    NSArray *sortDesc = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"key" ascending:YES]];
    tempList = [[tempList sortedArrayUsingDescriptors:sortDesc] mutableCopy];
    
    return [tempList copy];
}

// 是否已经存在该字母了
- (NSMutableDictionary *) isContainKey:(NSString *)tempKey datas: (NSMutableArray *)datas {
    for (NSMutableDictionary *dict in datas) {
        if ([tempKey isEqualToString:dict[@"key"]]) {
            return dict;
        }
    }
    return nil;
}

// 模拟数据
- (void)simulatedData {
    NSMutableArray *cityArray = [NSMutableArray array];
    NSMutableDictionary *sitemCity = [NSMutableDictionary dictionary];
    sitemCity[@"name"] = @"深圳";
    sitemCity[@"id"] = @"0";
    sitemCity[@"pinyin"] = @"shenzen";
    [cityArray addObject:sitemCity];
    
    NSMutableDictionary *snitemCity = [NSMutableDictionary dictionary];
    snitemCity[@"name"] = @"深南";
    snitemCity[@"id"] = @"-1";
    snitemCity[@"pinyin"] = @"shennan";
    [cityArray addObject:snitemCity];
    
    NSMutableDictionary *gzitemCity = [NSMutableDictionary dictionary];
    gzitemCity[@"name"] = @"广州";
    gzitemCity[@"id"] = @"2";
    gzitemCity[@"pinyin"] = @"guangzhou";
    [cityArray addObject:gzitemCity];
    
    NSArray *tempArrary = [self handleRequestSuccess:cityArray];
    self.cityList = [self.localCityList copy];
    [self.cityList enumerateObjectsUsingBlock:^(NSMutableDictionary *tempObj, NSUInteger idx, BOOL * _Nonnull stop) {
        [tempArrary enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([tempObj[@"key"] isEqualToString:obj[@"key"]]) {
                NSLog(@"%@", tempObj[@"key"]);
                tempObj[@"items"] = [NSArray arrayWithArray:obj[@"items"]];
            }
        }];
    }];
    NSArray *sortDesc = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"key" ascending:YES]];
    self.cityList = [[self.cityList sortedArrayUsingDescriptors:sortDesc] mutableCopy];
    [self.tableView reloadData];
}
*/
