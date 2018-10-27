//
//  QFLocationInfo.h
//  Yuansubei
//
//  Created by HJQ on 2017/4/20.
//  Copyright © 2017年 HJQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QFLocationInfo : NSObject

// 单例
+ (instancetype)shareInfo;

// 清空信息
- (void)removeAllData;

// 纬度
@property (nonatomic, assign) CGFloat latitude;
// 经度
@property (nonatomic, assign) CGFloat longtitude;
// 城市
@property (nonatomic, strong) NSString *city;

@end
