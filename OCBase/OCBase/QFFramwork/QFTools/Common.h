//
//  Common.h
//  EsaiRecharge
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Common : NSObject

/**
 * 十六进制转颜色
 */
+ (UIColor *)hexStringToColor:(NSString *)colorNameString;

/**
 * 调整图片大小
 */
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;

/**
 * 获取文本尺寸 (fontSize:字体大小 width:指定宽度, 传0则表示不限制宽度)
 */
+ (CGSize)getExpectedContentSize:(NSString *)content fontSize:(CGFloat)fontSize width:(CGFloat)width;

/**
 * 判断图片是否达到一定尺寸,达到则做处理(主要用于发送图片到服务器时使用, 如店铺编辑, 上传图片)
 */
+ (NSData *)handleImageBySize:(UIImage *)image;

// 处理占位图片
+ (UIImage *)placeholderImageWithSize:(CGSize)size;

/*
 ** 颜色转图片
 */
+ (UIImage *)createImageWithColor:(UIColor *)color;

// 顶盖拉伸
+ (UIImage *)resizableImageWithName:(NSString *)imageName;

@end
