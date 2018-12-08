//
//  BLDelayStartupTool.h
//  OCBase
//
//  Created by HJQ on 2018/12/8.
//  Copyright © 2018 HJQ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BLDelayStartupTool : NSObject

/**
 * 启动伴随 didFinishLaunchingWithOptions 启动的事件.
 * 启动类型为:日志 / 统计等需要第一时间启动的.
 */
+ (void)startupEventsOnAppDidFinishLaunchingWithOptions;

/**
 * 启动可以在展示广告的时候初始化的事件.
 * 启动类型为: 用户数据需要在广告显示完成以后使用, 所以需要伴随广告页启动.
 */
+ (void)startupEventsOnADTime;

/**
 * 启动在第一个界面显示完(用户已经进入主界面)以后可以加载的事件.
 * 启动类型为: 比如直播和分享等业务, 肯定是用户能看到真正的主界面以后才需要启动, 所以推迟到主界面加载完成以后启动.
 */
+ (void)startupEventsOnDidAppearAppContent;


@end

NS_ASSUME_NONNULL_END
