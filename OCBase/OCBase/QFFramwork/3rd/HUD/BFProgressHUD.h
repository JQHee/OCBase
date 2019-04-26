//
//  BFProgressHUD.h
//  OCBase
//
//  Created by HJQ on 2019/4/14.
//  Copyright © 2019 HJQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFProgressHUD : NSObject

///统一Indicator(显示) 主线程调用
+ (void)showIndicator;
///统一Indicator(隐藏) 主线程调用
+ (void)hideIndicator;
///统一弹窗显示格式 主线程调用
+ (void)showInfo:(NSString *)info;

@end
