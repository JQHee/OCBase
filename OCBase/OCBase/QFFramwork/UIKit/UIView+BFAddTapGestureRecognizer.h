//
//  UIView+BFAddTapGestureRecognizer.h
//  OCBase
//
//  Created by HJQ on 2018/11/11.
//  Copyright © 2018 HJQ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * UIView拓展block 处理点击事件
 */

@interface UIView (BFAddTapGestureRecognizer)

- (void)addTapGestureRecognizerWithDelegate:(id)tapGestureDelegate Block:(void(^)(NSInteger tag))block;

@end

NS_ASSUME_NONNULL_END
