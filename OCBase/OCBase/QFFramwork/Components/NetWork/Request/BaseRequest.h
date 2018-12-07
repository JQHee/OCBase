//
//  BaseRequest.h
//  OCBase
//
//  Created by HJQ on 2018/12/5.
//  Copyright © 2018 HJQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileContentData.h"

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
@property (nonatomic, assign) CGFloat timeout;
// 请求头
@property (nonatomic, strong) NSDictionary *header;
// 响应类型
@property (nonatomic, strong) NSSet <NSString *> *set;
// 是否保存本地
@property (nonatomic, assign) BOOL isSaveCache;

// 同步请求

// POST 请求
- (NSURLSessionDataTask *)synchronouslyPostWithProgress:(void(^)(NSProgress *progress))progress
                                             cacheBlock:(void(^)(id response)) cacheBlock
                                       success:(void(^)(NSURLSessionDataTask *task, id response))success
                                       failure:(void(^)(NSError *error))failer;

// GET请求
- (NSURLSessionDataTask *)synchronouslyGetWithProgress:(void(^)(NSProgress *progress))progress
                                            cacheBlock: (void(^)(id response)) cacheBlock
                                      success:(void(^)(NSURLSessionDataTask *task, id response))success
                                      failure:(void(^)(NSError *error))failer;

/// 异步请求

// POST 请求
- (NSURLSessionDataTask *)sendPostWithProgress:(void(^)(NSProgress *progress))progress
                                    cacheBlock:(void(^)(id response)) cacheBlock
                                       success:(void(^)(NSURLSessionDataTask *task, id response))success
                                       failure:(void(^)(NSError *error))failer;

// GET请求
- (NSURLSessionDataTask *)sendGetWithProgress:(void(^)(NSProgress *progress))progress
                                   cacheBlock:(void(^)(id response)) cacheBlock
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

// 文件下载
- (NSURLSessionDownloadTask *)downLoadWithDestination: (NSURL *(^)(NSURL *targetPath, NSURLResponse *response )) destination
                                             progress:(void(^)(NSProgress *progress))progress
                                       downLoadFinish:(void(^)(NSURLResponse *response, NSURL *filePath, NSError *error))downLoadFinish;

// 取消网络请求
- (void)cancelAsynRequest;

// 获取默认请求的（有时候需要useragent）
- (NSDictionary *) getDefaultHTTPRequestHeaders;

@end

NS_ASSUME_NONNULL_END
