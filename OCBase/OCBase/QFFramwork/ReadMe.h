//
//  ReadMe.h
//  OCBase
//
//  Created by midland on 2018/12/3.
//  Copyright © 2018年 HJQ. All rights reserved.
//

/* iOS App的几种安全防范 */
// 参考链接：https://www.jianshu.com/p/0cfb5859f15f

/*
一.防止抓包篡改数据
二.防止反编译
三.阻止动态调试
四.防止二次打包
*/


// 一.防止抓包篡改数据
// 1) 判断是否设置了代理
/*
#在网络请求前插入这个方法，再根据需求做相应的防范
+ (BOOL)getDelegateStatus
{
    NSDictionary *proxySettings = CFBridgingRelease((__bridge CFTypeRef _Nullable)((__bridge NSDictionary *)CFNetworkCopySystemProxySettings()));
    NSArray *proxies = CFBridgingRelease((__bridge CFTypeRef _Nullable)((__bridge NSArray *)CFNetworkCopyProxiesForURL((__bridge CFURLRef)[NSURL URLWithString:@"http://www.google.com"], (__bridge CFDictionaryRef)proxySettings)));
    NSDictionary *settings = [proxies objectAtIndex:0];
    NSLog(@"host=%@", [settings objectForKey:(NSString *)kCFProxyHostNameKey]);
    NSLog(@"port=%@", [settings objectForKey:(NSString *)kCFProxyPortNumberKey]);
    NSLog(@"type=%@", [settings objectForKey:(NSString *)kCFProxyTypeKey]);
    if ([[settings objectForKey:(NSString *)kCFProxyTypeKey] isEqualToString:@"kCFProxyTypeNone"])
    {
        //没有设置代理
        return NO;
        
    } else {
        //设置代理了
        return YES;
    }
}
 */

// 2) RSAx传输加密


// 二.防止反编译(防止class-dump、hopper反编)

/*
+ (BOOL)isJailbroken {
    // 检查是否存在越狱常用文件
    NSArray *jailFilePaths = @[@"/Applications/Cydia.app",
                               @"/Library/MobileSubstrate/MobileSubstrate.dylib",
                               @"/bin/bash",
                               @"/usr/sbin/sshd",
                               @"/etc/apt"];
    for (NSString *filePath in jailFilePaths) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            return YES;
        }
    }
    
    // 检查是否安装了越狱工具Cydia
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://package/com.example.package"]]){
        return YES;
    }
    
    // 检查是否有权限读取系统应用列表
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/User/Applications/"]){
        NSArray *applist = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"/User/Applications/"
                                                                               error:nil];
        NSLog(@"applist = %@",applist);
        return YES;
    }
    
    //  检测当前程序运行的环境变量
    char *env = getenv("DYLD_INSERT_LIBRARIES");
    if (env != NULL) {
        return YES;
    }
    
    return NO;
}
*/

// 三、代码混淆（通过sh脚本）


// 四、阻止动态调试

// GDB、LLDB是Xcode内置的动态调试工具。使用GDB、LLDB可以动态的调试你的应用程序（通过下断点、打印等方式，查看参数、返回值、函数调用流程等）。
// 为了阻止hackers使用调试器 GDB、LLDB来攻击你的App，你可以在main.m文件中插入以下代码：
/*
#import <dlfcn.h>
#import <sys/types.h>

typedef int (*ptrace_ptr_t)(int _request, pid_t _pid, caddr_t _addr, int _data);
#if !defined(PT_DENY_ATTACH)
#define PT_DENY_ATTACH 31
#endif  // !defined(PT_DENY_ATTACH)

void disable_gdb() {
    void* handle = dlopen(0, RTLD_GLOBAL | RTLD_NOW);
    ptrace_ptr_t ptrace_ptr = dlsym(handle, "ptrace");
    ptrace_ptr(PT_DENY_ATTACH, 0, 0, 0);
    dlclose(handle);
}

int main(int argc, char *argv[]) {
    // Don't interfere with Xcode debugging sessions.
#if !(DEBUG)
    disable_gdb();
#endif
    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil,
                                 NSStringFromClass([MyAppDelegate class]));
    }
}
*/

// 五、防止二次打包
/*
有些hacker可能会通过篡改你的程序包（包括资源文件和二进制代码）加入一些广告或则修改你程序的逻辑，然后重新签名打包，由于第三方hacker获取不到签名证书的私钥，因此会替换掉程序包中签名相关的文件embedded.mobileprovision，我们可以直接检查此文件是否被修改，来判断是否被二次打包，如果程序被篡改，则退出程序。
 */
// 检测embedded.mobileprovision是否被篡改
/*
// 校验值，可通过上一次打包获取
#define PROVISION_HASH @"w2vnN9zRdwo0Z0Q4amDuwM2DKhc="
static NSDictionary * rootDic=nil;

void checkSignatureMsg()
{
    NSString *newPath=[[NSBundle mainBundle]resourcePath];
    
    if (!rootDic) {
        
        rootDic = [[NSDictionary alloc] initWithContentsOfFile:[newPath stringByAppendingString:@"/_CodeSignature/CodeResources"]];
    }
    
    NSDictionary*fileDic = [rootDic objectForKey:@"files2"];
    
    NSDictionary *infoDic = [fileDic objectForKey:@"embedded.mobileprovision"];
    NSData *tempData = [infoDic objectForKey:@"hash"];
    NSString *hashStr = [tempData base64EncodedStringWithOptions:0];
    if (![PROVISION_HASH isEqualToString:hashStr]) {
        abort();//退出应用
    }
}

*/
