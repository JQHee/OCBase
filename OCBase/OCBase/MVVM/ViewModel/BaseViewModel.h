//
//  BaseViewModel.h
//  OCBase
//
//  Created by HJQ on 2018/11/11.
//  Copyright © 2018 HJQ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^VMSuccessBlock) (id result);
typedef void(^VMFailureBlock) (id result);

@interface BaseViewModel : NSObject

@property (nonatomic, copy) VMSuccessBlock successBlock;
@property (nonatomic, copy) VMFailureBlock failureBlock;

- (void) initWithSuccessBlock: (VMSuccessBlock) successBlock
                            failBlock: (VMFailureBlock) failureBlock;

@end

NS_ASSUME_NONNULL_END
