//
//  BaseRequest.h
//  OCBase
//
//  Created by HJQ on 2018/12/5.
//  Copyright © 2018 HJQ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SucessHandler)(NSURLSessionDataTask *task, id response);
typedef void(^ProgressHandler)(NSProgress *progressBlock);
typedef void(^FailureHandler)(NSError *error);

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
- (NSURLSessionDataTask *)sendPostWithProgress:(ProgressHandler)progress
                     success:(SucessHandler)success
                     failure:(FailureHandler)failer;

// GET请求
- (NSURLSessionDataTask *)sendGetWithProgress:(ProgressHandler)progress
                    success:(SucessHandler)success
                    failure:(FailureHandler)failer;

// 带文件上传
-(NSURLSessionDataTask *)uploadFileWithProgress:(ProgressHandler)progress
                      success:(SucessHandler)success
                      failure:(FailureHandler)failer;
// 取消网络请求
- (void)cancelAsynRequest;

// 获取默认请求的（有时候需要useragent）
- (NSDictionary *) getDefaultHTTPRequestHeaders;

@end

NS_ASSUME_NONNULL_END
