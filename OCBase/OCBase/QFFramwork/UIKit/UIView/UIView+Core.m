//
//  UIView+Core.m
//  OCBase
//
//  Created by HJQ on 2018/11/18.
//  Copyright © 2018 HJQ. All rights reserved.
//

#import "UIView+Core.h"

@implementation UIView (Core)

#pragma mark - 获取父级控制器
- (UIViewController *)parentController {
    //     获取响应者
    UIResponder *responder = [self nextResponder];
    //    递归找到响应者
    while (responder) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = [responder nextResponder];
    }

    return nil;
}


#pragma mark - 获取当前控制器 -  由于keyWindow的不同可能获取不正确
+ (UIViewController *)currentViewController {

    //如果是在AlertView上可能获取的keyWindow不是UIWindow（注意）
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;

    //         取到第一层时，取到的是UITransitionView，通过这个view拿不到控制器
    UIView *firstView = [keyWindow.subviews firstObject];
    UIView *secondView = [firstView.subviews firstObject];

    UIViewController *vc = secondView.parentController;

    if ([vc isKindOfClass:[UITabBarController class]]) {

        UITabBarController *tab = (UITabBarController *)vc;


        if ([tab.selectedViewController isKindOfClass:[UINavigationController class]]) {

            UINavigationController *nav = (UINavigationController *)tab.selectedViewController;

            return [nav.viewControllers lastObject];

        } else {

            return tab.selectedViewController;
        }

    }else if ([vc isKindOfClass:[UINavigationController class]]) {

        UINavigationController *nav = (UINavigationController *)vc;

        return [nav.viewControllers lastObject];

    } else {

        return vc;
    }


    return nil;

}

#pragma mark - 获取当前显示的控制器
+(UIViewController *)getCurrentViewConrtrollerIgnoreWindowLevel {

    //    获取到最顶层window
    UIWindow *topWindow = [[UIApplication sharedApplication] keyWindow];


    if (topWindow.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(topWindow in windows){

            if (topWindow.windowLevel == UIWindowLevelNormal)
                break;

        }
    }

    //         取到第一层时，取到的是UITransitionView，通过这个view拿不到控制器
    UIView *firstView = [topWindow.subviews firstObject];
    UIView *secondView = [firstView.subviews firstObject];

    //     获取其父级控制器
    UIViewController *vc = secondView.parentController;
    if ([vc isKindOfClass:[UITabBarController class]])
    {
        UITabBarController *tab = (UITabBarController *)vc;
        if ([tab.selectedViewController isKindOfClass:[UINavigationController class]])
        {
            UINavigationController *nav = (UINavigationController *)tab.selectedViewController;
            return [nav.viewControllers lastObject];

        } else {
            return tab.selectedViewController;

        }

    }else if ([vc isKindOfClass:[UINavigationController class]]) {

        UINavigationController *nav = (UINavigationController *)vc;
        return [nav.viewControllers lastObject];

    }else {
        return vc;
    }

    return nil;

}


#pragma mark -  获取当前显示的View的控制器的根控制器
+ (UIViewController *)getCurrentRootViewController {

    UIViewController *result;

    //         Try to find the root view controller programmically
    //
    //         Find the top window (that is not an alert view or other window)

    UIWindow *topWindow = [[UIApplication sharedApplication] keyWindow];

    if (topWindow.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];

        for(topWindow in windows) {
            if (topWindow.windowLevel == UIWindowLevelNormal)
                break;
        }
    }

    UIView *rootView = [[topWindow subviews] objectAtIndex:0];
    id nextResponder = [rootView nextResponder];

    if ([nextResponder isKindOfClass:[UIViewController class]]) {

        result = nextResponder;

    } else if ([topWindow respondsToSelector:@selector(rootViewController)] && topWindow.rootViewController !=nil) {

        result = topWindow.rootViewController;

    }else {
        NSAssert(NO,@"ShareKit: Could not find a root view controller. You can assign one manually by calling [[SHK currentHelper] setRootViewController:YOURROOTVIEWCONTROLLER].");


        NSLog(@"未能找到相应的控制器！");

    }

    return result;
}

@end
