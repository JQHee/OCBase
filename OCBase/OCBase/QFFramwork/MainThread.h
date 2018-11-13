//
//  MainThread.h
//  OCBase
//
//  Created by HJQ on 2018/11/13.
//  Copyright © 2018 HJQ. All rights reserved.
//

/*! 主线程同步队列 */
#define dispatch_main_sync_safe(block)          \
if ([NSThread isMainThread]) {                  \
    block();                                        \
} else {                                        \
    dispatch_sync(dispatch_get_main_queue(), block);\
}
/*! 主线程异步队列 */
#define dispatch_main_async_safe(block)        \
if ([NSThread isMainThread]) {                 \
    block();                                       \
} else {                                       \
    dispatch_async(dispatch_get_main_queue(), block);\
}
