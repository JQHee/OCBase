//
//  BLDelayStartupTool.m
//  OCBase
//
//  Created by HJQ on 2018/12/8.
//  Copyright © 2018 HJQ. All rights reserved.
//

#import "BLDelayStartupTool.h"

static BOOL _isCalledStartupEventsOnAppDidFinishLaunchingWithOptions = NO;
static BOOL _isCalledStartupEventsOnADTimeWithAppDelegate = NO;
static BOOL _isCalledStartupEventsOnDidAppearAppContent = NO;
const NSTimeInterval kBLDelayStartupEventsToolCheckCallTimeInterval = 30;
@implementation BLDelayStartupTool

+ (void)load {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kBLDelayStartupEventsToolCheckCallTimeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self checkStartupEventsDidLaunched];
    });
}

+ (void)checkStartupEventsDidLaunched {
    NSString *alertString = @"";
    if (!_isCalledStartupEventsOnAppDidFinishLaunchingWithOptions) {
        alertString = [alertString stringByAppendingString:@"AppDidFinishLaunching, "];
        [self startupEventsOnAppDidFinishLaunchingWithOptions];
    }
    if (!_isCalledStartupEventsOnADTimeWithAppDelegate) {
        alertString = [alertString stringByAppendingString:@"ADTime, "];
        [self startupEventsOnADTime];
    }
    if (!_isCalledStartupEventsOnDidAppearAppContent) {
        alertString = [alertString stringByAppendingString:@"DidAppearAppContent"];
        [self startupEventsOnDidAppearAppContent];
    }

    if (alertString.length > 0) {

#if DEBUG
        alertString = [alertString stringByAppendingString:@" 等延迟启动项没有启动, 这会造成应用奔溃"];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"注意" message:alertString delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [alertView show];
#endif
    }
}

+ (void)startupEventsOnAppDidFinishLaunchingWithOptions {
    _isCalledStartupEventsOnAppDidFinishLaunchingWithOptions = YES;
}

+ (void)startupEventsOnADTime {
    _isCalledStartupEventsOnADTimeWithAppDelegate = YES;
}

+ (void)startupEventsOnDidAppearAppContent {
    _isCalledStartupEventsOnDidAppearAppContent = YES;
}

@end
