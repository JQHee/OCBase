//
//  FontSize.m
//  OCBase
//
//  Created by midland on 2018/12/3.
//  Copyright © 2018年 HJQ. All rights reserved.
//

#import "FontSize.h"

@interface FontSize ()

@property (assign, nonatomic) CGFloat fontSize;

@end

@implementation FontSize

static FontSize *_manager = nil;

+ (instancetype) shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[FontSize alloc]init];
        [_manager fontSizeScale];
    });
    return _manager;
}

- (void)setFontSize:(CGFloat)fontSize {
    _fontSize = fontSize;
}

- (CGFloat)fontSizeScale: (CGFloat)scale {
    return scale * self.fontSize;
}

- (void)fontSizeScale {
    if (iPhone7P) { // iPhone7P上的字体尺寸
        self.fontSize = 1.1;
        
    } else if(iPhone7) { // iPhone7上的字体尺寸
        
        self.fontSize = 1.0;
    } else if(iPhoneSE) { // iPhoneSE上的字体尺寸
        
        self.fontSize = 0.9;
    }  else if(iPhone4s) { // iPhone4s上的字体尺寸
        
        self.fontSize = 0.7;
    } else { // 其他设备上的字体尺寸
        
        self.fontSize = 1.5;
    }
    
}

@end
