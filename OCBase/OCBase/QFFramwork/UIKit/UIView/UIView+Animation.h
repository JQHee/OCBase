//
//  UIView+Animation.h
//  OCBase
//
//  Created by HJQ on 2018/11/18.
//  Copyright © 2018 HJQ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Animation)

// 点赞
- (void)startAnimationPopOut;

// 取消点赞
- (void)startAnimationPopIn;

@end

NS_ASSUME_NONNULL_END
