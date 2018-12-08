//
//  UIImage+Stretchable.m
//  OCBase
//
//  Created by HJQ on 2018/12/8.
//  Copyright © 2018 HJQ. All rights reserved.
//

#import "UIImage+Stretchable.h"

@implementation UIImage (Stretchable)

// 0.99
- (UIImage *)stretchableWidthScale: (CGFloat) widthScale
                       heightScale: (CGFloat) heightScale {
    return [self stretchableImageWithLeftCapWidth:self.size.width * widthScale topCapHeight:self.size.height * heightScale];
}

@end
