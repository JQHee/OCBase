//
//  NSString+Network.h
//  OCBase
//
//  Created by midland on 2018/12/7.
//  Copyright © 2018年 HJQ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Network)

- (NSString *)cachedFileName;

+ (NSString *)convertJsonStringFromDictionaryOrArray:(id)parameter;

@end

NS_ASSUME_NONNULL_END
