//
//  UIControl+userStatics.m
//  OCBase
//
//  Created by midland on 2018/12/3.
//  Copyright © 2018年 HJQ. All rights reserved.
//

#import "UIControl+userStatics.h"
#import "HookUtility.h"

@implementation UIControl (userStatics)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(sendAction:to:forEvent:);
        SEL swizzledSelector = @selector(swiz_sendAction:to:forEvent:);
        [HookUtility swizzlingInClass:[self class] originalSelector:originalSelector swizzledSelector:swizzledSelector];
    });
}
#pragma mark - Method Swizzling
- (void)swiz_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    // 插入埋点代码
    [self performUserStastisticsAction:action to:target forEvent:event];
    [self swiz_sendAction:action to:target forEvent:event];
}

- (void)performUserStastisticsAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    NSLog(@"\n***hook success.\n[1]action:%@\n[2]target:%@ \n[3]event:%ld", NSStringFromSelector(action), target, (long)event);
}

@end
