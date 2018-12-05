//
//  BaseRequest.m
//  OCBase
//
//  Created by HJQ on 2018/12/5.
//  Copyright © 2018 HJQ. All rights reserved.
//

#import "BaseRequest.h"
#import <AFNetworking.h>
#import "FileContentData.h"

@interface BaseRequest()

@property(nonatomic,strong) AFHTTPSessionManager *sessionManager;

@end

@implementation BaseRequest

- (instancetype)init {
    self = [super init];
    if (self) {

    }
    return self;
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

- (NSURLSessionDataTask *)sendPostWithProgress:(ProgressHandler)progress
                     success:(SucessHandler)success
                     failure:(FailureHandler)failer {

    self.baseURL = self.baseURL ? : @"";
    self.methodName = self.methodName ? : @"";
    NSString *requestURL = [NSString stringWithFormat:@"%@%@", self.baseURL, self.methodName];
    NSURLSessionDataTask *task = [_sessionManager POST:requestURL parameters:self.parameters progress:^(NSProgress * _Nonnull uploadProgress) {
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

- (NSURLSessionDataTask *)sendGetWithProgress:(ProgressHandler)progress
                    success:(SucessHandler)success
                    failure:(FailureHandler)failer {
    self.baseURL = self.baseURL ? : @"";
    self.methodName = self.methodName ? : @"";
    NSString *requestURL = [NSString stringWithFormat:@"%@%@", self.baseURL, self.methodName];
    NSURLSessionDataTask *task = [_sessionManager GET:requestURL parameters:self.parameters progress:^(NSProgress * _Nonnull uploadProgress) {
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

-(NSURLSessionDataTask *)uploadFileWithProgress:(ProgressHandler)progress
                      success:(SucessHandler)success
                      failure:(FailureHandler)failer {
    self.baseURL = self.baseURL ? : @"";
    self.methodName = self.methodName ? : @"";
    NSString *requestURL = [NSString stringWithFormat:@"%@%@", self.baseURL, self.methodName];
    NSURLSessionDataTask *task = [_sessionManager POST:requestURL parameters:self.parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (self.files) {
            for (FileContentData *file in self.files) {
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

#pragma - Setter And Getter
- (AFHTTPSessionManager *)sessionManager
{
    if (!_sessionManager) {

        AFJSONRequestSerializer *requestSerializer = [[AFJSONRequestSerializer alloc] init];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

        _sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        _sessionManager.requestSerializer = requestSerializer;
    }
    return _sessionManager;
}

- (NSDictionary *) getDefaultHTTPRequestHeaders {
    return self.sessionManager.requestSerializer.HTTPRequestHeaders;
}

@end
