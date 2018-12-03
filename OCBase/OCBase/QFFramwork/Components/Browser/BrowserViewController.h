//
//  BrowserViewController.h
//  OCBase
//
//  Created by midland on 2018/12/3.
//  Copyright © 2018年 HJQ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BrowserViewController : UIViewController

/**
 请求的url
 */
@property (nonatomic,copy) NSString *urlString;

/**
 要注入的js方法
 */
@property (nonatomic,copy) NSString *jsString;

/**
 进度条颜色
 */
@property (nonatomic,strong) UIColor *loadingProgressColor;

/**
 是否下拉重新加载
 */
@property (nonatomic, assign) BOOL canDownRefresh;

@end

NS_ASSUME_NONNULL_END
