//
//  Common.m
//  EsaiRecharge

#import "Common.h"

@implementation Common

//十六进制转颜色
+ (UIColor *)hexStringToColor:(NSString *)colorNameString {
    NSString *cString = [[colorNameString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 charactersif ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appearsif ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];

    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;

    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];

    UIColor *color = [[UIColor alloc] initWithRed:(float)r / 255.0f green:(float)g / 255.0f blue:(float)b / 255.0f alpha:1.0f];

    return color;
}

//获取文本尺寸
+ (CGSize)getExpectedContentSize:(NSString *)content fontSize:(CGFloat)fontSize width:(CGFloat)width {
    width = width == 0 ? MAXFLOAT : width;
    CGSize maximumLabelSizeOne = CGSizeMake(width, MAXFLOAT);
    /*
    CGSize expectedLabelSizeOne = [content sizeWithFont:font
                                      constrainedToSize:maximumLabelSizeOne
                                          lineBreakMode:NSLineBreakByWordWrapping];
    */

    NSDictionary *attribute = @{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]};

    CGSize size = [content boundingRectWithSize:maximumLabelSizeOne options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;

    return size;
}

/**
 传入需要的占位图尺寸 获取占位图
 
 @param size 需要的站位图尺寸
 @return 占位图
 */
+ (UIImage *)placeholderImageWithSize:(CGSize)size {
    
    // 占位图的背景色
    UIColor *backgroundColor = [UIColor colorWithRed:175.0/255 green:182.0/255 blue:182.0/255 alpha:1];
    //UIColor *backgroundColor = [UIColor whiteColor];

    // 中间LOGO图片
    UIImage *image = [UIImage imageNamed:@"appDefault"];
    // 根据占位图需要的尺寸 计算 中间LOGO的宽高
   // CGFloat logoWH = (size.width > size.height ? size.height : size.width) * 0.5;
    //CGSize logoSize = CGSizeMake(logoWH, logoWH);
    // 打开上下文
    UIGraphicsBeginImageContextWithOptions(size,0, [UIScreen mainScreen].scale);
    // 绘图
    [backgroundColor set];
    UIRectFill(CGRectMake(0,0, size.width, size.height));
//    CGFloat imageX = (size.width / 2) - (logoSize.width / 2);
//    CGFloat imageY = (size.height / 2) - (logoSize.height / 2);
    //[image drawInRect:CGRectMake(imageX, imageY, logoSize.width, logoSize.height)];
    CGFloat imageX = (size.width - image.size.width) / 2.0;
    [image drawInRect:CGRectMake(imageX, 0, image.size.width, size.height)];
    UIImage *resImage =UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return resImage;
    
}

//调整图片大小
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

+ (UIImage *)resizableImageWithName:(NSString *)imageName {
    
    // 加载原有图片
    UIImage *norImage = [UIImage imageNamed:imageName];
    // 获取原有图片的宽高的一半
    CGFloat w = norImage.size.width * 0.5;
    CGFloat h = norImage.size.height * 0.5;
    // 生成可以拉伸指定位置的图片
    UIImage *newImage = [norImage resizableImageWithCapInsets:UIEdgeInsetsMake(15, 10, h, w) resizingMode:UIImageResizingModeStretch];
    return newImage;
    
}

//判断图片是否达到一定尺寸,达到则做处理(主要用于发送图片到服务器时使用, 如店铺编辑, 上传图片)
+ (NSData *)handleImageBySize:(UIImage *)image {
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    NSInteger imageSize = [imageData length] / 1024 + 30; //KB
    if (imageSize < 200)
        return imageData;

    UIImage *handImage = image;
    if (image.size.width > 1500 || image.size.height > 1500) {
        CGFloat imageW = 1500;
        CGFloat imageH = 1500;
        CGFloat scale = image.size.width / image.size.height; //比例

        if (image.size.width > image.size.height) {
            //横向图片
            imageH = imageW / scale;
            handImage = [self scaleToSize:image size:CGSizeMake(imageW, imageH)];
        } else {
            imageW = imageH * scale;
            handImage = [self scaleToSize:image size:CGSizeMake(imageW, imageH)];
        }
    }

    return UIImageJPEGRepresentation(handImage, 0.3);
}

//颜色转图片
+ (UIImage *)createImageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
