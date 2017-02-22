//
//  YHSNetworkingManager.h
//  YHSHAISHENGCAIPU
//
//  Created by YANGHAISHENG on 2017/2/22.
//  Copyright © 2017年 YANGHAISHENG. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import <UIKit/UIKit.h>


// 网络状态
typedef NS_ENUM(NSUInteger, YHSNetworkStatus) {
    /** 未知网络 */
    YHSNetworkStatusUnknown,
    /** 不可达的网络(未连接) */
    YHSNetworkStatusNotReachable,
    /** 手机网络2G,3G,4G */
    YHSNetworkStatusReachableViaWWAN,
    /** WIFI网络 */
    YHSNetworkStatusReachableViaWiFi
};


/** 请求成功的Block */
typedef void(^HttpRequestSuccess)(id responseObject);
typedef void(^HttpRequestSuccessSessionDataTask)(NSURLSessionDataTask *task, id responseObject);


/** 请求失败的Block */
typedef void(^HttpRequestFailed)(NSError *error);
typedef void(^HttpRequestFailedSessionDataTask)(NSURLSessionDataTask *task, NSError *error);


/** 缓存的Block */
typedef void(^HttpRequestCache)(id responseCache);


/** 上传或者下载的进度, Progress.completedUnitCount:当前大小 - Progress.totalUnitCount:总大小*/
typedef void (^HttpProgress)(NSProgress *progress);


/** 请求任务 */
typedef NSURLSessionTask YHSURLSessionTask;


#pragma mark - 网络数据请求类

@interface YHSNetworkingManager : NSObject

@property (nonatomic, strong) AFHTTPSessionManager *manager; // 网络请求Session

@property (nonatomic, assign) YHSNetworkStatus networkReachabilityStatus; // 当前网络状态


/**
 *  网络状态管理单例
 */
+ (instancetype)sharedNetworkingManager;


/**
 *  封装请求链接API
 *
 *  @return 返回请求链接API
 */
+ (NSString *)makeRequestURLString:(NSString *)url;


/**
 *  封装请求参数
 *
 *  @return 返回请求参数
 */
+ (NSMutableDictionary *)makeRequestParamerterWithKeys:(NSArray<NSString *> *)keys Values:(NSArray *)values;


/**
 *  GET请求,无缓存
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancle方法
 */
+ (YHSURLSessionTask *)GET:(NSString *)URL
                parameters:(NSDictionary *)parameters
                   success:(HttpRequestSuccess)success
                   failure:(HttpRequestFailed)failure;


/**
 *  GET请求,自动缓存
 *
 *  @param URL           请求地址
 *  @param parameters    请求参数
 *  @param responseCache 缓存数据的回调
 *  @param success       请求成功的回调
 *  @param failure       请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancle方法
 */
+ (YHSURLSessionTask *)GET:(NSString *)URL
                parameters:(NSDictionary *)parameters
             responseCache:(HttpRequestCache)responseCache
                   success:(HttpRequestSuccess)success
                   failure:(HttpRequestFailed)failure;


/**
 *  GET请求,无缓存（NSURLSessionDataTask）
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param successSessionTask    请求成功的回调
 *  @param failureSessionTask    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancle方法
 */
+ (YHSURLSessionTask *)GET:(NSString *)URL
                parameters:(NSDictionary *)parameters
        successSessionTask:(HttpRequestSuccessSessionDataTask)successSessionTask
        failureSessionTask:(HttpRequestFailedSessionDataTask)failureSessionTask;


/**
 *  POST请求,无缓存
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancle方法
 */
+ (YHSURLSessionTask *)POST:(NSString *)URL
                 parameters:(NSDictionary *)parameters
                    success:(HttpRequestSuccess)success
                    failure:(HttpRequestFailed)failure;


/**
 *  POST请求,自动缓存
 *
 *  @param URL           请求地址
 *  @param parameters    请求参数
 *  @param responseCache 缓存数据的回调
 *  @param success       请求成功的回调
 *  @param failure       请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancle方法
 */
+ (YHSURLSessionTask *)POST:(NSString *)URL
                 parameters:(NSDictionary *)parameters
              responseCache:(HttpRequestCache)responseCache
                    success:(HttpRequestSuccess)success
                    failure:(HttpRequestFailed)failure;


/**
 *  POST请求,无缓存（NSURLSessionDataTask）
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param successSessionTask    请求成功的回调
 *  @param failureSessionTask    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancle方法
 */
+ (YHSURLSessionTask *)POST:(NSString *)URL
                 parameters:(NSDictionary *)parameters
         successSessionTask:(HttpRequestSuccessSessionDataTask)successSessionTask
         failureSessionTask:(HttpRequestFailedSessionDataTask)failureSessionTask;


/**
 *  上传图片文件
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param images     图片数组
 *  @param name       文件对应服务器上的字段
 *  @param fileName   文件名
 *  @param mimeType   图片文件的类型,例:png、jpeg(默认类型)....
 *  @param progress   上传进度信息
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancle方法
 */
+ (YHSURLSessionTask *)uploadWithURL:(NSString *)URL
                          parameters:(NSDictionary *)parameters
                              images:(NSArray<UIImage *> *)images
                                name:(NSString *)name
                            fileName:(NSString *)fileName
                            mimeType:(NSString *)mimeType
                            progress:(HttpProgress)progress
                             success:(HttpRequestSuccess)success
                             failure:(HttpRequestFailed)failure;


/**
 *  下载文件
 *
 *  @param URL      请求地址
 *  @param fileDir  文件存储目录(默认存储目录为Download)
 *  @param progress 文件下载的进度信息
 *  @param success  下载成功的回调(回调参数filePath:文件的路径)
 *  @param failure  下载失败的回调
 *
 *  @return 返回NSURLSessionDownloadTask实例，可用于暂停继续，暂停调用suspend方法，开始下载调用resume方法
 */
+ (YHSURLSessionTask *)downloadWithURL:(NSString *)URL
                               fileDir:(NSString *)fileDir
                              progress:(HttpProgress)progress
                               success:(void(^)(NSString *filePath))success
                               failure:(HttpRequestFailed)failure;



@end
