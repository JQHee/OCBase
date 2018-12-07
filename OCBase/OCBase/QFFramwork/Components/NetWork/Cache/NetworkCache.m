//
//  NetworkCache.m
//  OCBase
//
//  Created by HJQ on 2018/12/7.
//  Copyright © 2018年 HJQ. All rights reserved.
//

#import "NetworkCache.h"
#import <PINCache.h>
#import "NSString+Network.h"

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
    [pinCache setObject:responseCache forKey:[key cachedFileName]];
}

+ (id)getResponseCacheForKey:(NSString *)key {
    if (pinCache == nil) {
        pinCache = [PINCache sharedCache];
    }
    return [pinCache objectForKey:[key cachedFileName]];
}

+ (void)removeResponseCacheForKey:(NSString *)key {
    if (pinCache == nil) {
        pinCache = [PINCache sharedCache];
    }
    [pinCache removeObjectForKey:[key cachedFileName]];
}

+ (void)removeAllResponseCache {
    if (pinCache == nil) {
        pinCache = [PINCache sharedCache];
    }
    [pinCache removeAllObjects];
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
