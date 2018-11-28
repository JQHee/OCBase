//
//  LogManager.h
//  LogManagerDemo
//
//  Created by midland on 2018/11/28.
//  Copyright © 2018年 midland. All rights reserved.
//

/*
假如现在有下面这样的日志记录要求

1、日志记录在本地
2、日志最多记录N天，N天之前的都需要清理掉
3、日志可以上传到服务器，由服务器控制是否需要上传
4、上传的日志应该压缩后再上传

实现思路

1、日志记录在本地 (或者用流的方式写入)
　　也就是把字符串保存到本地，我们可以用 将NSString转换成NSData然后写入本地，但是NSData写入本地会对本地的文件进入覆盖，所以我们只有当文件不存在的时候第一次写入的时候用这种方式，如果要将日志内容追加到日志文件里面，我们可以用NSFleHandle来处理

2、日志最多记录N天，N天之前的都需要清理掉
　　这个就比较容易了，我们可以将本地日志文件名定成当天日期，每天一个日志文件，这样我们在程序启动后，可以去检测并清理掉过期的日志文件

3、日志可以上传到服务器，由服务器控制是否需要上传
　　这个功能我们需要后台的配合，后台需要提供两个接口，一个是APP去请求时返回当前应用是否需要上传日志，根据参数来判断，第二个接口就是上传日志的接口

4、上传的日志应该压缩后再上传
　　一般压缩的功能我们可以使用zip压缩，OC中有开源的插件 ZipArchive 地址：http://code.google.com/p/ziparchive/ （需要FQ）
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LogManager : NSObject

/**
 *  获取单例实例
 *
 *  @return 单例实例
 */
+ (instancetype) sharedInstance;

#pragma mark - Method

/**
 *  写入日志
 *
 *  @param module 模块名称
 *  @param logStr 日志信息,动态参数
 */
- (void)logInfo:(NSString*)module logStr:(NSString*)logStr, ...;

/**
 *  清空过期的日志
 */
- (void)clearExpiredLog;

/**
 *  检测日志是否需要上传
 */
- (void)checkLogNeedUpload;

/**
 *  压缩日志
 *
 *  @param dates 日期时间段，空代表全部
 *
 *  @return 执行结果
 */
- (BOOL)compressLog:(NSArray*)dates;

@end

NS_ASSUME_NONNULL_END


/**
 上传文件
 
 @param url 链接
 @param params 参数
 @param fileName 文件名
 @param upName 上传文件名
 @param filePath 路径
 @param progress 进度代码块
 @param success 成功代码块
 @param failure 失败代码块
 */
/*
- (void)base_UpdateFileWithUrl:(NSString*)url parameters:(NSMutableDictionary*)params fileName:(NSString*)fileName upName:(NSString *)upName filePath:(NSString *)filePath progress:(void(^)(id progress))progress success:(void(^)(id success))success failure:(void(^)(id failure))failure{
    
    url = [NSString stringWithFormat:@"%@%@",kURLMain,url];
    if (!upName) {
        upName = fileName;
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //请求头设置
    [ZMBaseEngine setHttpHeaderWithManager:manager];
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
 
         // 第一个参数:文件的URL路径
         // 第二个参数:参数名称 file
         // 第三个参数:在服务器上的名称
         // 第四个参数:文件的类型
        if (filePath&&fileName) {
            NSData*fileData = [NSData dataWithContentsOfFile:filePath];
            //        [formData appendPartWithFileURL:[NSURL fileURLWithPath:@""] name:fileName error:nil];
            [formData appendPartWithFileData:fileData name:upName fileName:fileName mimeType:@"application/zip"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //json解析
        NSDictionary *dic = [self jsonToDic:responseObject];
        success(dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handlingError:error failure:failure];
    }];
}
*/
