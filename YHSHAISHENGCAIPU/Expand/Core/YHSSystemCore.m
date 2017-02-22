//
//  YHSSystemCore.m
//  YHSAPPFRAMEWORK
//
//  Created by YANGHAISHENG on 2016/11/28.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSSystemCore.h"

@implementation YHSSystemCore

#pragma mark 网络请求Cookie
NSString * const NETWORK_USER_COOKIE_KEY  = @"NETWORK_USER_COOKIE_KEY";
NSString * const NETWORK_USER_COOKIE_VALUE  = @"NETWORK_USER_COOKIE_VALUE_NULL";


#pragma mark MJRefresh上拉刷新提示信息
CGFloat const YHSRefreshAutoFooterFontSize = 13.0;
NSString *const YHSRefreshAutoFooterIdleText = @"点击或上拉加载更多";
NSString *const YHSRefreshAutoFooterRefreshingText = @"正在加载更多的数据...";
NSString *const YHSRefreshAutoFooterNoMoreDataText = @"已经全部加载完毕";


#pragma mark 网络状态监听的广播频段
NSString * const NOTIFICATION_NETWORKING_STATUS_FREQUENCY  = @"ReachabilityNetWorkingStatusFrequency";
#pragma mark 网络状态监听的广播内容 - 字典Key
NSString * const NOTIFICATION_NETWORKING_STATUS_KEY  = @"NetworkReachabilityStatus";


@end





