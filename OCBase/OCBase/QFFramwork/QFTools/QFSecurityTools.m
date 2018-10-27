//
//  QFSecurityTools.m
//  elmsc
//
//  Created by qinfensky on 2016/12/17.
//  Copyright © 2016年 GFB Network Technology Co.,Ltd. All rights reserved.
//

#import "GTMBase64.h"
#import "QFSecurityTools.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonHMAC.h>
#define LocalStr_None @""

//加密解密的key,与后台一致
#define USER_KEY @"123"
//初始化向量，与后台一致
#define initIv @"123"

@implementation QFSecurityTools

// Md5
+ (NSString *)md5:(NSString *)str {
    if (str == nil) {
        return nil;
    }

    const char *original_str = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *md5EncodeStr = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        [md5EncodeStr appendFormat:@"%02X", result[i]];
    }
    return md5EncodeStr;
    
    //const char *cStr = [str UTF8String];
    //unsigned char result[16];
    //CC_MD5(cStr, strlen(cStr), result);
//    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
//                                      result[0],
//                                      result[1],
//                                      result[2],
//                                      result[3],
//                                      result[4],
//                                      result[5],
//                                      result[6],
//                                      result[7],
//                                      result[8],
//                                      result[9],
//                                      result[10],
//                                      result[11],
//                                      result[12],
//                                      result[13],
//                                      result[14],
//                                      result[15]];
}


/******************************************************************************
 函数名称 : + (NSString *)DES3encryptWithText:(NSString *)sText
 函数描述 : DES3加密解密
 输入参数 : (NSString *)sText
 输出参数 : N/A
 返回参数 : (NSString *)
 备注信息 :
 ******************************************************************************/
+ (NSString *)DES3encryptWithText:(NSString *)sText {
    // kCCEncrypt 加密
    return [self DES3encrypt:sText encryptOrDecrypt:kCCEncrypt key:USER_KEY];
}

+ (NSString *)DES3decryptWithText:(NSString *)sText {
    // kCCDecrypt 解密
    return [self DES3encrypt:sText encryptOrDecrypt:kCCDecrypt key:USER_KEY];
}

+ (NSString *)DES3encrypt:(NSString *)sText encryptOrDecrypt:(CCOperation)encryptOperation key:(NSString *)key {
    const void *dataIn;
    size_t dataInLength;

    if (encryptOperation == kCCDecrypt) //传递过来的是decrypt 解码
    {
        //解码 base64
        NSData *decryptData = [GTMBase64 decodeData:[sText dataUsingEncoding:NSUTF8StringEncoding]]; //转成utf-8并decode
        dataInLength = [decryptData length];
        dataIn = [decryptData bytes];
    } else // encrypt
    {
        NSData *encryptData = [sText dataUsingEncoding:NSUTF8StringEncoding];
        dataInLength = [encryptData length];
        dataIn = (const void *)[encryptData bytes];
    }

    /*
     DES加密 ：用CCCrypt函数加密一下，然后用base64编码下，传过去
     DES解密 ：把收到的数据根据base64，decode一下，然后再用CCCrypt函数解密，得到原本的数据
     */
    CCCryptorStatus ccStatus;
    uint8_t *dataOut =
        NULL; //可以理解位type/typedef 的缩写（有效的维护了代码，比如：一个人用int，一个人用long。最好用typedef来定义）
    size_t dataOutAvailable = 0; // size_t  是操作符sizeof返回的结果类型
    size_t dataOutMoved = 0;

    dataOutAvailable = (dataInLength + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    dataOut = malloc(dataOutAvailable * sizeof(uint8_t));
    memset((void *)dataOut, 0x0, dataOutAvailable); //将已开辟内存空间buffer的首 1 个字节的值设为值 0

    const void *vkey = (const void *)[key UTF8String];
    const void *iv = (const void *)[initIv UTF8String];

    // CCCrypt函数 加密/解密
    ccStatus =
        CCCrypt(encryptOperation, //  加密/解密
                kCCAlgorithm3DES, //  加密根据哪个标准（des，3des，aes。。。。）
                kCCOptionPKCS7Padding, //  选项分组密码算法(des:对每块分组加一次密  3DES：对每块分组加三个不同的密)
                vkey, //密钥    加密和解密的密钥必须一致
                kCCKeySize3DES, //   DES 密钥的大小（kCCKeySizeDES=8）
                iv, //  可选的初始矢量
                dataIn, // 数据的存储单元
                dataInLength, // 数据的大小
                (void *)dataOut, // 用于返回数据
                dataOutAvailable,
                &dataOutMoved);

    NSString *result = nil;

    if (encryptOperation == kCCDecrypt) // encryptOperation==1  解码
    {
        //得到解密出来的data数据，改变为utf-8的字符串
        result =
            [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)dataOut length:(NSUInteger)dataOutMoved]
                                  encoding:NSUTF8StringEncoding];
    } else // encryptOperation==0  （加密过程中，把加好密的数据转成base64的）
    {
        //编码 base64
        NSData *data = [NSData dataWithBytes:(const void *)dataOut length:(NSUInteger)dataOutMoved];
        result = [GTMBase64 stringByEncodingData:data];
    }

    return result;
}


+ (NSString *)AES256Encrypt:(NSString *)string  WithKey:(NSString *)keyString
{
    
    // 加密方案 AES256加密
    NSString *plainText = string;//明文
    NSData *plainTextData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    // Base64解密
    NSData *keyData = [GTMBase64 decodeString:keyString];
    // 拼接加密后的字符串
//    NSMutableString *secrityText = [NSMutableString string];
    //
    NSData *cipherTextData = [plainTextData AES256EncryptWithKey:keyData];
    Byte *plainTextByte = (Byte *)[cipherTextData bytes];
//    for(int i=0;i<[cipherTextData length];i++){
//        [secrityText appendString:[NSString stringWithFormat:@"%x", plainTextByte[i]]];
//    }
//    debugLog(@"未经过Base64加密后的密文：%@", secrityText);
//    secrityText = [NSMutableString stringWithString:[GTMBase64 stringByEncodingData:[secrityText dataUsingEncoding:kCFStringEncodingUTF8]]];
//    debugLog(@"已经过Base64加密后的密文：%@", secrityText);
//    debugLog(@"已经过Base64加密后的数组：%@", [[NSString alloc] initWithData:[GTMBase64 encodeBytes:plainTextByte length:[cipherTextData length]] encoding:kCFStringEncodingUTF8]);
    
    
    return [[NSString alloc] initWithData:[GTMBase64 encodeBytes:plainTextByte length:[cipherTextData length]] encoding:kCFStringEncodingUTF8];
}

+ (NSString *)AES256DecryptString:(NSString *) string WithKey:(NSString *)keyString
{
    // Base64解密
    NSData *keyData = [GTMBase64 decodeString:keyString];
    // 拼接加密后的字符串
    //    NSMutableString *secrityText = [NSMutableString string];
    //
    NSData *cipherTextData = [GTMBase64 decodeString:string];
    NSData *realData = [cipherTextData AES256DecryptWithKey:keyData];
    NSString *realText = [[NSString alloc] initWithData:realData encoding:NSUTF8StringEncoding];
//    debugLog(@"解密后字符串:%@", realText);
    
    return realText;
}








+(BOOL)validKey:(NSString*)key
{
    if( key==nil || key.length != kCCKeySizeAES256){
        return NO;
    }
    return YES;
}

+ (instancetype)shareSecurityTools{
    static QFSecurityTools *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
    });
    return instance;

}


@end
