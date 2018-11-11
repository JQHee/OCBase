//
//  TestViewModel.m
//  OCBase
//
//  Created by HJQ on 2018/11/11.
//  Copyright © 2018 HJQ. All rights reserved.
//

#import "TestViewModel.h"

@implementation TestViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self viewBindEvents];
    }
    return self;
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"contentKey"];
}

// MARK: - Public methods
- (void)loadData {
    NSArray *array = @[@"第一个", @"第二个"];
    if (self.successBlock) {
        self.successBlock(array);
    }
}

// MARK: - Private methods
- (void) viewBindEvents {
    [self addObserver:self forKeyPath:@"contentKey" options:(NSKeyValueObservingOptionNew) context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {

    if ([keyPath  isEqual: @"contentKey"]) {
        NSArray *array = @[@"第一个", @"第二个"];
        NSMutableArray *marray = [NSMutableArray arrayWithArray:array];
        @synchronized (self) {
            [marray removeObject: change[NSKeyValueChangeNewKey]];
        }
        if (self.successBlock) {
            self.successBlock(marray);
        }
    }
}

@end
