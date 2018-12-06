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

//@property (nonatomic, strong) NSString *test;
//
//@property (nonatomic, strong) NSDictionary *dict;
//
//@property (nonatomic, assign) NSInteger page;
//
//@property (nonatomic, assign) NSNumber *pageSize;

@property (nonatomic, assign) BOOL set;

- (NSDictionary *)testMethod: (Class)class;

@end

NS_ASSUME_NONNULL_END
