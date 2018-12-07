//
//  NSString+Network.m
//  OCBase
//
//  Created by midland on 2018/12/7.
//  Copyright © 2018年 HJQ. All rights reserved.
//

#import "NSString+Network.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Network)

- (NSString *)cachedFileName {
    const char *str = self.UTF8String;
    if (str == NULL) {
        str = "";
    }
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%@",
                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10],
                          r[11], r[12], r[13], r[14], r[15], [self.pathExtension isEqualToString:@""] ? @"" : [NSString stringWithFormat:@".%@", self.pathExtension]];
    return filename;
}

+ (NSString *)convertJsonStringFromDictionaryOrArray:(id)parameter {
    NSData *data = [NSJSONSerialization dataWithJSONObject:parameter options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    return jsonStr;
}

@end
