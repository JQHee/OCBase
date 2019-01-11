//
//  UIScrollView+Refresh.m
//  OCBase
//
//  Created by midland on 2019/1/11.
//  Copyright © 2019年 HJQ. All rights reserved.
//

#import "UIScrollView+Refresh.h"
#import "MJRefresh.h"
#import "Global.h"

@implementation UIScrollView (Refresh)

- (void)bf_addRefreshHeader:(void (^)(void))blockH footer:(void (^)(void))blockF {
    @weakify(self);
    [self bf_addRefreshHeader:^{
        if (blockH) blockH();
    } endRefresh:^{
        @strongify(self);
        if (!self.mj_footer) {
            [self bf_addRefreshFooter:^{
                if (blockF) blockF();
            }];
        }
    }];
}

- (void)bf_addRefreshHeader:(void (^)(void))block {
    [self bf_addRefreshHeader:block endRefresh:nil];
}

- (void)bf_addRefreshHeader:(void (^)(void))block endRefresh:(void (^)(void))endRefresh {
    
    @weakify(self);
    MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        BOOL isRefresh = self.mj_footer.state == MJRefreshStateRefreshing || self.mj_footer.state == MJRefreshStateWillRefresh || self.mj_footer.state == MJRefreshStatePulling;
        if (isRefresh) {
            [self.mj_header endRefreshing];
            return;
        }
        if (block) block();
    }];
    [refreshHeader setEndRefreshingCompletionBlock:^{
        if (endRefresh) endRefresh();
    }];
    
    refreshHeader.lastUpdatedTimeLabel.hidden = YES;
    refreshHeader.stateLabel.font = [UIFont systemFontOfSize:12];
    refreshHeader.stateLabel.textColor = [UIColor lightGrayColor];
    
    self.mj_header = refreshHeader;
}

- (void)bf_addRefreshFooter:(void (^)(void))block {
    
    @weakify(self);
    MJRefreshAutoNormalFooter *refreshFooter = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        BOOL isRefresh = self.mj_header.state == MJRefreshStateRefreshing || self.mj_header.state == MJRefreshStateWillRefresh || self.mj_header.state == MJRefreshStatePulling;
        if (isRefresh) {
            [self.mj_footer endRefreshing];
            return;
        }
        if (block) block();
    }];
    
    refreshFooter.automaticallyChangeAlpha = YES;
    refreshFooter.stateLabel.font = [UIFont systemFontOfSize:12];
    refreshFooter.stateLabel.textColor = [UIColor lightGrayColor];
    [refreshFooter setTitle:@"别扯了，已经到底了~" forState:MJRefreshStateNoMoreData];
    
    self.mj_footer = refreshFooter;
}

@end
