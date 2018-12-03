//
//  UIViewController+userStatics.m
//  OCBase
//
//  Created by midland on 2018/12/3.
//  Copyright © 2018年 HJQ. All rights reserved.
//

#import "UIViewController+userStatics.h"
#import "HookUtility.h"

/**
 * @brief 不侵入工程代码埋点统计技术
 */

@implementation UIViewController (userStatics)

+ (void)load {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzledSelector = @selector(swiz_viewWillAppear:);
        
        [HookUtility swizzlingInClass:[self class] originalSelector:originalSelector swizzledSelector:swizzledSelector];
        
        
        SEL originalSelectorDis = @selector(viewWillDisappear:);
        SEL swizzledSelectorDis = @selector(swiz_viewWillDisappear:);
        
        [HookUtility swizzlingInClass:[self class] originalSelector:originalSelectorDis swizzledSelector:swizzledSelectorDis];
        
    });
    
}


- (void)swiz_viewWillAppear:(BOOL)animated {
    
    //插入需要执行的代码
    NSLog(@"我在viewWillAppear执行前偷偷插入了一段代码%@",[self class]);
    //不能干扰原来的代码流程，插入代码结束后要让本来该执行的代码继续执行
    [self swiz_viewWillAppear:animated];
    
}


- (void)swiz_viewWillDisappear:(BOOL)animated {
    
    // 插入需要执行的代码
    NSString *pageName=NSStringFromClass([self class]);
    NSLog(@"结束监听%@",pageName);
    // 不能干扰原来的代码流程，插入代码结束后要让本来该执行的代码继续执行
    [self swiz_viewWillDisappear:animated];
    
}


@end
