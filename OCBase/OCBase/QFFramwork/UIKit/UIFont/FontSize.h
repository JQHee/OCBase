//
//  FontSize.h
//  OCBase
//
//  Created by midland on 2018/12/3.
//  Copyright © 2018年 HJQ. All rights reserved.
//

#import <Foundation/Foundation.h>

/*********** 屏幕宽高 ************/
#define SCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

/*********** 机型判断 ************/
#define iPhone4s (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define iPhoneSE (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define iPhone7 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define iPhone7P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

// 自适应字体大小
#define fontSizeScale(size) [[FontSize shareInstance] fontSizeScale:size]
/*********** 常用字体大小 ************/
#define DRFont(size) [UIFont systemFontOfSize:fontSizeScale(size)]
/*********** 常用粗体大小 ************/
#define DRBoldFont(size) [UIFont boldSystemFontOfSize:fontSizeScale(size)]


NS_ASSUME_NONNULL_BEGIN

@interface FontSize : NSObject

// 单例
+ (instancetype) shareInstance;

// 获取字体大小
- (CGFloat)fontSizeScale: (CGFloat)scale;

@end

NS_ASSUME_NONNULL_END
