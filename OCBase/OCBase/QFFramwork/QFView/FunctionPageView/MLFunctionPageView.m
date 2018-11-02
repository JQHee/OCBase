//
//  MLFunctionPageView.m
//  FunctionPageDemo
//
//  Created by midland on 2018/11/2.
//  Copyright © 2018年 midland. All rights reserved.
//

#import "MLFunctionPageView.h"
#import "MLFunctionPageItemView.h"

@interface MLFunctionPageView() <UIScrollViewDelegate, MLFunctionPageItemViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation MLFunctionPageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return  self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
      [self setupUI];
    }
    return  self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.scrollView.frame = self.bounds;
    self.pageControl.frame = CGRectMake(0, self.bounds.size.height - 30, self.bounds.size.width, 30);
    [self setupContentSubviews];
}

// MARK: - Private methods
- (void) setupUI {
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
    
}

- (void) setupContentSubviews {
    for (UIView *tempView in self.scrollView.subviews) {
        [tempView removeFromSuperview];
    }
    CGFloat width = UIScreen.mainScreen.bounds.size.width;
    NSArray *array = [self splitArray: self.dataArray withSubSize:8];
    int page =  self.dataArray.count % 8 == 0 ? self.dataArray.count / 8 : self.dataArray.count / 8 + 1; // 分页个数
    CGFloat viewWidth = width / 4;
    for(int i = 0; i < page; i++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(width * i, 0, width, self.bounds.size.height)];
        view.backgroundColor = [UIColor redColor];
        [self.scrollView addSubview:view];
        
        NSArray *caiArray = array[i];
        for(int a = 0; a < caiArray.count; a++) {
            id model = caiArray[a];
            CGFloat tempViewHeight = self.bounds.size.height / 2.0;
            CGFloat tempViewY = (a / 4) * tempViewHeight;
            CGFloat tempViewX = (a % 4) * (viewWidth + 0);
            MLFunctionPageItemView *btnView = [[MLFunctionPageItemView alloc]initWithFrame:CGRectMake(tempViewX, tempViewY, viewWidth, tempViewHeight)];
            btnView.backgroundColor = [UIColor orangeColor];
            btnView.delegate = self;
            btnView.selectIndex = a;
            btnView.model = model;
            [view addSubview:btnView];
        }
    }
    self.pageControl.numberOfPages = page;
    [self.pageControl setHidden:page <= 1 ? YES : NO];
    self.scrollView.contentSize = CGSizeMake(width * page, 0);
}

- (NSArray*) splitArray: (NSArray*)array withSubSize: (int)subSize {
    //  数组将被拆分成指定长度数组的个数
    unsigned long count = array.count % subSize == 0 ? (array.count/ subSize) : (array.count/ subSize + 1);
    //  数组将被拆分成指定长度数组的个数
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    // 利用总个数进行循环，将指定长度的元素加入数组
    for(int i = 0; i < count; i ++) {
        int index = i * subSize;
        int endIndex = index + subSize;
        // 保存拆分的固定长度的数组元素的可变数组
        NSMutableArray *arr1 = [[NSMutableArray alloc] init];
        // 移除子数组的所有元素
        [arr1 removeAllObjects];

        for (int startIndex = index; startIndex < endIndex; startIndex++) {
            if (startIndex < array.count) {
                [arr1 addObject:[array objectAtIndex:startIndex]];
            }
        }
        if (array.count > 0) {
            [arr addObject:[arr1 copy]];
        }
    }
    //NSLog(@"%@", arr);
    return[arr copy];
    
}

// MARK: - MLFunctionPageItemViewDelegate
- (void)functionPageItemViewSelected: (id) model withIndex: (int) selectIndex {
    if ([_delegate respondsToSelector:@selector(functionPageViewSelected:withIndex:)]) {
        [_delegate functionPageViewSelected:model withIndex:selectIndex];
    }
}

// MARK: - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int page = scrollView.contentOffset.x / UIScreen.mainScreen.bounds.size.width;
    self.pageControl.currentPage = page;
}

// MARK: - getter and setter
- (UIScrollView *) scrollView {
    if (!_scrollView) {
        UIScrollView *tempScrollView = [[UIScrollView alloc] init];
        tempScrollView.showsVerticalScrollIndicator = NO;
        tempScrollView.showsHorizontalScrollIndicator = NO;
        tempScrollView.bounces = NO;
        tempScrollView.pagingEnabled = YES;
        tempScrollView.delegate = self;
        _scrollView = tempScrollView;
    }
    return _scrollView;
}

- (UIPageControl *) pageControl {
    if (!_pageControl) {
        UIPageControl *tempPageControl = [[UIPageControl alloc]init];
        tempPageControl.currentPage = 0;
        tempPageControl.pageIndicatorTintColor = [UIColor grayColor];
        tempPageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        _pageControl = tempPageControl;
    }
    return _pageControl;
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    [self setupContentSubviews];
}

@end
