//
//  UITextField+YSBTextFieldDelegate.m
//  TestPasswordView
//
//  Created by HJQ on 2017/3/29.
//  Copyright © 2017年 HJQ. All rights reserved.
//

#import "UITextField+YSBTextFieldDelegate.h"
#import <objc/runtime.h>

NSString * const WJTextFieldDidDeleteBackwardNotification = @"com.whojun.textfield.did.notification";


@implementation UITextField (YSBTextFieldDelegate)

+ (void)load {
    //交换2个方法中的IMP
    Method method1 = class_getInstanceMethod([self class], NSSelectorFromString(@"deleteBackward"));
    Method method2 = class_getInstanceMethod([self class], @selector(wj_deleteBackward));
    method_exchangeImplementations(method1, method2);
}

- (void)wj_deleteBackward {
    [self wj_deleteBackward];
    
    if ([self.delegate respondsToSelector:@selector(textFieldDidDeleteBackward:)])
    {
        id <WJTextFieldDelegate> delegate  = (id<WJTextFieldDelegate>)self.delegate;
        [delegate textFieldDidDeleteBackward:self];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:WJTextFieldDidDeleteBackwardNotification object:self];
}

@end
