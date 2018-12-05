//
//  TestRequest.h
//  OCBase
//
//  Created by HJQ on 2018/12/5.
//  Copyright © 2018 HJQ. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface TestRequest : BaseRequest

@property (nonatomic, strong) NSString *test;

- (NSString *)testMethod;

@end

NS_ASSUME_NONNULL_END
