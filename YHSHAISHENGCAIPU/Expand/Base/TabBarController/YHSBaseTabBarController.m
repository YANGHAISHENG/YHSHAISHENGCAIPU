//
//  YHSBaseTabBarController.m
//  YHSAPPFRAMEWORK
//
//  Created by YANGHAISHENG on 2016/11/28.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSBaseTabBarController.h"
#import "UIImage+Resize.h"

@interface YHSBaseTabBarController () <UITabBarControllerDelegate>

@end

@implementation YHSBaseTabBarController


#pragma mark 视图生命周期（加载视图）
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 添加子控制器
    [self addChildControllers];
}


#pragma mark 添加导航控制器
- (void)addChildNavigationController:(Class)navigationControllerClass
                  rootViewController:(Class)rootViewControllerClass
                     navigationTitle:(NSString *)navigationTitle
                     tabBarItemTitle:(NSString *)tabBarItemTitle
               tabBarNormalImageName:(NSString *)normalImageName
               tabBarSelectImageName:(NSString *)selectImageName
{
    // 创建视图控制器
    UIViewController *rootViewController = [[rootViewControllerClass alloc] init];
    rootViewController.automaticallyAdjustsScrollViewInsets = NO;
    rootViewController.title = tabBarItemTitle; // 默认设置与tabBarItem一样
    if (nil != navigationTitle && navigationTitle.length > 0) {
        rootViewController.title = navigationTitle;
    }
    
    // 创建导航控制器
    UINavigationController *naviViewController = [[navigationControllerClass  alloc] initWithRootViewController:rootViewController];
    naviViewController.automaticallyAdjustsScrollViewInsets = NO;
    naviViewController.tabBarItem.title = tabBarItemTitle;
    [naviViewController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:TAB_BAR_TITLE_FONT_DEFAULT,
                                                            NSForegroundColorAttributeName:TAB_BAR_TITLE_COLOR_NORMAL_DEFAULT}
                                                 forState:UIControlStateNormal];
    [naviViewController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:TAB_BAR_TITLE_FONT_DEFAULT,
                                                            NSForegroundColorAttributeName:TAB_BAR_TITLE_COLOR_SELECT_DEFAULT}
                                                 forState:UIControlStateSelected];
    
    // 标签栏图片
    CGSize imageSize = CGSizeMake(TAB_BAR_HEIGHT_DEFAULT*0.60, TAB_BAR_HEIGHT_DEFAULT*0.60);
    naviViewController.tabBarItem.image = [[[UIImage imageNamed:normalImageName]
                                            imageByScalingProportionallyToSize:imageSize]
                                           imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    naviViewController.tabBarItem.selectedImage = [[[UIImage imageNamed:selectImageName]
                                                    imageByScalingProportionallyToSize:imageSize]
                                                   imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 主标签控制器中添加子导航控制器
    [self addChildViewController:naviViewController];
    
    // 设置底部UITabBarControllerDelegate代理
    rootViewController.tabBarController.delegate = self;
}


#pragma mark 设置子控制器，子类继承并重写
- (void)addChildControllers
{
    // add view controllers in subviews
    
}


#pragma mark -
#pragma mark 通过设置返回值来禁止某个UIViewController能否被选中
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    YHSDEBUGLog(@"%s\n", __FUNCTION__);
    
    return YES;
}


#pragma mark 选中Tab项时被调用（在这里做某些操作：如隐藏状态栏，导航栏什么的）
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    YHSDEBUGLog(@"%s\n", __FUNCTION__);
}


@end


