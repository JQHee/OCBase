//
//  NetworkVerification.h
//  CloudWork
//
//  Created by zyz on 13-5-20.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkVerification : NSObject

/**
 *验证当前网络(-1:网络不通 1:使用3G 2:使用Wifi )
 */
+(NSInteger) verificationCurrentNetwork;

@end
