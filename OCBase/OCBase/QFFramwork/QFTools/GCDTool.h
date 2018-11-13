//
//  GCDTool.h
//  OCBase
//
//  Created by HJQ on 2018/11/13.
//  Copyright © 2018 HJQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GCDTool : NSObject

// 延迟执行
+ (void)delay: (NSTimeInterval) seconds block: (void(^)(void)) block;

@end

NS_ASSUME_NONNULL_END
