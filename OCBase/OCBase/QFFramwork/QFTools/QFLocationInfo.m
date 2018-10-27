//
//  QFLocationInfo.m
//  Yuansubei
//
//  Created by HJQ on 2017/4/20.
//  Copyright © 2017年 HJQ. All rights reserved.
//

#import "QFLocationInfo.h"


@implementation QFLocationInfo

@synthesize city = _city;
@synthesize latitude = _latitude;
@synthesize longtitude = _longtitude;

#pragma mark: - setter And getter Methods


- (void)setCity:(NSString *)city {
    _city = city;
    [[NSUserDefaults standardUserDefaults] setObject:city forKey:@"LocationCity"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setLongtitude:(CGFloat)longtitude {
    _longtitude = longtitude;
    [[NSUserDefaults standardUserDefaults] setFloat:longtitude forKey:@"LocationLongtitude"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setLatitude:(CGFloat)latitude {
    _latitude = latitude;
    [[NSUserDefaults standardUserDefaults] setFloat:latitude forKey:@"LocationLatitude"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (CGFloat)latitude {
    return [[[NSUserDefaults standardUserDefaults] valueForKey:@"LocationLatitude"] floatValue];
}

- (CGFloat)longtitude {
    return [[[NSUserDefaults standardUserDefaults] valueForKey:@"LocationLongtitude"] floatValue];
}

- (NSString *)city {
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"LocationCity"];

}


+ (instancetype)shareInfo {
    static QFLocationInfo *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
    });
    return instance;
}



- (void)removeAllData {
    [[QFLocationInfo shareInfo] setLatitude:0.0];
    [[QFLocationInfo shareInfo] setLongtitude:0.0];
    [[QFLocationInfo shareInfo] setCity:nil];
    
}

@end
