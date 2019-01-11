//
//  UIScrollView+Refresh.h
//  OCBase
//
//  Created by midland on 2019/1/11.
//  Copyright © 2019年 HJQ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (Refresh)

- (void)bf_addRefreshHeader:(void(^)(void))block;
- (void)bf_addRefreshFooter:(void(^)(void))block;
- (void)bf_addRefreshHeader:(void(^)(void))blockH footer:(void(^)(void))blockF;

@end

NS_ASSUME_NONNULL_END
