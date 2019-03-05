//
//  NSString+UUID.m
//  InPurchasing
//
//  Created by midland on 2019/3/5.
//  Copyright © 2019年 midland. All rights reserved.
//

#import "NSString+UUID.h"

@implementation NSString (UUID)

+ (NSString *) UUID {
    // create a new UUID which you own
    CFUUIDRef uuidref = CFUUIDCreate(kCFAllocatorDefault);
    
    // create a new CFStringRef (toll-free bridged to NSString)
    // that you own
    CFStringRef uuid = CFUUIDCreateString(kCFAllocatorDefault, uuidref);
    
    NSString *result = (__bridge NSString *)uuid;
    //release the uuidref
    CFRelease(uuidref);
    // release the UUID
    CFRelease(uuid);
    
    return result;
}

@end
