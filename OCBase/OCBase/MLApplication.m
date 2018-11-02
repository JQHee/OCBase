//
//  NTApplication.m
//  NoOperationDemo
//
//  Created by midland on 2018/10/31.
//  Copyright © 2018年 midland. All rights reserved.
//

#import "MLApplication.h"
#import "AppDelegate.h"

@implementation MLApplication

// 只有应用有操作，则和触发
- (void)sendEvent:(UIEvent *)event {
    [super sendEvent:event];
    if (!_myTimer) {
        [self resetTimer];
    }
    
    NSSet *allTouches = [event allTouches];
    if ([allTouches count] > 0) {
        UITouchPhase phase = ((UITouch *)[allTouches anyObject]).phase;
        if (phase == UITouchPhaseBegan) {
            [self resetTimer];
        }
    }
}

// 重置时钟
- (void)resetTimer {
    
    if (_myTimer) {
        [_myTimer invalidate];
        _myTimer = nil;
    }
    int timeout = kApplicationTimeoutInMinutes;//超时时间，
    _myTimer = [NSTimer scheduledTimerWithTimeInterval:timeout target:self selector:@selector(freeTimerNotificate:) userInfo:nil repeats:NO];
    //[[NSRunLoop currentRunLoop] addTimer:_myTimer forMode:NSRunLoopCommonModes];
    
}

// 当达到超时时间，发送 kApplicationTimeoutInMinutes通知
- (void)freeTimerNotificate:(NSNotification *)notification {
    //NSLog(@"%@",[UIApplication sharedApplication].keyWindow);
    NSLog(@"时间到");
    //AppDelegate *deleate = (AppDelegate *)UIApplication.sharedApplication.delegate;
    //deleate.isDissmiss = true;
    //在想要获得通知的地方注册这个通知就行了
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kUserEnterFreeTimeoutNotification" object:nil];
}
@end
//
// 在BaseViewController添加此监听 执行相对硬的操作
//[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(goDengLu:) name:@"kUserEnterFreeTimeoutNotification" object:nil];
