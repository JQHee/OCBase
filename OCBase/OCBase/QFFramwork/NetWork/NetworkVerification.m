//
//  NetworkVerification.m
//  CloudWork
//
//  Created by zyz on 13-5-20.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "NetworkVerification.h"
#import "YSBReachability.h"

@implementation NetworkVerification

//验证当前网络(-1:网络不通 1:使用3G 2:使用Wifi )
+(NSInteger) verificationCurrentNetwork {
    //return 2;//测试使用
    NSInteger ANetWorkStateInteger = -1;

    YSBReachability *r = [YSBReachability reachabilityForInternetConnection];

    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            ANetWorkStateInteger = -1;
            //   NSLog(@"没有网络");
            break;
        case ReachableViaWWAN:
            ANetWorkStateInteger = 1;
            //   NSLog(@"正在使用3G网络");
            break;
        case ReachableViaWiFi:
            ANetWorkStateInteger = 2;
            //  NSLog(@"正在使用wifi网络");
            break;
    }
    return ANetWorkStateInteger;
}

- (void) dealloc
{
    
}

@end
