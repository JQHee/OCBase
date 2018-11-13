//
//  MLCityListHeaderView.m
//  CityListDemo
//
//  Created by midland on 2018/11/12.
//  Copyright © 2018年 midland. All rights reserved.
//

#import "MLCityListHeaderView.h"

@implementation MLCityListHeaderView

+ (instancetype)loadNib {
    return [[NSBundle mainBundle] loadNibNamed:@"MLCityListHeaderView" owner:self options:nil].lastObject;
}

@end
