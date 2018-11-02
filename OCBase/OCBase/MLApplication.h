//
//  NTApplication.h
//  NoOperationDemo
//
//  Created by midland on 2018/10/31.
//  Copyright © 2018年 midland. All rights reserved.
//

#import <UIKit/UIKit.h>

// 定义未操作通知的时间，也可以从服务器上获取。
#define kApplicationTimeoutInMinutes 10 * 60

@interface MLApplication : UIApplication {
    NSTimer *_myTimer;
}

- (void)resetTimer;

@end
