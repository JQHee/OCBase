//
//  MLCityListHotTableViewCell.h
//  CityListDemo
//
//  Created by midland on 2018/11/12.
//  Copyright © 2018年 midland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLCityListHotTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *datas;

@end
