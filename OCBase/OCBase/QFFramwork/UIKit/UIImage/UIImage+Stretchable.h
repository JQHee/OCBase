//
//  UIImage+Stretchable.h
//  OCBase
//
//  Created by HJQ on 2018/12/8.
//  Copyright © 2018 HJQ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Stretchable)

/* 拉伸新特性页 */
- (UIImage *)stretchableWidthScale: (CGFloat) widthScale
                       heightScale: (CGFloat) heightScale;

@end

NS_ASSUME_NONNULL_END
