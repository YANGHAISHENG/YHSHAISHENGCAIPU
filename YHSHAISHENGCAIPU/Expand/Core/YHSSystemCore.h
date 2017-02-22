//
//  YHSSystemCore.h
//  YHSAPPFRAMEWORK
//
//  Created by YANGHAISHENG on 2016/11/28.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>


#pragma mark 导航栏按钮类型
typedef NS_ENUM(NSInteger, YHSNavBarButtonItemType) {
    YHSNavBarButtonItemTypeNone = 1,   // 无
    YHSNavBarButtonItemTypeDefault,    // 默认
    YHSNavBarButtonItemTypeSearch,     // 搜索
    YHSNavBarButtonItemTypeCustom,     // 自定义
};


#pragma mark 导航栏类型
typedef NS_ENUM(NSInteger, YHSNavBarType) {
    YHSNavBarTypeDefaultNaviBarView = 1,    // 默认系统导航栏
    YHSNavBarTypeCustomNaviBarView,   // 自定义导航栏（隐藏系统导航栏，自定义导航栏）
};


@interface YHSSystemCore : NSObject


#pragma mark 网络请求Cookie
UIKIT_EXTERN NSString * const NETWORK_USER_COOKIE_KEY;
UIKIT_EXTERN NSString * const NETWORK_USER_COOKIE_VALUE;


#pragma mark 上拉刷新提示信息
UIKIT_EXTERN CGFloat const YHSRefreshAutoFooterFontSize;
UIKIT_EXTERN NSString *const YHSRefreshAutoFooterIdleText;
UIKIT_EXTERN NSString *const YHSRefreshAutoFooterRefreshingText;
UIKIT_EXTERN NSString *const YHSRefreshAutoFooterNoMoreDataText;


#pragma mark 网络状态监听的广播频段
UIKIT_EXTERN NSString * const NOTIFICATION_NETWORKING_STATUS_FREQUENCY;
#pragma mark 网络状态监听的广播内容 - 字典Key
UIKIT_EXTERN NSString * const NOTIFICATION_NETWORKING_STATUS_KEY;



@end



