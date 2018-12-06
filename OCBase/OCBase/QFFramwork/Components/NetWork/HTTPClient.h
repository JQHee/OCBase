//
//  HTTPClient.h
//  OCBase
//
//  Created by HJQ on 2018/12/6.
//  Copyright © 2018年 HJQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "NetWorkHeader.h"


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, NetworkReachabilityStatus) {
    unknown          = -1, //未知
    notReachable     = 0,  //无连接
    reachableViaWWAN = 1,  //3G
    reachableViaWiFi = 2,  //WIFI
};

@class ClientData;
@interface HTTPClient : NSObject

@property(nonatomic,strong) AFHTTPSessionManager *sessionManager;

+ (instancetype) shareInstance;

// 使用网络监听器 如果需要同步获取请使用 Reachability框架
- (void) startNetworkListening:(void(^)(NetworkReachabilityStatus status)) networkBlock;

// 超时时间
- (void) setrRequestTimeout: (CGFloat)time;
// 设置请求头 {"key": "value"}
- (void) setRequestSerializer: (NSDictionary *)header;
// 响应类型
- (void) setAcceptableContentTypes: (NSSet <NSString *>*) set;

// POST 请求
- (NSURLSessionDataTask *)sendPostWithData:(ClientData *)data
                                  progress:(void(^)(NSProgress *progress))progress
                                   success:(void(^)(NSURLSessionDataTask *task, id response))success
                                   failure:(void(^)(NSError *error))failer;

// GET请求
- (NSURLSessionDataTask *)sendGetWithData:(ClientData *)data
                                 progress:(void(^)(NSProgress *progress))progress
                                  success:(void(^)(NSURLSessionDataTask *task, id response))success
                                  failure:(void(^)(NSError *error))failer;

// 带文件上传
- (NSURLSessionDataTask *)uploadFileWithData:(ClientData *)data
                                   progress:(void(^)(NSProgress *progress))progress
                                    success:(void(^)(NSURLSessionDataTask *task, id response))success
                                    failure:(void(^)(NSError *error))failer;

// 表单上传
- (NSURLSessionDataTask *)sendFormWithData:(ClientData *)data
                                  progress:(void(^)(NSProgress *progress))progress
                                   success:(void(^)(NSURLSessionDataTask *task, id response))success
                                   failure:(void(^)(NSError *error))failer;
// 取消网络请求
- (void)cancelAsynRequest;

// 获取默认请求的（有时候需要useragent）
- (NSDictionary *) getDefaultHTTPRequestHeaders;

@end

NS_ASSUME_NONNULL_END
