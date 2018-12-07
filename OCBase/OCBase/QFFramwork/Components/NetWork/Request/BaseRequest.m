//
//  BaseRequest.m
//  OCBase
//
//  Created by HJQ on 2018/12/5.
//  Copyright © 2018 HJQ. All rights reserved.
//

#import "BaseRequest.h"
#import "HTTPClient.h"


@interface BaseRequest()


@end

@implementation BaseRequest

- (instancetype)init {
    self = [super init];
    if (self) {

    }
    return self;
}

- (void) config {
    [[HTTPClient shareInstance] setrRequestTimeout:self.timeout];
    [[HTTPClient shareInstance] setRequestSerializer:self.header];
    [[HTTPClient shareInstance] setAcceptableContentTypes:self.set];
}

#pragma - 同步的网络请求
// POST 请求
- (NSURLSessionDataTask *)synchronouslyPostWithProgress:(void(^)(NSProgress *progress))progress
                                             cacheBlock:(void(^)(id response)) cacheBlock
                                                success:(void(^)(NSURLSessionDataTask *task, id response))success
                                                failure:(void(^)(NSError *error))failer {
    NSString *cacheKey = [NSString stringWithFormat:@"%@%@", self.baseURL, self.methodName ?: @""];
    if (self.parameters) {
        cacheKey = [cacheKey stringByAppendingString:[NSString convertJsonStringFromDictionaryOrArray:self.parameters]];
    }
    if (cacheBlock) {
        cacheBlock([NetworkCache getResponseCacheForKey:cacheKey]);
    }
    
    [self config];
    ClientData *data = [[ClientData alloc]init];
    data.baseURL = self.baseURL;
    data.methodName = self.methodName;
    data.parameters = self.parameters;

    return[[HTTPClient shareInstance] synchronouslyPOSTWithData:data progress:progress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull response) {
        if (self.isSaveCache && !response) {
            [NetworkCache saveResponseCache:response forKey:cacheKey];
        }
        if (success) {
            success (task, response);
        }
    } failure:failer];
}

- (NSURLSessionDataTask *)synchronouslyGetWithProgress:(void(^)(NSProgress *progress))progress
                                            cacheBlock: (void(^)(id response)) cacheBlock
                                               success:(void(^)(NSURLSessionDataTask *task, id response))success
                                               failure:(void(^)(NSError *error))failer {
    NSString *cacheKey = [NSString stringWithFormat:@"%@%@", self.baseURL, self.methodName ?: @""];
    if (self.parameters) {
        cacheKey = [cacheKey stringByAppendingString:[NSString convertJsonStringFromDictionaryOrArray:self.parameters]];
    }
    if (cacheBlock) {
        cacheBlock([NetworkCache getResponseCacheForKey:cacheKey]);
    }
    
    [self config];
    ClientData *data = [[ClientData alloc]init];
    data.baseURL = self.baseURL;
    data.methodName = self.methodName;
    data.parameters = self.parameters;
    return [[HTTPClient shareInstance] synchronouslyGetWithData:data progress:progress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull response) {
        if (self.isSaveCache && !response) {
            [NetworkCache saveResponseCache:response forKey:cacheKey];
        }
        if (success) {
            success (task, response);
        }
    } failure:failer];
}

#pragma -  异步网络请求

// POST 请求
- (NSURLSessionDataTask *)sendPostWithProgress:(void(^)(NSProgress *progress))progress
                                    cacheBlock:(void(^)(id response)) cacheBlock
                                       success:(void(^)(NSURLSessionDataTask *task, id response))success
                                       failure:(void(^)(NSError *error))failer {
    NSString *cacheKey = [NSString stringWithFormat:@"%@%@", self.baseURL, self.methodName ?: @""];
    if (self.parameters) {
        cacheKey = [cacheKey stringByAppendingString:[NSString convertJsonStringFromDictionaryOrArray:self.parameters]];
    }
    if (cacheBlock) {
        cacheBlock([NetworkCache getResponseCacheForKey:cacheKey]);
    }
    
    [self config];
    ClientData *data = [[ClientData alloc]init];
    data.baseURL = self.baseURL;
    data.methodName = self.methodName;
    data.parameters = self.parameters;
    return [[HTTPClient shareInstance] sendPostWithData:data progress:progress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull response) {
        if (self.isSaveCache && !response) {
            [NetworkCache saveResponseCache:response forKey:cacheKey];
        }
        if (success) {
            success (task, response);
        }
    } failure:failer];
}

- (NSURLSessionDataTask *)sendGetWithProgress:(void(^)(NSProgress *progress))progress
                                   cacheBlock:(void(^)(id response)) cacheBlock
                                      success:(void(^)(NSURLSessionDataTask *task, id response))success
                                      failure:(void(^)(NSError *error))failer {
    NSString *cacheKey = [NSString stringWithFormat:@"%@%@", self.baseURL, self.methodName ?: @""];
    if (self.parameters) {
        cacheKey = [cacheKey stringByAppendingString:[NSString convertJsonStringFromDictionaryOrArray:self.parameters]];
    }
    if (cacheBlock) {
        cacheBlock([NetworkCache getResponseCacheForKey:cacheKey]);
    }

    [self config];
    ClientData *data = [[ClientData alloc]init];
    data.baseURL = self.baseURL;
    data.methodName = self.methodName;
    data.parameters = self.parameters;
    return [[HTTPClient shareInstance] sendGetWithData:data progress:progress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull response) {
        if (self.isSaveCache && !response) {
            [NetworkCache saveResponseCache:response forKey:cacheKey];
        }
        if (success) {
            success (task, response);
        }
    } failure:failer];
}

- (NSURLSessionDataTask *)uploadFileWithProgress:(void(^)(NSProgress *progress))progress
                                         success:(void(^)(NSURLSessionDataTask *task, id response))success
                                         failure:(void(^)(NSError *error))failer{

    [self config];
    ClientData *data = [[ClientData alloc]init];
    data.baseURL = self.baseURL;
    data.methodName = self.methodName;
    data.parameters = self.parameters;
    data.files = self.files;
    return [[HTTPClient shareInstance] uploadFileWithData:data progress:progress success:success failure:failer];

}

- (NSURLSessionDataTask *)sendFormWithProgress:(void(^)(NSProgress *progress))progress
                                       success:(void(^)(NSURLSessionDataTask *task, id response))success
                                       failure:(void(^)(NSError *error))failer {
    [self config];
    ClientData *data = [[ClientData alloc]init];
    data.baseURL = self.baseURL;
    data.methodName = self.methodName;
    data.parameters = self.parameters;
    data.files = self.files;
    return [[HTTPClient shareInstance] sendFormWithData:data progress:progress success:success failure:failer];
}

- (NSURLSessionDownloadTask *)downLoadWithDestination: (NSURL *(^)(NSURL *targetPath, NSURLResponse *response )) destination
                                             progress:(void(^)(NSProgress *progress))progress
                                       downLoadFinish:(void(^)(NSURLResponse *response, NSURL *filePath, NSError *error))downLoadFinish {

    ClientData *data = [[ClientData alloc]init];
    data.baseURL = self.baseURL;
    return [[HTTPClient shareInstance] downLoadWithData:data destination:destination progress:progress downLoadFinish:downLoadFinish];
}

- (void)cancelAsynRequest {
    [[HTTPClient shareInstance] cancelAsynRequest];
}

- (NSDictionary *) getDefaultHTTPRequestHeaders {
    return [[HTTPClient shareInstance] getDefaultHTTPRequestHeaders];
}

#pragma - Getter And Setter
- (CGFloat)timeout {
    return 15.0f;
}

- (NSDictionary *)header {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"Content-Type"] = @"application/json";
    return [dict copy];
}

- (NSSet<NSString *> *)set {
    return [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"image/jpg", nil];
}

@end
