//
//  BaseRequest.h
//  OCBase
//
//  Created by HJQ on 2018/12/5.
//  Copyright © 2018 HJQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetWorkHeader.h"

NS_ASSUME_NONNULL_BEGIN

@class FileContentData;

@interface BaseRequest : NSObject
// 请求基本链接
@property (nonatomic, strong) NSString *baseURL;
// 请求方法名
@property (nonatomic, strong) NSString *methodName;
// 请求参数
@property (nonatomic, strong) NSDictionary *parameters;
// 文件数组
@property (nonatomic, strong) NSArray <FileContentData *> *files;

// 超时时间
- (void) setTimeout: (CGFloat)time;
// 设置请求头 {"key": "value"}
- (void) setRequestSerializer: (NSDictionary *)header;
// 响应类型
- (void) setAcceptableContentTypes: (NSSet <NSString *>*) set;

// POST 请求
- (NSURLSessionDataTask *)sendPostWithProgress:(void(^)(NSProgress *progress))progress
                     success:(void(^)(NSURLSessionDataTask *task, id response))success
                     failure:(void(^)(NSError *error))failer;

// GET请求
- (NSURLSessionDataTask *)sendGetWithProgress:(void(^)(NSProgress *progress))progress
                    success:(void(^)(NSURLSessionDataTask *task, id response))success
                    failure:(void(^)(NSError *error))failer;

// 带文件上传
- (NSURLSessionDataTask *)uploadFileWithProgress:(void(^)(NSProgress *progress))progress
                      success:(void(^)(NSURLSessionDataTask *task, id response))success
                      failure:(void(^)(NSError *error))failer;

// POST表单格式提交
- (NSURLSessionDataTask *)sendFormWithProgress:(void(^)(NSProgress *progress))progress
                                         success:(void(^)(NSURLSessionDataTask *task, id response))success
                                         failure:(void(^)(NSError *error))failer;

// 取消网络请求
- (void)cancelAsynRequest;

// 获取默认请求的（有时候需要useragent）
- (NSDictionary *) getDefaultHTTPRequestHeaders;

@end

NS_ASSUME_NONNULL_END
