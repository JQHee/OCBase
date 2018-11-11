//
//  ArrayDataSource.h
//  OCBase
//
//  Created by HJQ on 2018/11/11.
//  Copyright © 2018 HJQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^TableViewCellConfigureBlock)(id cell, id item);

@interface ArrayDataSource : NSObject <UITableViewDataSource>

- (id)initWithItems:(NSArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
 configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END

/* 使用

@property (nonatomic, strong) ArrayDataSource *photosArrayDataSource;

- (void)setupTableView
{
    TableViewCellConfigureBlock configureCell = ^(PhotoCell *cell, Photo *photo) {

        // cell的分类上配置一个model方法
        [cell configureForPhoto:photo];
    };
    NSArray *photos = [AppDelegate sharedDelegate].store.sortedPhotos;
    self.photosArrayDataSource = [[ArrayDataSource alloc] initWithItems:photos
                                                         cellIdentifier:PhotoCellIdentifier
                                                     configureCellBlock:configureCell];
    self.tableView.dataSource = self.photosArrayDataSource;
    [self.tableView registerNib:[PhotoCell nib] forCellReuseIdentifier:PhotoCellIdentifier];
}

 #pragma mark UITableViewDelegate

 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
 PhotoViewController *photoViewController = [[PhotoViewController alloc] initWithNibName:@"PhotoViewController"
 bundle:nil];
 photoViewController.photo = [self.photosArrayDataSource itemAtIndexPath:indexPath];
 [self.navigationController pushViewController:photoViewController animated:YES];
 }
 */
