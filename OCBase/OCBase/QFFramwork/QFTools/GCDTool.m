//
//  GCDTool.m
//  OCBase
//
//  Created by HJQ on 2018/11/13.
//  Copyright © 2018 HJQ. All rights reserved.
//

#import "GCDTool.h"


@implementation GCDTool

+ (void)delay: (NSTimeInterval) seconds block: (void(^)(void)) block {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (block) {
            block();
        }
    });
}

@end
