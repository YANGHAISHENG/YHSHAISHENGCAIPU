//
//  YHSNetworkingManager.m
//  YHSHAISHENGCAIPU
//
//  Created by YANGHAISHENG on 2017/2/22.
//  Copyright © 2017年 YANGHAISHENG. All rights reserved.
//

#import "YHSNetworkingManager.h"
#import "YHSNetworkingCache.h"
#import <AFNetworking.h>


@implementation YHSNetworkingManager

#pragma mark - 网络状态管理单例
+ (instancetype)sharedNetworkingManager
{
    static YHSNetworkingManager *_singetonInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        if (nil == _singetonInstance) {
            
            // 1、网络请求服务单例
            _singetonInstance = [[super allocWithZone:NULL] init];
            
            // 2、网络请求Session
            _singetonInstance.manager = [AFHTTPSessionManager manager];
            // 设置请求参数的类型:HTTP(AFJSONRequestSerializer, AFHTTPRequestSerializer)
            _singetonInstance.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            // 设置请求的超时时间
            _singetonInstance.manager.requestSerializer.timeoutInterval = 30.0f;
            // 设置服务器返回结果的类型:JSON(AFJSONResponseSerializer, AFHTTPResponseSerializer)
            _singetonInstance.manager.responseSerializer = [AFJSONResponseSerializer serializer];
            _singetonInstance.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                                                   @"text/json",
                                                                                   @"text/javascript",
                                                                                   @"text/html",
                                                                                   @"text/plain",
                                                                                   nil];
            
            // 3.监听网络状态
            AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];// 创建网络监听管理者
            [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) { // 设置网络变化的回调
                switch (status) {
                    case AFNetworkReachabilityStatusUnknown: {
                        YHSDEBUGLog(@"未识别的网络");
                        _singetonInstance.networkReachabilityStatus = YHSNetworkStatusUnknown;
                        
                        // 发送广播
                        NSNotificationCenter * notificationCenter = [NSNotificationCenter defaultCenter]; // 通知中心
                        [notificationCenter postNotificationName:NOTIFICATION_NETWORKING_STATUS_FREQUENCY  // 广播的频段
                                                          object:self  // 从哪里（对象）发送过来
                                                        userInfo:@{NOTIFICATION_NETWORKING_STATUS_KEY:@(YHSNetworkStatusUnknown)}  // 广播内容
                         ];
                        break;
                    }
                    case AFNetworkReachabilityStatusNotReachable: {
                        YHSDEBUGLog(@"不可达的网络(未连接)");
                        _singetonInstance.networkReachabilityStatus = YHSNetworkStatusNotReachable;
                        
                        // 发送广播
                        NSNotificationCenter * notificationCenter = [NSNotificationCenter defaultCenter]; // 通知中心
                        [notificationCenter postNotificationName:NOTIFICATION_NETWORKING_STATUS_FREQUENCY  // 广播的频段
                                                          object:self  // 从哪里（对象）发送过来
                                                        userInfo:@{NOTIFICATION_NETWORKING_STATUS_KEY:@(YHSNetworkStatusNotReachable)}  // 广播内容
                         ];
                        break;
                    }
                    case AFNetworkReachabilityStatusReachableViaWWAN: {
                        YHSDEBUGLog(@"2G,3G,4G...的网络");
                        _singetonInstance.networkReachabilityStatus = YHSNetworkStatusReachableViaWWAN;
                        
                        // 发送广播
                        NSNotificationCenter * notificationCenter = [NSNotificationCenter defaultCenter]; // 通知中心
                        [notificationCenter postNotificationName:NOTIFICATION_NETWORKING_STATUS_FREQUENCY  // 广播的频段
                                                          object:self  // 从哪里（对象）发送过来
                                                        userInfo:@{NOTIFICATION_NETWORKING_STATUS_KEY:@(YHSNetworkStatusReachableViaWWAN)}  // 广播内容
                         ];
                        break;
                    }
                    case AFNetworkReachabilityStatusReachableViaWiFi: {
                        YHSDEBUGLog(@"wifi的网络");
                        _singetonInstance.networkReachabilityStatus = YHSNetworkStatusReachableViaWiFi;
                        
                        // 发送广播
                        NSNotificationCenter * notificationCenter = [NSNotificationCenter defaultCenter]; // 通知中心
                        [notificationCenter postNotificationName:NOTIFICATION_NETWORKING_STATUS_FREQUENCY  // 广播的频段
                                                          object:self  // 从哪里（对象）发送过来
                                                        userInfo:@{NOTIFICATION_NETWORKING_STATUS_KEY:@(YHSNetworkStatusReachableViaWiFi)}  // 广播内容
                         ];
                        break;
                    }
                    default: {
                        break;
                    }
                }
            }];
            [manager startMonitoring]; // 开始监听
            
        }
        
    });
    return _singetonInstance;
}


+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [[self class] sharedNetworkingManager];
}


- (id)copyWithZone:(struct _NSZone *)zone
{
    return [[self class] sharedNetworkingManager];
}


#pragma mark - 封装请求链接API
+ (NSString *)makeRequestURLString:(NSString *)url
{
    // 验证是否为空
    if ([YHSSystemUtil validateEmpty:url]) {
        return nil;
    }
    return [NSString stringWithFormat:@"%@%@", URL_API_BASE, [YHSSystemUtil stringByTrimmingWhitespaceAndNewline:url]];
}


#pragma mark - 封装请求参数
+ (NSMutableDictionary *)makeRequestParamerterWithKeys:(NSArray<NSString *> *)keys Values:(NSArray *)values
{
    NSMutableDictionary *paramerter = [NSMutableDictionary dictionary];
    [keys enumerateObjectsUsingBlock:^(id  _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
        [paramerter setObject:values[idx] forKey:key];
    }];
    return paramerter;
}


#pragma mark - GET请求无缓存
+ (YHSURLSessionTask *)GET:(NSString *)URL
                parameters:(NSDictionary *)parameters
                   success:(HttpRequestSuccess)success
                   failure:(HttpRequestFailed)failure
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    AFHTTPSessionManager *manager = [YHSNetworkingManager sharedNetworkingManager].manager;
    
    //[manager.tasks makeObjectsPerformSelector:@selector(cancel)]; // 取消之前的所有请求
    
    [YHSNetworkingManager setHTTPHeaderFieldOfCookie:manager]; // 设置Cookie
    
    return [manager GET:URL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        success([YHSSystemUtil dictionaryTrimmingNSNull:responseObject]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        failure ? failure(error) : nil;
        
        YHSDEBUGLog(@"error = %@", error);
    }];
}


#pragma mark - GET请求自动缓存
+ (YHSURLSessionTask *)GET:(NSString *)URL
                parameters:(NSDictionary *)parameters
             responseCache:(HttpRequestCache)responseCache
                   success:(HttpRequestSuccess)success
                   failure:(HttpRequestFailed)failure
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    //读取缓存
    responseCache([YHSNetworkingCache getResponseCacheForKey:URL]);
    
    AFHTTPSessionManager *manager = [YHSNetworkingManager sharedNetworkingManager].manager;
    
    //[manager.tasks makeObjectsPerformSelector:@selector(cancel)]; // 取消之前的所有请求
    
    [YHSNetworkingManager setHTTPHeaderFieldOfCookie:manager]; // 设置Cookie
    
    return [manager GET:URL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        // 处理空值
        responseObject = [YHSSystemUtil dictionaryTrimmingNSNull:responseObject];
        
        success(responseObject);
        
        //对数据进行异步缓存
        [YHSNetworkingCache saveResponseCache:responseObject forKey:URL];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        failure ? failure(error) : nil;
        
        YHSDEBUGLog(@"error = %@", error);
        
    }];
}


#pragma mark - GET请求无缓存（NSURLSessionDataTask）
+ (YHSURLSessionTask *)GET:(NSString *)URL
                parameters:(NSDictionary *)parameters
        successSessionTask:(HttpRequestSuccessSessionDataTask)success
        failureSessionTask:(HttpRequestFailedSessionDataTask)failure
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    AFHTTPSessionManager *manager = [YHSNetworkingManager sharedNetworkingManager].manager;
    
    //[manager.tasks makeObjectsPerformSelector:@selector(cancel)]; // 取消之前的所有请求
    
    [YHSNetworkingManager setHTTPHeaderFieldOfCookie:manager]; // 设置Cookie
    
    return [manager GET:URL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        success(task, [YHSSystemUtil dictionaryTrimmingNSNull:responseObject]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        failure ? failure(task, error) : nil;
        
        YHSDEBUGLog(@"error = %@", error);
    }];
}


#pragma mark - POST请求无缓存
+ (YHSURLSessionTask *)POST:(NSString *)URL
                 parameters:(NSDictionary *)parameters
                    success:(HttpRequestSuccess)success
                    failure:(HttpRequestFailed)failure
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    AFHTTPSessionManager *manager = [YHSNetworkingManager sharedNetworkingManager].manager;
    
    //[manager.tasks makeObjectsPerformSelector:@selector(cancel)]; // 取消之前的所有请求
    
    [YHSNetworkingManager setHTTPHeaderFieldOfCookie:manager]; // 设置Cookie
    
    return [manager POST:URL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        success([YHSSystemUtil dictionaryTrimmingNSNull:responseObject]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        failure ? failure(error) : nil;
        
        YHSDEBUGLog(@"error = %@", error);
    }];
    
}


#pragma mark - POST请求自动缓存
+ (YHSURLSessionTask *)POST:(NSString *)URL
                 parameters:(NSDictionary *)parameters
              responseCache:(HttpRequestCache)responseCache
                    success:(HttpRequestSuccess)success
                    failure:(HttpRequestFailed)failure
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    //读取缓存
    responseCache([YHSNetworkingCache getResponseCacheForKey:URL]);
    
    AFHTTPSessionManager *manager = [YHSNetworkingManager sharedNetworkingManager].manager;
    
    //[manager.tasks makeObjectsPerformSelector:@selector(cancel)]; // 取消之前的所有请求
    
    [YHSNetworkingManager setHTTPHeaderFieldOfCookie:manager]; // 设置Cookie
    
    return [manager POST:URL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        // 处理空值
        responseObject = [YHSSystemUtil dictionaryTrimmingNSNull:responseObject];
        
        success(responseObject);
        
        //对数据进行异步缓存
        [YHSNetworkingCache saveResponseCache:responseObject forKey:URL];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        failure ? failure(error) : nil;
        
        YHSDEBUGLog(@"error = %@", error);
    }];
    
}


#pragma mark - POST请求无缓存（NSURLSessionDataTask）
+ (YHSURLSessionTask *)POST:(NSString *)URL
                 parameters:(NSDictionary *)parameters
         successSessionTask:(HttpRequestSuccessSessionDataTask)success
         failureSessionTask:(HttpRequestFailedSessionDataTask)failure
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    AFHTTPSessionManager *manager = [YHSNetworkingManager sharedNetworkingManager].manager;
    
    //[manager.tasks makeObjectsPerformSelector:@selector(cancel)]; // 取消之前的所有请求
    
    [YHSNetworkingManager setHTTPHeaderFieldOfCookie:manager]; // 设置Cookie
    
    return [manager POST:URL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        success(task, [YHSSystemUtil dictionaryTrimmingNSNull:responseObject]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        failure ? failure(task, error) : nil;
        
        YHSDEBUGLog(@"error = %@", error);
    }];
    
}


#pragma mark - 上传图片文件
+ (YHSURLSessionTask *)uploadWithURL:(NSString *)URL
                          parameters:(NSDictionary *)parameters
                              images:(NSArray<UIImage *> *)images
                                name:(NSString *)name fileName:(NSString *)fileName
                            mimeType:(NSString *)mimeType
                            progress:(HttpProgress)progress
                             success:(HttpRequestSuccess)success
                             failure:(HttpRequestFailed)failure
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    AFHTTPSessionManager *manager = [YHSNetworkingManager sharedNetworkingManager].manager;
    
    [YHSNetworkingManager setHTTPHeaderFieldOfCookie:manager]; // 设置Cookie
    
    return [manager POST:URL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        //压缩-添加-上传图片
        [images enumerateObjectsUsingBlock:^(UIImage * _Nonnull image, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            
            [formData appendPartWithFileData:imageData name:name fileName:[NSString stringWithFormat:@"%@%ld.%@",fileName,idx,mimeType?mimeType:@"jpeg"] mimeType:[NSString stringWithFormat:@"image/%@",mimeType?mimeType:@"jpeg"]];
        }];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //上传进度
        progress ? progress(uploadProgress) : nil;
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        failure ? failure(error) : nil;
        
        YHSDEBUGLog(@"error = %@",error);
    }];
}


#pragma mark - 下载文件
+ (YHSURLSessionTask *)downloadWithURL:(NSString *)URL
                               fileDir:(NSString *)fileDir
                              progress:(HttpProgress)progress
                               success:(void(^)(NSString *))success
                               failure:(HttpRequestFailed)failure
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    AFHTTPSessionManager *manager = [YHSNetworkingManager sharedNetworkingManager].manager;
    [YHSNetworkingManager setHTTPHeaderFieldOfCookie:manager]; // 设置Cookie
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //下载进度
        progress ? progress(downloadProgress) : nil;
        
        YHSDEBUGLog(@"下载进度:%.2f%%",100.0*downloadProgress.completedUnitCount/downloadProgress.totalUnitCount);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        //拼接缓存目录
        NSString *downloadDir = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileDir ? fileDir : @"Download"];
        //打开文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //创建Download目录
        [fileManager createDirectoryAtPath:downloadDir withIntermediateDirectories:YES attributes:nil error:nil];
        
        //拼接文件路径
        NSString *filePath = [downloadDir stringByAppendingPathComponent:response.suggestedFilename];
        
        YHSDEBUGLog(@"downloadDir = %@",downloadDir);
        
        //返回文件位置的URL路径
        return [NSURL fileURLWithPath:filePath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        success ? success(filePath.absoluteString /** NSURL->NSString*/) : nil;
        
        failure && error ? failure(error) : nil;
        
    }];
    
    //开始下载
    [downloadTask resume];
    
    return downloadTask;
    
}


#pragma mark - 设置Cookie
+ (void)setHTTPHeaderFieldOfCookie:(AFHTTPSessionManager *)manager
{
    NSString *cookieValue = [YHSSystemUtil getUserCookie];
    // 值为空则不设置
    if ([YHSSystemUtil validateObjectIsNull:cookieValue]) {
        return;
    }
    // 用户退出登录，清空Cookie，并设置为特定值
    if ([NETWORK_USER_COOKIE_VALUE isEqualToString:cookieValue]) {
        [manager.requestSerializer setValue:@"" forHTTPHeaderField:@"Cookie"];
        return;
    }
    // 设置Cookie值
    [manager.requestSerializer setValue:cookieValue forHTTPHeaderField:@"Cookie"];
}



@end
