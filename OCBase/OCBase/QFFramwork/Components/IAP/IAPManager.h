//
//  IAPManager.h
//  InPurchasing
//
//  Created by midland on 2019/3/5.
//  Copyright © 2019年 midland. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@class SKProduct;

typedef NS_ENUM(NSUInteger,IAPResultType) {
    IAPResultSuccess = 0,       // 购买成功
    IAPResultFailed = 1,        // 购买失败
    IAPResultCancle = 2,        // 取消购买
    IAPResultVerFailed = 3,     // 订单校验失败
    IAPResultVerSuccess = 4,    // 订单校验成功
    IAPResultNotArrow = 5,      // 不允许内购
    IAPResultIDError = 6,       // 项目ID错误
};

typedef void(^IAPCompletionHandle)(IAPResultType type,NSData *data);

@interface IAPManager : NSObject

/**
 单例模式
 
 @return HZIAPManager
 */
+ (instancetype)shareIAPManager;

/**
 *  判断用户是否具有内购权限 (家长权限控制)
 */
- (BOOL)determineUserHasPaymentAuthority;

/**
 根据不同地区AppleID / AppStore 位置展示不同的货币
 
 @param product 商品信息
 @param countryCodeBlock 回调相应的国家码
 */
- (void)judgeWhichCountryWithProduct:(SKProduct *)product countryCodeBlock:(void(^)(NSString *countryCode)) countryCodeBlock;

/**
 开启内购
 
 @param productID 内购项目的产品ID
 @param handle 内购的结果回调
 */
- (void)startIAPWithProductID:(NSString *)productID  completeHandle: (IAPCompletionHandle)handle;

@end

NS_ASSUME_NONNULL_END
