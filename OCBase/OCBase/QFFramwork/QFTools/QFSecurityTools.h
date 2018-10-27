//
//  QFSecurityTools.h
//  elmsc
//
//  Created by qinfensky on 2016/12/17.
//  Copyright © 2016年 GFB Network Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QFSecurityTools : NSObject



// MD5
+ (NSString *)md5:(NSString *)str;

// DES3加密
+ (NSString *)DES3encryptWithText:(NSString *)sText;

// DES3解密
+ (NSString *)DES3decryptWithText:(NSString *)sText;

/**
 *  @brief
 AES块长度 128 byte
 加密模式CBC，cipher block chaining
 数据长度不到128byte时需要填充（即no padding自定义填充）
 填充方法s + (128 - len(s) % 128) * chr(128 - len(s) % 128) 将数字转成char字符拼接尾部
 加密密钥 Up[K+ub%pliOnsO5UavFBd)cw5VcyHSX
 初始向量需要附加在加密后的auth_user_id中 传给服务器,final auth_user_id = base64(iv+encrypted(user_id_auth))
 
 */


/**
 *  @brief  AES256加密
 *
 *  @param string    明文
 *  @param keyString 32位的密钥
 *
 *  @return 返回加密后的密文
 */
+ (NSString *)AES256Encrypt:(NSString *)string  WithKey:(NSString *)keyString;


/**
 *  @brief  AES256解密
 *
 *  @param string    密文
 *  @param keyString 32位的密钥
 *
 *  @return 返回解密后的明文
 */
+ (NSString *)AES256DecryptString:(NSString *) string WithKey:(NSString *)keyString;




@end
