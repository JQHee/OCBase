//
//  NSObject+HZCoding.h
//  OCBase
//
//  Created by midland on 2018/12/10.
//  Copyright © 2018年 HJQ. All rights reserved.
//

#import <Foundation/Foundation.h>


#define HZCodingImplementation \
-(void)encodeWithCoder:(NSCoder *)aCoder\
{\
[self HZ_encode:aCoder];\
}\
-(instancetype)initWithCoder:(NSCoder *)aDecoder\
{\
if (self = [super init]) {\
[self HZ_decode:aDecoder];\
}return self; \
}

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (HZCoding)

-(void)HZ_encode:(NSCoder *)aCoder;
-(void)HZ_decode:(NSCoder *)aDecoder;

@end

NS_ASSUME_NONNULL_END
