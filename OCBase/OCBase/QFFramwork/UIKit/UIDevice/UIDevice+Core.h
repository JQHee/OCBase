//
//  UIDevice+Core.h
//  OCBase
//
//  Created by HJQ on 2018/11/1.
//  Copyright © 2018 HJQ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (Core)

// 是否是刘海屏
- (BOOL) isFullScreen;

- (BOOL) isIPhoneXSeries;

@end

NS_ASSUME_NONNULL_END
