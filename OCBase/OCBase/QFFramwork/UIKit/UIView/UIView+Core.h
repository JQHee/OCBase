//
//  UIView+Core.h
//  OCBase
//
//  Created by HJQ on 2018/11/18.
//  Copyright © 2018 HJQ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Core)

/**
 *  获取当前正在显示的控制器(由于keyWindow的不同可能获取不正确)
 *
 *  @return 正在显示的控制器
 */
+ (UIViewController *)currentViewController;
/**
 *  获取当前正在显示的控制器(无论keyWindow是什么)
 *
 *  @return 正在显示的控制器
 */
+ (UIViewController *)getCurrentViewConrtrollerIgnoreWindowLevel;

/**
 *  获取当前显示的View的控制器的根控制器
 *
 *  @return 根控制器
 */
+ (UIViewController *)getCurrentRootViewController;

@end

NS_ASSUME_NONNULL_END
