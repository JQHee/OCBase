//
//  UIDevice+Core.m
//  OCBase
//
//  Created by HJQ on 2018/11/1.
//  Copyright © 2018 HJQ. All rights reserved.
//

#import "UIDevice+Core.h"

@implementation UIDevice (Core)

// 是否是刘海屏
- (BOOL) isFullScreen {

    if (@available(iOS 11.0, *)) {
        UIWindow *window = UIApplication.sharedApplication.delegate.window;
        if (window) {
            if (window.safeAreaInsets.left > 0 || window.safeAreaInsets.bottom > 0) {
                return YES;
            }
        } else {
            return NO;
        }
    }

    return NO;
}

- (BOOL) isIPhoneXSeries {
    BOOL iPhoneXSeries = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneXSeries;
    }
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneXSeries = YES;
        }
    }
    return iPhoneXSeries;
}

@end
