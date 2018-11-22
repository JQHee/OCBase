//
//  BFUserManager.h
//  OCBase
//
//  Created by HJQ on 2018/11/22.
//  Copyright © 2018 HJQ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BFUserManager : NSObject

+ (instancetype) shareInstance;

@property (nonatomic, strong) NSString *token;

@end

NS_ASSUME_NONNULL_END
