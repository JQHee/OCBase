//
//  LocationManager.h
//  CityListDemo
//
//  Created by midland on 2018/11/12.
//  Copyright © 2018年 midland. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MLLocationManagerDelegate <NSObject>

/// 定位中
- (void)locating;

/**
 当前位置
 
 @param locationDictionary 位置信息字典
 */
- (void)currentLocation:(NSDictionary *)locationDictionary;

/**
 拒绝定位后回调的代理
 
 @param message 提示信息
 */
@optional
- (void)refuseToUsePositioningSystem:(NSString *)message;

/**
 定位失败回调的代理
 
 @param message 提示信息
 */
@optional
- (void)locateFailure:(NSString *)message;

@end

@interface MLLocationManager : NSObject

@property (nonatomic, weak) id<MLLocationManagerDelegate> delegate;

@end
