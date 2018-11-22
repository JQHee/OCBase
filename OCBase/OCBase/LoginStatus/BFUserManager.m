//
//  BFUserManager.m
//  OCBase
//
//  Created by HJQ on 2018/11/22.
//  Copyright © 2018 HJQ. All rights reserved.
//

#import "BFUserManager.h"

@implementation BFUserManager

static BFUserManager *manager = nil;

+ (instancetype) shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[BFUserManager alloc]init];
    });
    return  manager;
}

@end
