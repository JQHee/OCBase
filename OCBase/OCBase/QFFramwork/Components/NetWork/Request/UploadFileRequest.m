//
//  UploadFileRequest.m
//  OCBase
//
//  Created by HJQ on 2018/12/6.
//  Copyright © 2018年 HJQ. All rights reserved.
//

#import "UploadFileRequest.h"

@implementation UploadFileRequest

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma - Getter And Setter
- (CGFloat)timeout {
    return 60.0f;
}

- (NSDictionary *)header {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"Content-Type"] = @"multipart/form-data;";
    return [dict copy];
}

- (NSSet<NSString *> *)set {
    return [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"image/jpg", nil];
}

@end
