//
//  NSString+UUID.h
//  InPurchasing
//
//  Created by midland on 2019/3/5.
//  Copyright © 2019年 midland. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (UUID)


/**
 获取设备的uuid

 @return uuid
 */
+ (NSString *) UUID;

@end

NS_ASSUME_NONNULL_END
