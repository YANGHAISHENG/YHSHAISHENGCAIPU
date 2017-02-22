
//
//  YHSSystemMacro.h
//  YHSAPPFRAMEWORK
//
//  Created by YANGHAISHENG on 2016/11/28.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#ifndef YHSSystemMacro_h
#define YHSSystemMacro_h


#pragma mark -
#pragma mark 弱引用 => 用于避免循环引用
#define WEAKTYPE(type)  __weak __typeof(&*type)weak##type = type
#define WEAKSELF(weakSelf)  __weak __typeof(&*self)weakSelf = self


#pragma mark 应用程序尺寸 => 
// APPFRAME_WIDTH = SCREEN_WIDTH
#define APPFRAME_WIDTH ([UIScreen mainScreen].applicationFrame.size.width)
// APPFRAME_HEIGHT = SCREEN_HEIGHT-STATUSBAR_HEIGHT
// 注意：横屏（UIDeviceOrientationLandscape）时，iOS8默认隐藏状态栏，此时APPFRAME_HEIGHT=SCREEN_HEIGHT
#define APPFRAME_HEIGHT ([UIScreen mainScreen].applicationFrame.size.height)


#pragma mark 屏幕尺寸大小 => 考虑转屏的影响，按照实际屏幕方向（UIDeviceOrientation）的宽高
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
#define STATUSBAR_HEIGHT ([UIApplication sharedApplication].statusBarFrame.size.height)


#pragma mark 屏幕尺寸大小 => 不考虑转屏的影响，只取竖屏（UIDeviceOrientationPortrait）的宽高
#define SCREEN_WIDTH_PORTRAIT MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)
#define SCREEN_HEIGHT_PORTRAIT MAX([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width)
#define SCREEN_SIZE_PORTRAIT CGSizeMake(SCREEN_WIDTH_PORTRAIT, SCREEN_HEIGHT_PORTRAIT)
#define STATUSBAR_HEIGHT_PORTRAIT MIN([UIApplication sharedApplication].statusBarFrame.size.width, [UIApplication sharedApplication].statusBarFrame.size.height)


#pragma mark 设置视图边框和圆角
#define MakeViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setMasksToBounds:YES];\
[View.layer setCornerRadius:(Radius)];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]


#pragma mark 颜色（RGBA）
#define RGBA(r, g, b, a) [UIColor colorWithRed:(r/255.f) green:(g/255.f) blue:(b/255.f) alpha:a]
#define RandomColor  RGBA(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), 1.0)


#pragma mark 导航栏底部横线颜色
#define NAVIGATION_BAR_HAIR_LINE_COLOR [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00]


#pragma mark 状态栏配置
#define STATUS_BAR_BACKGROUND_COLOR_DEFAULT [UIColor colorWithRed:0.12 green:0.46 blue:0.69 alpha:0.6]


#pragma mark 导航栏配置
#define NAVIGATION_BAR_TITLE_FONT_DEFAULT [UIFont systemFontOfSize:18.0]
#define NAVIGATION_BAR_TITLE_COLOR_DEFAULT  [UIColor colorWithRed:0.93 green:0.96 blue:0.98 alpha:1.00]
#define NAVIGATION_BAR_BACKGROUND_COLOR_DEFAULT [UIColor colorWithRed:0.12 green:0.46 blue:0.69 alpha:0.60]
#pragma mark 导航栏配置 - 按钮
#define NAVIGATION_BAR_BUTTON_TITLE_FONT [UIFont systemFontOfSize:16.0f]
#define NAVIGATION_BAR_BUTTON_TITLE_COLOR_NORMAL [UIColor colorWithRed:0.93 green:0.96 blue:0.98 alpha:1.00]
#define NAVIGATION_BAR_BUTTON_TITLE_COLOR_SELECT [UIColor colorWithRed:0.93 green:0.96 blue:0.98 alpha:1.00]


#pragma mark 标签栏配置
#define TAB_BAR_TITLE_FONT_DEFAULT [UIFont systemFontOfSize:12.0f]
#define TAB_BAR_TITLE_COLOR_NORMAL_DEFAULT [UIColor colorWithRed:0.42 green:0.44 blue:0.45 alpha:1.00]
#define TAB_BAR_TITLE_COLOR_SELECT_DEFAULT [UIColor colorWithRed:0.00 green:0.33 blue:0.55 alpha:1.00]


#endif /* YHSSystemMacro_h */




