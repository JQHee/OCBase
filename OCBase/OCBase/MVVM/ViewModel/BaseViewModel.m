//
//  BaseViewModel.m
//  OCBase
//
//  Created by HJQ on 2018/11/11.
//  Copyright © 2018 HJQ. All rights reserved.
//

#import "BaseViewModel.h"

@implementation BaseViewModel

- (void) initWithSuccessBlock: (VMSuccessBlock) successBlock
                            failBlock: (VMFailureBlock) failureBlock {
    self.successBlock = successBlock;
    self.failureBlock = failureBlock;
}

@end
