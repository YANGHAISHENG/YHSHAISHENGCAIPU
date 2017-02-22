//
//  YHSSysConstants.h
//  YHSAPPFRAMEWORK
//
//  Created by YANGHAISHENG on 2016/11/29.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHSSysConstants : NSObject

#pragma mark 控件间隔常量
UIKIT_EXTERN CGFloat const MARGIN;

#pragma mark 开机动画显示时长
UIKIT_EXTERN CGFloat const GUIDE_ANIMATE_DURATION;

#pragma mark 数据加载时SLEEP延迟动画显示时间
UIKIT_EXTERN CGFloat const LOADING_SLEEP_TIME;

#pragma mark 标签栏高度(系统默认高度为49)
UIKIT_EXTERN CGFloat const TAB_BAR_HEIGHT_DEFAULT;

#pragma mark 状态栏高度
UIKIT_EXTERN CGFloat const STATUS_BAR_HEIGHT;

#pragma mark 状态栏+导航条容器TAG值
UIKIT_EXTERN CGFloat const STATUS_NAVIGATION_BAR_TAG ;

#pragma mark 状态栏+导航条高度(系统默认高度为64)
UIKIT_EXTERN CGFloat const STATUS_NAVIGATION_BAR_HEIGHT;

#pragma mark 导航条高度
UIKIT_EXTERN CGFloat const NAVIGATION_BAR_HEIGHT;

#pragma mark 导航条底部发丝线(系统默认高度为1.0)
UIKIT_EXTERN CGFloat const NAVIGATION_BAR_HAIR_LINE_HEIGHT;

#pragma mark 导航条按钮与屏幕边距
UIKIT_EXTERN CGFloat const NAVIGATION_BAR_SCREEN_MARGIN;

#pragma mark 导航条左右按钮最大宽度
UIKIT_EXTERN CGFloat const NAVIGATION_BAR_BUTTON_MAX_WIDTH;

#pragma mark 导航条标题字数限制
UIKIT_EXTERN CGFloat const NAVIGATION_BAR_TITLE_MAX_NUM;

#pragma mark 全屏右滑返回左边手势允许的最大距离
UIKIT_EXTERN CGFloat const FULLSCREEN_POP_GESTURE_MAX_DISTANCE_TO_LEFT_EDGE;



@end




