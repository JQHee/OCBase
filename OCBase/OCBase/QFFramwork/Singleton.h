//
//  Singleton.h
//  OCBase
//
//  Created by HJQ on 2018/11/13.
//  Copyright © 2018 HJQ. All rights reserved.
//

//条件编译
#if __has_feature(objc_arc)
//ARC


//.h头文件中的单例宏
#define IMSingletonH(name) + (instancetype)shared##name;

//.m文件中的单例宏
#define IMSingletonM(name) \
static id _instance;\
+ (instancetype)allocWithZone:(struct _NSZone *)zone{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
return _instance;\
}\
+ (instancetype)shared##name{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [[self alloc] init];\
});\
return _instance;\
}\
- (id)copyWithZone:(NSZone *)zone{\
return _instance;\
}



#else
//MRC


//.h头文件中的单例宏
#define IMSingletonH(name) + (instancetype)shared##name;

//.m文件中的单例宏
#define IMSingletonM(name) \
static id _instance;\
+ (instancetype)allocWithZone:(struct _NSZone *)zone{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
return _instance;\
}\
+ (instancetype)shared##name{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [[self alloc] init];\
});\
return _instance;\
}\
- (id)copyWithZone:(NSZone *)zone{\
return _instance;\
}\
- (oneway void)release{\
}\
- (instancetype)retain{\
return self;\
}\
- (NSUInteger)retainCount{\
return 1;\
}\
- (instancetype)autorelease{\
return self;\
}



#endif

/* 单例宏
//注意下面括号中的内容是你在用单例模式的时候显示的名字，如sharedPlayer；
//IMMusicPlayer *player03 = [IMMusicPlayer sharedPlayer];

//头文件中
IMSingletonH(Player)

//.m文件中：
IMSingletonM(Player)
 */
