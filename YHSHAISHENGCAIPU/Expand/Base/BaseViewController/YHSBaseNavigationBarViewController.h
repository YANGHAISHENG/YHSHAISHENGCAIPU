//
//  YHSBaseNavigationBarViewController.h
//  YHSAPPDEVELOPMENT
//
//  Created by YANGHAISHENG on 2016/12/4.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSBaseViewController.h"

@interface YHSBaseNavigationBarViewController : YHSBaseViewController

@property (nonatomic, strong) UIView *naviStatusBarCustomView; // 状态栏+导航栏容器
@property (nonatomic, strong) UIView *navigationBarCustomView; // 自定义导航栏
@property (nonatomic, strong) UIView *navigationBarHairlineImageView; // 系统自带导航栏底部1px横线

@property (nonatomic, strong) UIView *navigationBarTitleView; // 自定义导航栏标题视图
@property (nonatomic, copy) NSString *navigationBarTitleViewTitle; // 自定义导航栏标题

@property (nonatomic, strong) UIView *navigationBarLeftButtonItem; // 自定义导航栏左边按钮
@property (nonatomic, copy) NSString *navigationBarLeftButtonItemTitle; // 自定义导航栏左边按钮标题

@property (nonatomic, strong) UIView *navigationBarRightButtonItem; // 自定义导航栏右边按钮
@property (nonatomic, copy) NSString *navigationBarRightButtonItemTitle; // 自定义导航栏右边按钮标题

#pragma mark 设置导航条是否隐藏
- (BOOL)prefersNavigationBarHidden;

#pragma mark 设置导航条类型
- (YHSNavBarType)setupNavigationBarType;

#pragma mark 自定义配置导航栏
- (void)setupNavigationBar;

#pragma mark 设置状态栏背景色
- (UIColor *)setupStatusBarColor;

#pragma mark 设置导航条背景色
- (UIColor *)setupNavigationBarColor;

#pragma mark 设置导航条背景图片
- (UIImage *)setupNavigationBarBackgroundImage;

#pragma mark 设置导航条背景图片（是否强制使用图片设置导航条背景）
- (BOOL)setupNavigationBarBackgroundImageForce;

#pragma mark 设置导航栏按钮、标题区域内容
- (void)setupNavigationBarView;

#pragma mark 设置导航条标题字体
- (UIFont *)setupNavigationBarTitleFont;

#pragma mark 设置导航条标题颜色
- (UIColor *)setupNavigationBarTitleColor;

#pragma mark 设置导航栏标题
- (void)setupNavigationBarTitleViewTitle;

#pragma mark 创建导航栏标题控件
- (void)createNavigationBarTitleView:(UIView *)navigationBarTitleView;

#pragma mark 导航栏左边按钮类型（默认显示"返回"按钮）
- (YHSNavBarButtonItemType)navigationBarLeftButtonItemType;

#pragma mark 导航栏右边按钮类型（默认不显示按钮）
- (YHSNavBarButtonItemType)navigationBarRightButtonItemType;

#pragma mark 设置导航栏左边按钮控件标题（需要继承自定义按钮标题，默认“返回”）
- (void)setupNavigationBarLeftButtonItemTitle;

#pragma mark 设置导航栏右边按钮控件标题（需要继承自定义按钮标题，默认“”）
- (void)setupNavigationBarRightButtonItemTitle;

#pragma mark 设置导航栏左边按钮控件标题字体
- (UIFont *)setupNavigationBarLeftButtonItemTitleFont;

#pragma mark 设置导航栏右边按钮控件标题字体
- (UIFont *)setupNavigationBarRightButtonItemTitleFont;

#pragma mark 设置导航栏左边按钮控件标题颜色（正常）
- (UIColor *)setupNavigationBarLeftButtonItemTitleColorNormal;

#pragma mark 设置导航栏右边按钮控件标题颜色（正常）
- (UIColor *)setupNavigationBarRightButtonItemTitleColorNormal;

#pragma mark 设置导航栏左边按钮控件标题颜色（选中）
- (UIColor *)setupNavigationBarLeftButtonItemTitleColorSelect;

#pragma mark 设置导航栏右边按钮控件标题颜色（选中）
- (UIColor *)setupNavigationBarRightButtonItemTitleColorSelect;

#pragma mark 设置导航栏左边按钮控件图标（正常）
- (NSString *)setupNavigationBarLeftButtonItemImageNormal;

#pragma mark 设置导航栏右边按钮控件图标（正常）
- (NSString *)setupNavigationBarRightButtonItemImageNormal;

#pragma mark 设置导航栏左边按钮控件图标（选中）
- (NSString *)setupNavigationBarLeftButtonItemImageSelect;

#pragma mark 设置导航栏右边按钮控件图标（选中）
- (NSString *)setupNavigationBarRightButtonItemImageSelect;

#pragma mark 创建导航栏左边按钮控件
- (UIView *)createNavigationBarLeftButtonItem;

#pragma mark 创建导航栏右边按钮控件
- (UIView *)createNavigationBarRightButtonItem;

#pragma mark 响应导航栏左侧按钮事件
- (void)pressNavigationBarLeftButtonItem:(id)sender;

#pragma mark 响应导航栏右侧按钮事件
- (void)pressNavigationBarRightButtonItem:(id)sender;

#pragma mark 创建导航栏按钮控件YHSNavBarButtonItemTypeDefault
- (UIView *)createNavigationBarButtonItemTypeDefaultTitle:(NSString *)title
                                         titleNormalColor:(UIColor *)normalColor
                                         titleSelectColor:(UIColor *)selectColor
                                                titleFont:(UIFont *)font
                                           iconNameNormal:(NSString *)iconNameNormal
                                           iconNameSelect:(NSString *)iconNameSelect
                                                   action:(SEL)action;

#pragma mark 创建导航栏按钮控件YHSNavBarButtonItemTypeSearch
- (UIView *)createNavigationBarButtonItemTypeSearchTitle:(NSString *)title
                                        titleNormalColor:(UIColor *)normalColor
                                        titleSelectColor:(UIColor *)selectColor
                                               titleFont:(UIFont *)font
                                          iconNameNormal:(NSString *)iconNameNormal
                                          iconNameSelect:(NSString *)iconNameSelect
                                                  action:(SEL)action;

#pragma mark 创建导航栏按钮控件YHSNavBarButtonItemTypeCustom
- (UIView *)createNavigationBarButtonItemTypeCustomTitle:(NSString *)title
                                        titleNormalColor:(UIColor *)normalColor
                                        titleSelectColor:(UIColor *)selectColor
                                               titleFont:(UIFont *)font
                                          iconNameNormal:(NSString *)iconNameNormal
                                          iconNameSelect:(NSString *)iconNameSelect
                                                  action:(SEL)action;

@end




