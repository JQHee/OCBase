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

- (NSString *)testMethod {

    //声明一个字典
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    //得到当前class的所有属性
    uint count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    //循环并用KVC得到每个属性的值
    for (int i = 0; i<count; i++) {
        objc_property_t property = properties[i];
        NSString *name = @(property_getName(property));
        id value = [self valueForKey:name]?:@"";//默认值为nil字符串
        NSString *content = [NSString stringWithFormat:@"%@", value];
        [dictionary setObject:content forKey:name];//装载到字典里
    }
    //释放
    free(properties);

    return [NSString stringWithFormat:@"%@", dictionary];

    /*
    unsigned int count;
    const char *clasName    = object_getClassName(self);
    NSMutableString *string = [NSMutableString stringWithFormat:@"<%s: %p>:[ \n",clasName, self];
    Class clas              = NSClassFromString([NSString stringWithCString:clasName encoding:NSUTF8StringEncoding]);
    Ivar *ivars             = class_copyIvarList(clas, &count);

    for (int i = 0; i < count; i++) {

        @autoreleasepool {

            Ivar       ivar  = ivars[i];
            const char *name = ivar_getName(ivar);

            //得到类型
            NSString *type   = [NSString stringWithCString:ivar_getTypeEncoding(ivar) encoding:NSUTF8StringEncoding];
            NSString *key    = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
            id       value   = [self valueForKey:key];

            //确保BOOL值输出的是YES 或 NO
            if ([type isEqualToString:@"B"]) {
                value = (value == 0 ? @"NO" : @"YES");
            }

            [string appendFormat:@"\t%@: %@\n",[self deleteUnderLine:key], value];
        }
    }

    [string appendFormat:@"]"];

    return string;
     */
}


/// 去掉下划线
- (NSString *)deleteUnderLine:(NSString *)string{

    if ([string hasPrefix:@"_"]) {
        return [string substringFromIndex:1];
    }
    return string;
}


@end
