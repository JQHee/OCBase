//
//  MLCityListHotCell.m
//  CityListDemo
//
//  Created by midland on 2018/11/12.
//  Copyright © 2018年 midland. All rights reserved.
//

#import "MLCityListHotCell.h"

@implementation MLCityListHotCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.nameLabel.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
    self.nameLabel.layer.masksToBounds = YES;
    self.nameLabel.layer.cornerRadius = 5.0;
}

@end
