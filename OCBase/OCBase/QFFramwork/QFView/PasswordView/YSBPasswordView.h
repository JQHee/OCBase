//
//  YSBPasswordView.h
//  Yuansubei
//
//  Created by HJQ on 2017/3/26.
//  Copyright © 2017年 HJQ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, VerifyStatus) {
    successStatus, // 验证成功
    noTheSameASStatus // 两次的输入不一致
};

typedef void (^ReturnPasswordStringBlock)(NSString *password,VerifyStatus verifyResult);

@interface YSBPasswordView : UIView

// 是否需要两次验证（主要是用在设置密码的时候）
@property (nonatomic, assign) BOOL isNeedverify;

// 返回的密码
@property (nonatomic, copy) ReturnPasswordStringBlock returnPasswordblock;

@end
