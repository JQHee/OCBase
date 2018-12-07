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

- (BOOL)isReachable {
    return [[AFNetworkReachabilityManager sharedManager] isReachable];
}

- (BOOL)isReachableViaWiFi {
    return [[AFNetworkReachabilityManager sharedManager] isReachableViaWiFi];
}

- (BOOL) isReachableViaWWAN {
    return [[AFNetworkReachabilityManager sharedManager] isReachableViaWWAN];
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

#pragma - 同步的网络请求
- (NSURLSessionDataTask *)synchronouslyPOSTWithData:(ClientData *)data
                                       progress:(void(^)(NSProgress *progress))progress
                                        success:(void(^)(NSURLSessionDataTask *task, id response))success
                                        failure:(void(^)(NSError *error))failer {
    network_dispatch_main_async_safe(^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    })
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    data.baseURL = data.baseURL ? : @"";
    data.methodName = data.methodName ? : @"";
    NSString *requestURL = [NSString stringWithFormat:@"%@%@", data.baseURL, data.methodName];
    if (self.securityPolicyCerPath) {
        [_sessionManager setSecurityPolicy:[self customSecurityPolicy]];
    }
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
        dispatch_semaphore_signal(semaphore);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        network_dispatch_main_async_safe(^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        })
        if (failer) {
            failer(error);
        }
        dispatch_semaphore_signal(semaphore);
    }];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    return task;
}

- (NSURLSessionDataTask *)synchronouslyGetWithData:(ClientData *)data
                                 progress:(void(^)(NSProgress *progress))progress
                                  success:(void(^)(NSURLSessionDataTask *task, id response))success
                                  failure:(void(^)(NSError *error))failer {
    network_dispatch_main_async_safe(^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    })
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    data.baseURL = data.baseURL ? : @"";
    data.methodName = data.methodName ? : @"";
    NSString *requestURL = [NSString stringWithFormat:@"%@%@", data.baseURL, data.methodName];
    if (self.securityPolicyCerPath) {
        [_sessionManager setSecurityPolicy:[self customSecurityPolicy]];
    }
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
        dispatch_semaphore_signal(semaphore);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        network_dispatch_main_async_safe(^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        })
        if (failer) {
            failer(error);
        }
        dispatch_semaphore_signal(semaphore);
    }];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    return task;
}

#pragma - 异步网络请求
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
    if (self.securityPolicyCerPath) {
        [_sessionManager setSecurityPolicy:[self customSecurityPolicy]];
    }
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
    if (self.securityPolicyCerPath) {
        [_sessionManager setSecurityPolicy:[self customSecurityPolicy]];
    }
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
    if (self.securityPolicyCerPath) {
        [_sessionManager setSecurityPolicy:[self customSecurityPolicy]];
    }
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
    if (self.securityPolicyCerPath) {
        [_sessionManager setSecurityPolicy:[self customSecurityPolicy]];
    }
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

- (NSURLSessionDownloadTask *)downLoadWithData:(ClientData *)data
                                   destination: (NSURL *(^)(NSURL *targetPath, NSURLResponse *response )) destination
                                      progress:(void(^)(NSProgress *progress))progress
                                downLoadFinish:(void(^)(NSURLResponse *response, NSURL *filePath, NSError *error))downLoadFinish {
    /* 创建网络下载对象 */
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    /* 下载地址 */
    NSURL *url = [NSURL URLWithString:data.baseURL ? : @" "];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    /* 下载路径 */
    // NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    // NSString *filePath = [path stringByAppendingPathComponent:url.lastPathComponent];
    
    /* 开始请求下载 */
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        // NSLog(@"下载进度：%.0f％", downloadProgress.fractionCompleted * 100);
        if (progress) {
            progress (downloadProgress);
        }
    } destination:destination completionHandler:downLoadFinish];
    [downloadTask resume];
    return downloadTask;
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

//添加证书
- (AFSecurityPolicy *)customSecurityPolicy {
    // /先导入证书
    //NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"aichewang.cer" ofType:nil]; //证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:self.securityPolicyCerPath];
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    // validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    securityPolicy.pinnedCertificates = [[NSSet alloc] initWithObjects:certData, nil];
    return securityPolicy;
}

@end
