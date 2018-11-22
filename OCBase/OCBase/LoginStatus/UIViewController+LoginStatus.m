//
//  UIViewController+LoginStatus.m
//  OCBase
//
//  Created by HJQ on 2018/11/22.
//  Copyright © 2018 HJQ. All rights reserved.
//

#import "UIViewController+LoginStatus.h"
#import <objc/runtime.h>
#import "BFUserManager.h"

/** 登录状态的判定依据 */
static NSString *const kToken = @"token";
/** 登录控制器的类名 */
static NSString *const kLoginVCClassName = @"LoginViewController";


@interface UIViewController ()

@property (nonatomic, copy) dispatch_block_t successBlock;

@end

@implementation UIViewController (LoginStatus)

- (void)beforePushCheckLoginStatusWithSuccess:(void (^)(void))successBlock {

    self.successBlock = successBlock;

    // 如果没有登录
    if ([self isEmpty:[BFUserManager shareInstance].token] || [[BFUserManager shareInstance].token isEqualToString:@"##"]) {
        UIViewController *loginVC = [[NSClassFromString(kLoginVCClassName) alloc] init];
        if (loginVC) {
            [BFUserManager addObserver:self forKeyPath:kToken options:NSKeyValueObservingOptionNew context:nil];
            UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:loginVC];
            [self presentViewController:navVC animated:YES completion:nil];
        }
    } else {
        !self.successBlock ?: self.successBlock();
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {

    if ([keyPath isEqualToString:kToken]) {
        // 登录成功
        if (![self isEmpty:change[NSKeyValueChangeNewKey]] && ![change[NSKeyValueChangeNewKey] isEqualToString:@"##"]) {
            !self.successBlock ?: self.successBlock();
        }
        [BFUserManager removeObserver:self forKeyPath:kToken];
    }
}


#pragma mark - Private Methods

- (BOOL)isEmpty:(NSString *)scrString {
    return (scrString == nil || scrString.length == 0 || [scrString isKindOfClass:[NSNull class]]);
}

- (dispatch_block_t)successBlock {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setSuccessBlock:(dispatch_block_t)successBlock {
    objc_setAssociatedObject(self, @selector(successBlock), successBlock, OBJC_ASSOCIATION_COPY);
}


@end
