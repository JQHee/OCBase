//
//  BaseRequest.m
//  OCBase
//
//  Created by HJQ on 2018/12/5.
//  Copyright © 2018 HJQ. All rights reserved.
//

#import "BaseRequest.h"

@interface BaseRequest()


@end

@implementation BaseRequest

- (instancetype)init {
    self = [super init];
    if (self) {

    }
    return self;
}

- (void) setRequestSerializer: (NSDictionary *)header {
    [[HTTPClient shareInstance] setRequestSerializer:header];
}

- (void) setAcceptableContentTypes: (NSSet <NSString *>*) set {
    [[HTTPClient shareInstance] setAcceptableContentTypes:set];
}

- (void) setTimeout: (CGFloat)time {
    [[HTTPClient shareInstance] setTimeout:time];
}

// POST 请求
- (NSURLSessionDataTask *)sendPostWithProgress:(void(^)(NSProgress *progress))progress
                                       success:(void(^)(NSURLSessionDataTask *task, id response))success
                                       failure:(void(^)(NSError *error))failer {

    ClientData *data = [[ClientData alloc]init];
    data.baseURL = self.baseURL;
    data.methodName = self.methodName;
    data.parameters = self.parameters;
    return [[HTTPClient shareInstance] sendPostWithData:data progress:progress success:success failure:failer];
}

- (NSURLSessionDataTask *)sendGetWithProgress:(void(^)(NSProgress *progress))progress
                                      success:(void(^)(NSURLSessionDataTask *task, id response))success
                                      failure:(void(^)(NSError *error))failer {
    ClientData *data = [[ClientData alloc]init];
    data.baseURL = self.baseURL;
    data.methodName = self.methodName;
    data.parameters = self.parameters;
    return [[HTTPClient shareInstance] sendGetWithData:data progress:progress success:success failure:failer];
}

- (NSURLSessionDataTask *)uploadFileWithProgress:(void(^)(NSProgress *progress))progress
                                         success:(void(^)(NSURLSessionDataTask *task, id response))success
                                         failure:(void(^)(NSError *error))failer {
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
    ClientData *data = [[ClientData alloc]init];
    data.baseURL = self.baseURL;
    data.methodName = self.methodName;
    data.parameters = self.parameters;
    data.files = self.files;
    return [[HTTPClient shareInstance] sendFormWithData:data progress:progress success:success failure:failer];
}

- (void)cancelAsynRequest {
    [[HTTPClient shareInstance] cancelAsynRequest];
}

- (NSDictionary *) getDefaultHTTPRequestHeaders {
    return [[HTTPClient shareInstance] getDefaultHTTPRequestHeaders];
}

@end
