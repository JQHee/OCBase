//
//  CoreMediaFuncManagerVC.h
//  CoreMediaFuncManagerVC
//
//  Created by muxi on 15/3/11.
//  Copyright (c) 2015年 muxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QFPhoneManagerVC : UIViewController

/**
 *  打电话
 *
 *  @param no                   电话号码
 *  @param vc     需要打电话的控制器
 */
+ (void)call:(NSString *)no inViewController:(UIViewController *)vc failBlock:(void (^)())failBlock;

/**
 *  检测手机型号
 *
 *  @return 手机型号
 */
+ (NSString *)iphoneType;

@end
