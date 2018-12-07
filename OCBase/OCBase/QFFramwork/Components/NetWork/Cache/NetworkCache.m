//
//  NetworkCache.m
//  OCBase
//
//  Created by midland on 2018/12/7.
//  Copyright © 2018年 HJQ. All rights reserved.
//

#import "NetworkCache.h"
#import <CommonCrypto/CommonDigest.h>
#import <PINCache.h>

@implementation NetworkCache

static PINCache *pinCache = nil;

// 区分同用户 （用户id）
+ (void)pathName:(NSString *)name {
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    cachePath = [cachePath stringByAppendingPathComponent:@"com.cache.ocbase"];
    cachePath = [cachePath stringByAppendingPathComponent:name];
    pinCache = [[PINCache sharedCache] initWithName:name rootPath:cachePath];
}

+ (void)saveResponseCache:(id <NSCoding>)responseCache forKey:(NSString *)key {
    if (pinCache == nil) {
        pinCache = [PINCache sharedCache];
    }
    [pinCache setObject:responseCache forKey:[self cachedFileNameForKey: key]];
}

+ (id)getResponseCacheForKey:(NSString *)key {
    if (pinCache == nil) {
        pinCache = [PINCache sharedCache];
    }
    return [pinCache objectForKey:[self cachedFileNameForKey: key]];
}

+ (void)removeResponseCacheForKey:(NSString *)key {
    if (pinCache == nil) {
        pinCache = [PINCache sharedCache];
    }
    [pinCache removeObjectForKey:[self cachedFileNameForKey: key]];
}

+ (void)removeAllResponseCache {
    if (pinCache == nil) {
        pinCache = [PINCache sharedCache];
    }
    [pinCache removeAllObjects];
}

+ (NSString *)cachedFileNameForKey:(NSString *)key {
    const char *str = key.UTF8String;
    if (str == NULL) {
        str = "";
    }
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%@",
                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10],
                          r[11], r[12], r[13], r[14], r[15], [key.pathExtension isEqualToString:@""] ? @"" : [NSString stringWithFormat:@".%@", key.pathExtension]];
    return filename;
}

/*
+ (NSURLSessionTask *)GET:(NSString *)URL
               parameters:(id)parameters
                    cache:(BOOL)cache
            responseCache:(HttpRequestCache)responseCache
                  success:(HttpRequestSuccess)success
                  failure:(HttpRequestFailed)failure {
    NSString *cacheKey = URL;
    if (parameters) {
        cacheKey = [URL stringByAppendingString:[self convertJsonStringFromDictionaryOrArray:parameters]];
    }
    if (responseCache) { // 有缓存且网络错误
        responseCache([PGNetworkCache getResponseCacheForKey:cacheKey]);
    }
    AFHTTPSessionManager *manager = [self manager];
    return [manager GET:URL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (cache) {
            [PGNetworkCache saveResponseCache:responseObject forKey:cacheKey];
        }
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure ? failure(error) : nil;
    }];
}
 */

/*
+ (NSString *)convertJsonStringFromDictionaryOrArray:(id)parameter {
    NSData *data = [NSJSONSerialization dataWithJSONObject:parameter options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    return jsonStr;
}
 */

@end
