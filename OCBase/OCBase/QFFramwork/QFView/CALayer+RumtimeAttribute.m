//
//  CALayer+RumtimeAttribute.m
//  LoveCar
//
//  Created by apple on 16/4/15.
//  Copyright © 2016年 aichezhonghua. All rights reserved.
//

#import "CALayer+RumtimeAttribute.h"

@implementation CALayer (RumtimeAttribute)

- (void)setBorderIBColor:(UIColor *)borderIBColor

{
    self.borderColor = borderIBColor.CGColor;
}

- (UIColor *)borderIBColor

{
    return [UIColor colorWithCGColor:self.borderColor];
}

@end
