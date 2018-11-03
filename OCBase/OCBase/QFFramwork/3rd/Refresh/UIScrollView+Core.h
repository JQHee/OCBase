//
//  UIScrollView+Core.h
//  OCBase
//
//  Created by HJQ on 2018/11/3.
//  Copyright © 2018 HJQ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (Core)

/**
 下拉刷新
 @param beginRefresh 是否自动刷新
 @param animation 是否需要动画
 @param refreshBlock 刷新回调
 */
- (void)addHeaderWithHeaderWithBeginRefresh:(BOOL)beginRefresh animation:(BOOL)animation refreshBlock:(void(^)(NSInteger pageIndex))refreshBlock;


/**
 上啦加载
 @param automaticallyRefresh 是否自动加载
 @param loadMoreBlock 加载回调
 */
- (void)addFooterWithWithHeaderWithAutomaticallyRefresh:(BOOL)automaticallyRefresh loadMoreBlock:(void(^)(NSInteger pageIndex))loadMoreBlock;

@end

NS_ASSUME_NONNULL_END
