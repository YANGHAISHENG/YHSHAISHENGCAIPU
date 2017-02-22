//
//  YHSNetworkingCache.m
//  YHSHAISHENGCAIPU
//
//  Created by YANGHAISHENG on 2017/2/22.
//  Copyright © 2017年 YANGHAISHENG. All rights reserved.
//

#import "YHSNetworkingCache.h"
#import <YYCache.h>


@implementation YHSNetworkingCache

static NSString *const NetworkResponseCache = @"NetworkResponseCache";

static YYCache *_dataCache;


+ (void)initialize
{
    _dataCache = [YYCache cacheWithName:NetworkResponseCache];
}

/**
 *  缓存网络数据
 *
 *  @param responseCache 服务器返回的数据
 *  @param key           缓存数据对应的key值，推荐填入请求的URL
 */
+ (void)saveResponseCache:(id)responseCache forKey:(NSString *)key
{
    // 异步缓存,不会阻塞主线程
    [_dataCache setObject:responseCache forKey:key withBlock:nil];
}


/**
 *  取出缓存的数据
 *
 *  @param key 根据存入时候填入的key值来取出对应的数据
 *
 *  @return 缓存的数据
 */
+ (id)getResponseCacheForKey:(NSString *)key
{
    return [_dataCache objectForKey:key];
}


/**
 *  清空缓存数据
 *
 *  @param key 根据存入时候填入的key值来删除对应的数据
 */
+ (void)removeObjectForKey:(NSString *)key
{
    [_dataCache removeObjectForKey:key];
}


/**
 *  清空所有缓存数据
 */
+ (void)removeAllObjects
{
    [_dataCache removeAllObjects];
}



@end
