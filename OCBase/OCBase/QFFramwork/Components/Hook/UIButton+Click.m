//
//  UIButton+Click.m
//  OCBase
//
//  Created by midland on 2018/12/3.
//  Copyright © 2018年 HJQ. All rights reserved.
//

#import "UIButton+Click.h"
#import <objc/runtime.h>

/**
 * @brief 拦截按钮的点击事件
 */

@implementation UIButton (Click)

+ (void)load {
    Method oldObjectAtIndex =class_getInstanceMethod([UIButton class],@selector(sendAction:to:forEvent:));
    Method newObjectAtIndex =class_getInstanceMethod([UIButton class], @selector(custom_sendAction:to:forEvent:));
    method_exchangeImplementations(oldObjectAtIndex, newObjectAtIndex);
}

- (void)sendAction: (SEL)action to: (id)target forEvent: (UIEvent *)event {
    [super sendAction:action to:target forEvent:event];
}

- (void)custom_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    // 有问题  有时只打印出“走了...”
    /*
    NSLog(@"%@  走了...", target);
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager manager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable || status == AFNetworkReachabilityStatusUnknown) {
            NSLog(@"无网络连接....");
            return ;
        }else{  // 如果有网络继续走系统方法
            [self custom_sendAction:action to:target forEvent:event];
        }
    }];
    [manager startMonitoring];
     */
    
}

@end
