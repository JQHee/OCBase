//
//  MLCityListHotTableViewCell.m
//  CityListDemo
//
//  Created by midland on 2018/11/12.
//  Copyright © 2018年 midland. All rights reserved.
//

#import "MLCityListHotTableViewCell.h"
#import "MLCityListHotCell.h"

@interface MLCityListHotTableViewCell () <UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation MLCityListHotTableViewCell

static NSString *kCellID = @"MLCityListHotCell";

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupUI];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// MARK: - Private methods
- (void) setupUI {
    [self setupCollectionView];
}

- (void) setupCollectionView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat width = (UIScreen.mainScreen.bounds.size.width - 5 * 10) / 3.0;
    CGFloat height = 30.0;
    layout.itemSize = CGSizeMake(width, height);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    [self.collectionView setCollectionViewLayout:layout];
    [self.collectionView setScrollEnabled:NO];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerNib:[UINib nibWithNibName:kCellID bundle:nil] forCellWithReuseIdentifier:kCellID];
}

// MARK: - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MLCityListHotCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@", _datas[indexPath.row]];
    return cell;
}

// MARK: - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

// MARK: - Getter and Setter
- (void)setDatas:(NSArray *)datas {
    _datas = datas;
}

@end
