//
//  NSString+check.h
//  elmsc
//
//  Created by MAC on 2017/1/5.
//  Copyright © 2017年 GFB Network Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (check)

#pragma mark - 只允许输入数字（常用于校验输入的数量、密码等）
+ (BOOL)validateNumber:(NSString*)number;

#pragma mark - 只允许输入数字和小数点（常见于金额数字的输入等）
/*
 ** number 小数位的位数
 */
+ (BOOL)isValidAboutInputText:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string decimalNumber:(NSInteger)number;

#pragma mark - 只保留四位数字，其他位用*号替代
+ (NSString *) charcterWithStar:(NSString *) str;

#pragma mark - 清除字符串中的所有空格
+ (NSString *) removeStrAllSpace:(NSString *)str;

#pragma mark - 指定长度添加空格
+ (NSString *) addSpaceWithStr:(NSString *)str toStr:(NSString *) toStr length:(NSInteger) number;

@end
