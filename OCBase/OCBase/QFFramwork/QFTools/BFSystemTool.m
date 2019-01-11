//
//  BFSystemTool.m
//  OCBase
//
//  Created by midland on 2019/1/11.
//  Copyright © 2019年 HJQ. All rights reserved.
//

#import "BFSystemTool.h"

@implementation BFSystemTool

+ (UIWindow *)normalWindow {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (UIWindow *temp in windows) {
            if (temp.windowLevel == UIWindowLevelNormal) {
                window = temp;
                break;
            }
        }
    }
    return window;
}

+ (UIViewController *)topViewController {
    UIViewController *topController = nil;
    UIWindow *window = [self normalWindow];
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:UIViewController.class]) {
        topController = nextResponder;
    } else {
        topController = window.rootViewController;
        while (topController.presentedViewController) {
            topController = topController.presentedViewController;
        }
    }
    return topController;
}

@end
