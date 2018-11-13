//
//  WordFilter.h
//  WordFilterDemo
//
//  Created by midland on 2018/11/13.
//  Copyright © 2018年 midland. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WordFilter : NSObject

+ (instancetype)sharedInstance;

- (void)initFilter:(NSString *)filepath;

- (void)insertWords:(NSString *)words;

- (NSString *)filter:(NSString *)str;

@end

/* 使用方法
WordFilter *wordFilter = [WordFilter sharedInstance];
NSString *path = [[NSBundle mainBundle]pathForResource:@"words" ofType:@"txt"];
[wordFilter initFilter:path];
[wordFilter insertWords:@"*"];
NSString *result = [wordFilter filter:@"你好123窃听器"];
NSLog(@"%@", result);
 */
