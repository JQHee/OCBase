//
//  QFCheckTools.h
//  LoveCar
//
//  Created by apple on 16/4/14.
//  Copyright © 2016年 aichezhonghua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QFCheckTools : NSObject

#pragma mark - 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *)telNumber;
#pragma mark - 正则匹配用户密码6-18位数字和字母组合
+ (BOOL)checkPassword:(NSString *)password;
#pragma mark - 正则匹配用户姓名,20位的中文或英文
+ (BOOL)checkUserName:(NSString *)userName;
#pragma mark - 正则匹配用户身份证号
+ (BOOL)checkUserIdCard:(NSString *)idCard;
#pragma mark - 正则匹员工号,12位的数字
+ (BOOL)checkEmployeeNumber:(NSString *)number;
#pragma mark - 正则匹配URL
+ (BOOL)checkURL:(NSString *)url;
#pragma mark - 正则匹配车牌号
+ (BOOL)checkCarNumber:(NSString *)carNumber;
#pragma mark - 正则匹配短信验证码
+ (BOOL)checkSMSCode:(NSString *)SMSCode;
#pragma mark - 正则匹配邮箱
+ (BOOL)checkEmail:(NSString *)email;
#pragma 正则匹配xxxx - xx - xx 生日
+ (BOOL)checkBirthday:(NSString *)idCard;

@end
