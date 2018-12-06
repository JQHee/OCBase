//
//  HTTPClient.m
//  OCBase
//
//  Created by midland on 2018/12/6.
//  Copyright © 2018年 HJQ. All rights reserved.
//

#import "HTTPClient.h"

@implementation HTTPClient

static HTTPClient *_instance = nil;

+ (instancetype) shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[HTTPClient alloc] init];
    });
    return _instance;
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

- (void) setTimeout: (CGFloat)time {
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
    
    data.baseURL = data.baseURL ? : @"";
    data.methodName = data.methodName ? : @"";
    NSString *requestURL = [NSString stringWithFormat:@"%@%@", data.baseURL, data.methodName];
    NSURLSessionDataTask *task = [_sessionManager POST:requestURL parameters:data.parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress (uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success (task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
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
    data.baseURL = data.baseURL ? : @"";
    data.methodName = data.methodName ? : @"";
    NSString *requestURL = [NSString stringWithFormat:@"%@%@", data.baseURL, data.methodName];
    NSURLSessionDataTask *task = [_sessionManager GET:requestURL parameters:data.parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress (uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success (task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
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
        if (success) {
            success (task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
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
        if (success) {
            success (task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
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
