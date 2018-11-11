//
//  TestViewModel.h
//  OCBase
//
//  Created by HJQ on 2018/11/11.
//  Copyright © 2018 HJQ. All rights reserved.
//

#import "BaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

// 双向绑定 model <---> view

@interface TestViewModel : BaseViewModel

@property (nonatomic, strong) NSString *contentKey;

- (void)loadData;

@end

NS_ASSUME_NONNULL_END
