//
//  UIScrollView+Core.m
//  OCBase
//
//  Created by HJQ on 2018/11/3.
//  Copyright © 2018 HJQ. All rights reserved.
//

#import "UIScrollView+Core.h"
#import "MJRefresh.h"
#import <objc/runtime.h>

typedef void(^BFfreshBlock)(NSInteger pageIndex);
typedef void(^BFLoadMoreBlock)(NSInteger pageIndex);

@interface UIScrollView()

/**页码*/
@property (assign, nonatomic) NSInteger pageIndex;
/**下拉时候触发的block*/
@property (nonatomic, copy) BFfreshBlock refreshBlock;
/**上拉时候触发的block*/
@property (nonatomic, copy) BFLoadMoreBlock loadMoreBlock;

@end

@implementation UIScrollView (Core)

- (void)addHeaderWithHeaderWithBeginRefresh:(BOOL)beginRefresh animation:(BOOL)animation refreshBlock:(void (^)(NSInteger))refreshBlock {

    __weak typeof(self) weakSelf = self;
    self.refreshBlock = refreshBlock;

    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf resetPageNum];

        if (weakSelf.refreshBlock) {
            weakSelf.refreshBlock(weakSelf.pageIndex);
        }
        [weakSelf endHeaderRefresh];
    }];

    if (beginRefresh && animation) {
        //有动画的刷新
        [self beginHeaderRefresh];
    }else if (beginRefresh && !animation){
        //刷新，但是没有动画
        [self.mj_header executeRefreshingCallback];
    }

    header.mj_h = 70.0;
    self.mj_header = header;
}

- (void)addFooterWithWithHeaderWithAutomaticallyRefresh:(BOOL)automaticallyRefresh loadMoreBlock:(void (^)(NSInteger))loadMoreBlock {

    self.loadMoreBlock = loadMoreBlock;

    if (automaticallyRefresh) {
        MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            self.pageIndex += 1;
            if (self.loadMoreBlock) {
                self.loadMoreBlock(self.pageIndex);
            }
            [self endFooterRefresh];
        }];

        footer.automaticallyRefresh = automaticallyRefresh;

        footer.stateLabel.font = [UIFont systemFontOfSize:13.0];
        footer.stateLabel.textColor = [UIColor colorWithWhite:0.400 alpha:1.000];
        [footer setTitle:@"加载中…" forState:MJRefreshStateRefreshing];
        [footer setTitle:@"这是我的底线啦~" forState:MJRefreshStateNoMoreData];

        self.mj_footer = footer;
    }
    else{
        MJRefreshBackNormalFooter * footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            self.pageIndex += 1;
            if (self.loadMoreBlock) {
                self.loadMoreBlock(self.pageIndex);
            }
            [self endFooterRefresh];
        }];

        footer.stateLabel.font = [UIFont systemFontOfSize:13.0];
        footer.stateLabel.textColor = [UIColor colorWithWhite:0.400 alpha:1.000];
        [footer setTitle:@"加载中…" forState:MJRefreshStateRefreshing];
        [footer setTitle:@"这是我的底线啦~" forState:MJRefreshStateNoMoreData];

        self.mj_footer = footer;
    }

}

-(void)beginHeaderRefresh {

    [self resetPageNum];
    [self.mj_header beginRefreshing];
}

- (void)resetPageNum {
    self.pageIndex = 0;
}

- (void)resetNoMoreData {

    [self.mj_footer resetNoMoreData];
}

-(void)endHeaderRefresh {

    [self.mj_header endRefreshing];
    [self resetNoMoreData];
}

-(void)endFooterRefresh {
    [self.mj_footer endRefreshing];
}


static void *pagaIndexKey = &pagaIndexKey;
- (void)setPageIndex:(NSInteger)pageIndex{
    objc_setAssociatedObject(self, &pagaIndexKey, @(pageIndex), OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)pageIndex
{
    return [objc_getAssociatedObject(self, &pagaIndexKey) integerValue];
}

static void *RefreshBlockKey = &RefreshBlockKey;
- (void)setRefreshBlock:(void (^)(void))RefreshBlock{
    objc_setAssociatedObject(self, &RefreshBlockKey, RefreshBlock, OBJC_ASSOCIATION_COPY);
}

- (BFfreshBlock)refreshBlock
{
    return objc_getAssociatedObject(self, &RefreshBlockKey);
}

static void *LoadMoreBlockKey = &LoadMoreBlockKey;
- (void)setLoadMoreBlock:(BFLoadMoreBlock)loadMoreBlock{
    objc_setAssociatedObject(self, &LoadMoreBlockKey, loadMoreBlock, OBJC_ASSOCIATION_COPY);
}

- (BFLoadMoreBlock)loadMoreBlock
{
    return objc_getAssociatedObject(self, &LoadMoreBlockKey);
}

@end
