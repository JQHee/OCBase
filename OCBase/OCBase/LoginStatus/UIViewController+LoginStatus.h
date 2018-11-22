//
//  UIViewController+LoginStatus.h
//  OCBase
//
//  Created by HJQ on 2018/11/22.
//  Copyright © 2018 HJQ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (LoginStatus)

/**
 适用于：
 跳转前需要检查登录状态，并且处于登录状态或登录成功后由`自己`处理的情况

 说明：目前逻辑是当用户处于未登录状态，但点击了需要登录才能跳转的页面时，会先跳转到登录页面；
 如果登录不成功会停留在登录页面，用户可以点击“关闭”来返回当前页面，故只存在登录成功回调
 */
- (void)beforePushCheckLoginStatusWithSuccess:(void (^)(void))successBlock;

@end

NS_ASSUME_NONNULL_END
