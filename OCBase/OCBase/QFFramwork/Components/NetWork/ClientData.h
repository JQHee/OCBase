//
//  ClientData.h
//  OCBase
//
//  Created by HJQ on 2018/12/6.
//  Copyright © 2018年 HJQ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class FileContentData;

@interface ClientData : NSObject

// 请求基本链接
@property (nonatomic, strong) NSString *baseURL;
// 请求方法名
@property (nonatomic, strong) NSString *methodName;
// 请求参数
@property (nonatomic, strong) NSDictionary *parameters;
// 文件数组
@property (nonatomic, strong) NSArray <FileContentData *> *files;
// 本地缓存
@property (nonatomic, assign) BOOL isLoadLocalCache;

@end

NS_ASSUME_NONNULL_END
