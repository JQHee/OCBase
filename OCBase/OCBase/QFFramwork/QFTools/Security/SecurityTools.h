//
//  SecurityTools.h
//  OCBase
//
//  Created by midland on 2019/3/4.
//  Copyright © 2019年 HJQ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SecurityTools : NSObject


/**
 一、防止反编译

 @return 手机是否越狱
 */
+ (BOOL)checkMobileIsBreakPrison;

/**
 二、防止二次打包

 @return 是否二次打包
 */
+ (BOOL)isSecondIPA;


/**
 三、防止调试
 main.m加入防止调试的方法
 */

@end

NS_ASSUME_NONNULL_END
