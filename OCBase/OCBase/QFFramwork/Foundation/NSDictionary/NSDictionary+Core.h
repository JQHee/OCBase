//
//  NSDictionary+Core.h
//  OCBase
//
//  Created by HJQ on 2018/11/18.
//  Copyright © 2018 HJQ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (Core)

/**
 *  @brief  将NSDictionary转换成url 参数字符串
 *
 *  @return url 参数字符串
 */
- (NSString *)urlQueryString;
/**
 *  @brief NSDictionary转换成JSON字符串
 *
 *  @return  JSON字符串
 */
-(NSString *)toJSONString;

@end

NS_ASSUME_NONNULL_END
