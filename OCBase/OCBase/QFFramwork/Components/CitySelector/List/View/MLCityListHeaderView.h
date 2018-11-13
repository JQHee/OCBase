//
//  MLCityListHeaderView.h
//  CityListDemo
//
//  Created by midland on 2018/11/12.
//  Copyright © 2018年 midland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLCityListHeaderView : UIView

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

+ (instancetype)loadNib;

@end
