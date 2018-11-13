//
//  MLCityListViewController.h
//  CityListDemo
//
//  Created by midland on 2018/11/12.
//  Copyright © 2018年 midland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLCityListViewController : UIViewController

@end

/* 城市安字母排序
- (void)initlizeDataSource{


    NSString *path = [[NSBundle mainBundle]pathForResource:@"meituan_cities" ofType:@"db"];
    NSLog(@"%@",path);
    SqlDataBase *sql = [[SqlDataBase alloc]init];
    [sql open:path];
    NSString *get_sql_Str = [NSString stringWithFormat:@"SELECT * FROM %@" ,@"city"];
    NSArray *getCityArray = [sql get_table:get_sql_Str];
    for (NSDictionary *dic in getCityArray) {


        ChooseCityModel *model = [[ChooseCityModel alloc]init];
        model.name             = dic[@"name"];
        model.zangwen          = dic[@"zangwen"];
        model.pinyin           = dic[@"pinyin"];
        model.zangpy           = dic[@"zangpy"];
        [self.dataSource addObject:model];
        [self.arrayOfCharacters addObject:[model.pinyin substringToIndex:1]];



    }
    NSSet *set = [NSSet setWithArray:self.arrayOfCharacters];
    self.arrayOfCharacters = [[set allObjects]mutableCopy];
    //排序
    self.arrayOfCharacters = [[self.arrayOfCharacters sortedArrayUsingSelector:@selector(compare:)]mutableCopy];
    self.tempArrayOfCharacters = [self.arrayOfCharacters mutableCopy];


    //    if ([FJShareClass share].setAPPLange == SetLangeToChinese) {

    NSSortDescriptor *sortDescript = [[NSSortDescriptor alloc]initWithKey:@"pinyin" ascending:YES];
    NSArray *sortDescriptors       = [[NSArray alloc] initWithObjects:&sortDescript count:1];

    [self.dataSource sortUsingDescriptors:sortDescriptors];
    //    }

    NSMutableArray *LetterResult = [NSMutableArray array];
    NSMutableArray *item = [NSMutableArray array];
    NSString *tempString;

    //拼音分组
    for (ChooseCityModel* model in self.dataSource) {

        NSString *pinyin = nil;
        pinyin = [model.pinyin substringToIndex:1];
        //不同
        if(![tempString isEqualToString:pinyin])
        {
            //分组
            item = [NSMutableArray array];
            [item  addObject:model];
            [LetterResult addObject:item];
            //遍历
            tempString = pinyin;
        }else//相同
        {

            [item  addObject:model];
        }
    }
    self.dataSource = [LetterResult mutableCopy];
    self.tempDataArray = [self.dataSource mutableCopy];

}
 */
