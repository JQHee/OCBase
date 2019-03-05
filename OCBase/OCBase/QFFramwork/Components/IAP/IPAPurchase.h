//
//  IPAPurchase.h
//  InPurchasing
//
//  Created by midland on 2019/3/5.
//  Copyright © 2019年 midland. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 block
 
 @param isSuccess 是否支付成功
 @param certificate 支付成功得到的凭证（用于在自己服务器验证）
 @param errorMsg 错误信息
 */
typedef void(^PayResult)(BOOL isSuccess, NSString * __nullable certificate, NSString *errorMsg);

@interface IPAPurchase : NSObject

@property (nonatomic,copy) NSString * order; // callback 返回的订单号
@property (nonatomic,copy) NSString * userid; // 游戏用户ID

@property (nonatomic, copy)PayResult payResultBlock;

/**
 单例方法
 */
+ (instancetype)manager;

/**
 开启内购监听 在程序入口didFinishLaunchingWithOptions实现
 */
-(void)startManager;

/**
 停止内购监听 在AppDelegate.m中的applicationWillTerminate方法实现
 */
-(void)stopManager;

/**
 拉起内购支付
 @param productID 内购商品ID
 @param payResult 结果
 */

-(void)buyProductWithProductID:(NSString *)productID payResult:(PayResult)payResult;


@end

NS_ASSUME_NONNULL_END
