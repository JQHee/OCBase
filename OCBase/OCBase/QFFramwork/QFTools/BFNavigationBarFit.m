//
//  BFNavigationBarFit.m
//  OCBase
//
//  Created by HJQ on 2018/11/1.
//  Copyright © 2018 HJQ. All rights reserved.
//

#import "BFNavigationBarFit.h"
#import "UIDevice+Core.h"

@implementation BFNavigationBarFit

- (void)setRelBarHeight:(NSNumber *)relBarHeight {
    if ([UIDevice.currentDevice isFullScreen]) {
        self.constant = 84.0;
    } else {
        self.constant = 64.0;
    }
}

@end
