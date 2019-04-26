//
//  BFProgressHUD.m
//  OCBase
//
//  Created by HJQ on 2019/4/14.
//  Copyright © 2019 HJQ. All rights reserved.
//

#import "BFProgressHUD.h"
#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>
//在获取keyWindow时，用了delegate，主要是因为与系统的alertView发生了冲突，其实在平常获取keyWindow时，这种写法才是正规的
#define Key_Window  [UIApplication sharedApplication].delegate.window
#define kScreentSize UIScreen.mainScreen.bounds.size

@implementation BFProgressHUD

///菊花
static long loadCount = 0;//声明静态变量
static MBProgressHUD *shareHud;

///alertText
static long loadTextCount = 0;
static MBProgressHUD *textHud;

///创建信号量和菊花
+ (dispatch_semaphore_t)shareLockSignal{
    static dispatch_semaphore_t lockSignal;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        lockSignal = dispatch_semaphore_create(1);
        shareHud = [MBProgressHUD showHUDAddedTo:Key_Window animated:YES];
    });
    return lockSignal;
}

///创建信号量和弹窗
+ (dispatch_semaphore_t)shareTextLockSignal{
    static dispatch_semaphore_t lockSignal;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lockSignal = dispatch_semaphore_create(1);
        textHud = [MBProgressHUD showHUDAddedTo:Key_Window animated:YES];
        textHud.userInteractionEnabled = NO;
        textHud.bezelView.backgroundColor = [UIColor darkGrayColor];
        textHud.contentColor = [UIColor whiteColor];
        textHud.mode = MBProgressHUDModeText;
        textHud.label.numberOfLines = 0;
        textHud.center = CGPointMake(kScreentSize.width/2, kScreentSize.height/2);
    });
    return lockSignal;
}

///显示菊花
+ (void)showIndicator{
    dispatch_semaphore_t lockSignal = [self shareLockSignal];
    dispatch_semaphore_wait(lockSignal, DISPATCH_TIME_FOREVER);
    loadCount++;
    shareHud.frame = Key_Window.bounds;
    [Key_Window addSubview:shareHud];
    dispatch_semaphore_signal(lockSignal);
}

///隐藏菊花
+ (void)hideIndicator{
    dispatch_semaphore_t lockSignal = [self shareLockSignal];
    dispatch_semaphore_wait(lockSignal, DISPATCH_TIME_FOREVER);
    loadCount--;
    dispatch_async(dispatch_get_main_queue(), ^{
        //网络请求数量为0时，移除菊花
        if (loadCount == 0) {
            [shareHud removeFromSuperview];
        }
    });
    dispatch_semaphore_signal(lockSignal);
}

///显示弹窗内容
+ (void)showInfo:(NSString *)info{
    dispatch_semaphore_t lockSignal = [self shareTextLockSignal];
    dispatch_semaphore_wait(lockSignal, DISPATCH_TIME_FOREVER);
    loadTextCount++;
    if (loadTextCount == 1) {//加入判断，不管有多少个文字提示，只显示第一条
        textHud.label.text = NSLocalizedString(info, @"HUD message title");
        textHud.center = CGPointMake(kScreentSize.width/2, kScreentSize.height/2);
        [Key_Window addSubview:textHud];
        //移除
        dispatch_async(dispatch_get_main_queue(), ^{
            loadTextCount = 0;
            NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(removeTextHud:) userInfo:nil repeats:NO];
            [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        });
    }
    dispatch_semaphore_signal(lockSignal);
}

//移除textHud timer
+ (void)removeTextHud:(NSTimer *)timer{
    [textHud removeFromSuperview];
    [timer invalidate];
}

@end
