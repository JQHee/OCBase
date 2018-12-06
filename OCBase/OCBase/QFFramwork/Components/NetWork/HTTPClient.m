//
//  HTTPClient.m
//  OCBase
//
//  Created by HJQ on 2018/12/6.
//  Copyright © 2018年 HJQ. All rights reserved.
//

#import "HTTPClient.h"

/*! 主线程异步队列 */
#define network_dispatch_main_async_safe(block)        \
if ([NSThread isMainThread]) {                 \
block();                                       \
} else {                                       \
dispatch_async(dispatch_get_main_queue(), block);\
}

@interface HTTPClient()

@end

@implementation HTTPClient

static HTTPClient *_instance = nil;

+ (instancetype) shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[HTTPClient alloc] init];
    });
    return _instance;
}

- (void) startNetworkListening:(void(^)(NetworkReachabilityStatus status)) networkBlock {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            {
                // 未知网络
                if (networkBlock) {
                    networkBlock(unknown);
                }
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:
            {
                // 无法联网
                if (networkBlock) {
                    networkBlock(notReachable);
                }
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                //手机自带网络
                if (networkBlock) {
                    networkBlock(reachableViaWWAN);
                }
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                // WIFI
                if (networkBlock) {
                    networkBlock(reachableViaWiFi);
                }
            }
                
        }
    }];
    [manager startMonitoring];
}

- (void) setRequestSerializer: (NSDictionary *)header {
    if (header) {
        AFJSONRequestSerializer *requestSerializer = [[AFJSONRequestSerializer alloc] init];
        for (NSString *key in header) {
            [requestSerializer setValue:header[key] forHTTPHeaderField:key];
        }
        self.sessionManager.requestSerializer = requestSerializer;
    }
}

- (void) setAcceptableContentTypes: (NSSet <NSString *>*) set {
    self.sessionManager.responseSerializer.acceptableContentTypes = set;
}

- (void) setrRequestTimeout: (CGFloat)time {
    if (time > 0) {
        [self.sessionManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        self.sessionManager.requestSerializer.timeoutInterval = time;
        [self.sessionManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    }
}

- (NSURLSessionDataTask *)sendPostWithData:(ClientData *)data
                                  progress:(void(^)(NSProgress *progress))progress
                                   success:(void(^)(NSURLSessionDataTask *task, id response))success
                                   failure:(void(^)(NSError *error))failer {
    network_dispatch_main_async_safe(^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    })
    data.baseURL = data.baseURL ? : @"";
    data.methodName = data.methodName ? : @"";
    NSString *requestURL = [NSString stringWithFormat:@"%@%@", data.baseURL, data.methodName];
    NSURLSessionDataTask *task = [_sessionManager POST:requestURL parameters:data.parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress (uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        network_dispatch_main_async_safe(^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        })
        if (success) {
            success (task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        network_dispatch_main_async_safe(^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        })
        if (failer) {
            failer(error);
        }
    }];
    return task;
}

- (NSURLSessionDataTask *)sendGetWithData:(ClientData *)data
                                 progress:(void(^)(NSProgress *progress))progress
                                  success:(void(^)(NSURLSessionDataTask *task, id response))success
                                  failure:(void(^)(NSError *error))failer {
    network_dispatch_main_async_safe(^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    })
    data.baseURL = data.baseURL ? : @"";
    data.methodName = data.methodName ? : @"";
    NSString *requestURL = [NSString stringWithFormat:@"%@%@", data.baseURL, data.methodName];
    NSURLSessionDataTask *task = [_sessionManager GET:requestURL parameters:data.parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress (uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        network_dispatch_main_async_safe(^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        })
        if (success) {
            success (task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        network_dispatch_main_async_safe(^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        })
        if (failer) {
            failer(error);
        }
    }];
    return task;
}

- (NSURLSessionDataTask *)uploadFileWithData:(ClientData *)data
                                    progress:(void(^)(NSProgress *progress))progress
                                     success:(void(^)(NSURLSessionDataTask *task, id response))success
                                     failure:(void(^)(NSError *error))failer {
    network_dispatch_main_async_safe(^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    })
    data.baseURL = data.baseURL ? : @"";
    data.methodName = data.methodName ? : @"";
    NSString *requestURL = [NSString stringWithFormat:@"%@%@", data.baseURL, data.methodName];
    NSURLSessionDataTask *task = [_sessionManager POST:requestURL parameters:data.parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (data.files) {
            for (FileContentData *file in data.files) {
                if (file.fileData) {
                    [formData appendPartWithFileData:file.fileData name:file.name fileName:file.fileName mimeType:file.mimeType];
                } else {
                    [formData appendPartWithFileURL:file.fileURL name:file.name fileName:file.fileName mimeType:file.mimeType error:nil];
                }
                
            }
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress (uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        network_dispatch_main_async_safe(^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        })
        if (success) {
            success (task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        network_dispatch_main_async_safe(^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        })
        if (failer) {
            failer(error);
        }
    }];
    return task;
    
}

- (NSURLSessionDataTask *)sendFormWithData:(ClientData *)data
                                  progress:(void(^)(NSProgress *progress))progress
                                   success:(void(^)(NSURLSessionDataTask *task, id response))success
                                   failure:(void(^)(NSError *error))failer {
    network_dispatch_main_async_safe(^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    })
    data.baseURL = data.baseURL ? : @"";
    data.methodName = data.methodName ? : @"";
    NSString *requestURL = [NSString stringWithFormat:@"%@%@", data.baseURL, data.methodName];
    NSURLSessionDataTask *task = [_sessionManager POST:requestURL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (data.parameters) {
            NSData *contentData = [NSJSONSerialization dataWithJSONObject:data.parameters options:NSJSONWritingPrettyPrinted error:nil];
            [formData appendPartWithFormData:contentData name:@""];
        }
        if (data.files) {
            for (FileContentData *file in data.files) {
                if (file.fileData) {
                    [formData appendPartWithFileData:file.fileData name:file.name fileName:file.fileName mimeType:file.mimeType];
                } else {
                    [formData appendPartWithFileURL:file.fileURL name:file.name fileName:file.fileName mimeType:file.mimeType error:nil];
                }
                
            }
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress (uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        network_dispatch_main_async_safe(^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        })
        if (success) {
            success (task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        network_dispatch_main_async_safe(^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        })
        if (failer) {
            failer(error);
        }
    }];
    return task;
}

- (void)cancelAsynRequest {
    [self.sessionManager invalidateSessionCancelingTasks:YES];
}

- (NSDictionary *) getDefaultHTTPRequestHeaders {
    return self.sessionManager.requestSerializer.HTTPRequestHeaders;
}

#pragma - Setter And Getter
- (AFHTTPSessionManager *)sessionManager
{
    if (!_sessionManager) {
        _sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    return _sessionManager;
}

@end
