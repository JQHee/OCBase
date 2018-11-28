//
//  Global.h
//  OCBase
//
//  Created by HJQ on 2018/11/13.
//  Copyright © 2018 HJQ. All rights reserved.
//

/** 三原色 */
#define UIColorRGBA(_r, _g, _b, _a) [UIColor colorWithRed:_r/255.f green:_g/255.f blue:_b/255.f alpha:_a]
#define UIColorRgb(_r, _g, _b) UIColorRGBA(_r, _g, _b, 1.0f)

/** 传入色值 */
#define LFHEXCOLOR_a(hex,a) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:(a)]
#define LFHEXCOLOR(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1]

/** 随机色  */
#define LFRandomColor UIColorRgb(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))


/*! 常量 */
// static NSString* const kBase_URL=@"www.baidu.com";

//字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
//数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
//字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
//是否是空对象
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

//一些缩写
#define kApplication [UIApplication sharedApplication]
#define kKeyWindow [UIApplication sharedApplication].keyWindow
#define kAppDelegate [UIApplication sharedApplication].delegate
#define kUserDefaults [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]

/** 当前语言 */
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//获取一段时间间隔
#define kStartTime CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
#define kEndTime   NSLog(@"Time: %f", CFAbsoluteTimeGetCurrent() - start)

//弱引用/强引用
#define kWeakSelf(type)   __weak typeof(type) weak##type = type;
#define kStrongSelf(type) __strong typeof(type) type = weak##type;

/*! 复制文字内容 */
#define BAKit_CopyContent(content) [[UIPasteboard generalPasteboard] setString:content]

//上传图片相关
#define kImageCollectionCell_Width floorf((Main_Screen_Width - 10*2- 10*3)/3)
//最大的上传图片张数
#define kupdateMaximumNumberOfImage 12

//由角度转换弧度
#define kDegreesToRadian(x)      (M_PI * (x) / 180.0)
//由弧度转换角度
#define kRadianToDegrees(radian) (radian * 180.0) / (M_PI)

#import "LogManager.h"
// 记录本地日志

#define LLFileName [[NSString stringWithFormat:@"%s",__FILE__] lastPathComponent]
#define LLFileLine [NSString stringWithFormat:@"%d",__LINE__]
#define LLFileActionName [NSString stringWithFormat:@"%@",NSStringFromSelector(_cmd)]
#define LLFileInfo(type) [NSString stringWithFormat:@"%@ ->【%@ 方法名：%@ 第%@行】 logInfo:\n", type, LLFileName,LLFileActionName, LLFileLine]
#define LLog(module, ...) [[LogManager sharedInstance] logInfo:module logStr:__VA_ARGS__,nil]
#define LLogError(module, ...) LLog(module, LLFileInfo(@"Error"), __VA_ARGS__)
#define LLogSuccess(module, ...) LLog(module, LLFileInfo(@"Success"), __VA_ARGS__)
#define LLogWarning(module, ...) LLog(module, LLFileInfo(@"Warning"), __VA_ARGS__)
#define LLogInfo(module, ...) LLog(module, LLFileInfo(@"Info"), __VA_ARGS__)
#define LLogCrash(module, ...) LLog(module, LLFileInfo(@"Crash"), __VA_ARGS__)
