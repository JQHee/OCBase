//
//  List.m
//  elmsc
//
//  Created by qinfensky on 2016/11/7.
//  Copyright © 2016年 GFB Network Technology Co.,Ltd. All rights reserved.
//
#pragma mark - 宏集合
#ifdef DEBUG
// #define NSLog(...) NSLog(__VA_ARGS__)
#define NSLog(fmt, ...) NSLog((@"【%s-第%d行】" fmt), [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, ##__VA_ARGS__);
#define debugMethod NSLog(@"%s", __FUNCTION__)
#else
#define NSLog(...)
#define debugMethod()
#endif
#define APPWindow [UIApplication sharedApplication].keyWindow
#define PrintJSON                \
    debugLog(@"JSON数据完成:%@", \
             [[NSString alloc] initWithData:[responseObject mj_JSONData] encoding:NSUTF8StringEncoding])
#define frameW [UIScreen mainScreen].bounds.size.width
#define frameH [UIScreen mainScreen].bounds.size.height
#define themeColor [UIColor colorWithRed:0.78 green:0.78 blue:0.78 alpha:1.00];

#pragma mark: - 通知相关
// 订单
#define kOrderNotification  @"kOrderNotification"
#define kAliPayResultNotification @"kAliPayResultNotification"
// 保存城市的数据
#define kAllCitysData  @"kAllCitysData"


#pragma mark - 自定义 UI 集合
#import "CALayer+RumtimeAttribute.h"
#import "QFBaseTableViewController.h"
#import "QFBaseViewController.h"
#import "QFBigText.h"
#import "UIButton+QFButtonCountDown.h"
#import "ZJScrollPageView.h"
#import "YSBStarView.h"

#pragma mark - 工具集合
#import "Common.h"
#import "NSString+check.h"
#import "QFCheckTools.h"
#import "UIDevice+Core.h"
//#import "QFMediaManager.h"
#import "QFNetworking.h"
#import "QFPhoneManagerVC.h"
#import "QFSecurityTools.h"
#import "QFUserInfo.h"
#import "UIViewExt.h"
#import "NSData+AES256.h"
#import "GTMBase64.h"
#import "NetworkVerification.h"
#import "QFLocationInfo.h"
#import "UIScrollView+Core.h"
#import "Singleton.h"
#import "MainThread.h"
#import "Global.h"
#import "GCDTool.h"

#pragma mark - 库集合
#import "DateTools.h"
#import "FDStackView.h"
//#import "HYBImageCliped.h"
#import "IQKeyboardManager.h"
#import "MBProgressHUD.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "Masonry.h"
#import "POP.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD+Core.h"
// #import "YYText.h"
// #import "CocoaSecurity.h"
// #import <Realm/Realm.h>
#import "UIScrollView+EmptyDataSet.h"


