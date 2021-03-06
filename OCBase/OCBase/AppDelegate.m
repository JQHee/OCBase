//
//  AppDelegate.m
//  OCBase
//
//  Created by HJQ on 2018/10/27.
//  Copyright © 2018 HJQ. All rights reserved.
//

#import "AppDelegate.h"
#import "TestRequest.h"
#import "Global.h"
#import <WebKit/WebKit.h>

@interface AppDelegate ()

@property (nonatomic, assign) UIBackgroundTaskIdentifier bgTask;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    TestRequest *request = [TestRequest new];

    LLogWarning(@"warning", @"嘻嘻心心相惜");
    [[LogManager sharedInstance] compressLog:nil];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

// 开启后台任务（不让应用被挂起）
-(void)applicationDidEnterBackground:(UIApplication *)application{
    [ self comeToBackgroundMode];
}

-(void)comeToBackgroundMode{
    //初始化一个后台任务BackgroundTask，这个后台任务的作用就是告诉系统当前app在后台有任务处理，需要时间
    UIApplication*  app = [UIApplication sharedApplication];
    self.bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        [app endBackgroundTask:self.bgTask];
        self.bgTask = UIBackgroundTaskInvalid;
    }];
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    //开启定时器 不断向系统请求后台任务执行的时间
    self.timer = [NSTimer scheduledTimerWithTimeInterval:25.0 target:self selector:@selector(applyForMoreTime) userInfo:nil repeats:YES];
    [self.timer fire];
}

-(void)applyForMoreTime {
    //如果系统给的剩余时间小于60秒 就终止当前的后台任务，再重新初始化一个后台任务，重新让系统分配时间，这样一直循环下去，保持APP在后台一直处于active状态。
    NSLog(@"时间==>%f", [UIApplication sharedApplication].backgroundTimeRemaining);
    if ([UIApplication sharedApplication].backgroundTimeRemaining < 60) {
        NSLog(@"后台任务");
        [[UIApplication sharedApplication] endBackgroundTask:self.bgTask];
        self.bgTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
            [[UIApplication sharedApplication] endBackgroundTask:self.bgTask];
            self.bgTask = UIBackgroundTaskInvalid;
        }];
    }
}

// 设置wkwebview UserAgent
- (void) setWKWebViewUserAgent {
    
    WKWebView *webView = [[WKWebView alloc]initWithFrame:CGRectZero configuration:[WKWebViewConfiguration new]];
    if (@available(iOS 12.0, *)) {
        NSString *baseAgent = [webView valueForKey:@"applicationNameForUserAgent"];
        NSString *userAgent = [NSString stringWithFormat:@"%@ iOS_Client",baseAgent];
        [webView setValue:userAgent forKey:@"applicationNameForUserAgent"];
    }

    [webView evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id result, NSError *error) {
        
        NSString *oldAgent = result;
        if ([oldAgent rangeOfString:@"iOS_Client"].location != NSNotFound) {
            return ;
        }
        NSString *newAgent = [NSString stringWithFormat:@"%@ %@", oldAgent, @"iOS_Client"];
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:newAgent, @"UserAgent", nil];
        [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
        [[NSUserDefaults standardUserDefaults] synchronize];
        if (@available(iOS 9.0, *)) {
            [webView setCustomUserAgent:newAgent];
        } else {
            [webView setValue:newAgent forKey:@"applicationNameForUserAgent"];
        }
    }];

}


@end
