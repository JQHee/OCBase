//
//  TestRequest.m
//  OCBase
//
//  Created by HJQ on 2018/12/5.
//  Copyright © 2018 HJQ. All rights reserved.
//

#import "TestRequest.h"
#import <objc/runtime.h>

@implementation TestRequest

- (instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

- (NSDictionary *)testMethod: (Class)class {

    //声明一个字典
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    //得到当前class的所有属性
    uint count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    //循环并用KVC得到每个属性的值
    for (int i = 0; i<count; i++) {
        objc_property_t property = properties[i];
        NSString *name = @(property_getName(property));
        // const char *cname = property_getAttributes(property);
        // NSLog(@"%s", cname);
        NSString *attrs = @(property_getAttributes(property));
        NSUInteger dotLoc = [attrs rangeOfString:@","].location;
        NSString *code = nil;
        NSUInteger loc = 3;
        if (dotLoc == NSNotFound) { // 没有,
            code = [attrs substringFromIndex:loc];
        } else {
            if ([attrs length] > dotLoc - 1 && dotLoc > loc) { // NSInteger
                code = [attrs substringWithRange:NSMakeRange(loc, dotLoc - loc - 1)];
            }
        }
        // NSLog(@"%@", code);
        id value = [self valueForKey:name]?:@"";//默认值为nil字符串
        if ([code isEqualToString:@"NSDictionary"] || [code isEqualToString:@"NSMutableDictionary"] || [code isEqualToString:@"NSArray"] || [code isEqualToString:@"NSMutableArray"] || [code isEqualToString:@"Class"]) {
        } else {
            NSString *content = [NSString stringWithFormat:@"%@", value];
            [dictionary setObject:content forKey:name];//装载到字典里
        }
    }
    //释放
    free(properties);
    return dictionary;
}



/// 去掉下划线
- (NSString *)deleteUnderLine:(NSString *)string{

    if ([string hasPrefix:@"_"]) {
        return [string substringFromIndex:1];
    }
    return string;
}


@end
