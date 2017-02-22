//
//  ViewController.m
//  YHSHAISHENGCAIPU
//
//  Created by YANGHAISHENG on 2017/2/21.
//  Copyright © 2017年 YANGHAISHENG. All rights reserved.
//

#import "ViewController.h"
#import "YHSBaseNavigationController.h"
#import "HomeMainViewController.h"
#import "FinderMainViewController.h"
#import "SquareMainViewController.h"
#import "MineMainViewController.h"


@interface ViewController ()

@end

@implementation ViewController


#pragma mark 添加子控制器
- (void)addChildControllers
{
    // 首页
    [self addChildNavigationController:[YHSBaseNavigationController class]
                    rootViewController:[HomeMainViewController class]
                       navigationTitle:NAVIGATION_BAR_TITLE_HOME
                       tabBarItemTitle:TAB_BAR_ITEM_NAME_HOME
                 tabBarNormalImageName:ICON_TAB_BAR_ITEM_HOME_NORMAL
                 tabBarSelectImageName:ICON_TAB_BAR_ITEM_HOME_SELECT];
    
    // 发现
    [self addChildNavigationController:[YHSBaseNavigationController class]
                    rootViewController:[FinderMainViewController class]
                       navigationTitle:NAVIGATION_BAR_TITLE_FINDER
                       tabBarItemTitle:TAB_BAR_ITEM_NAME_FINDER
                 tabBarNormalImageName:ICON_TAB_BAR_ITEM_FINDER_NORMAL
                 tabBarSelectImageName:ICON_TAB_BAR_ITEM_FINDER_SELECT];
    
    // 广场
    [self addChildNavigationController:[YHSBaseNavigationController class]
                    rootViewController:[FinderMainViewController class]
                       navigationTitle:NAVIGATION_BAR_TITLE_SQUARE
                       tabBarItemTitle:TAB_BAR_ITEM_NAME_SQUARE
                 tabBarNormalImageName:ICON_TAB_BAR_ITEM_SQUARE_NORMAL
                 tabBarSelectImageName:ICON_TAB_BAR_ITEM_SQUARE_SELECT];
    
    // 我的
    [self addChildNavigationController:[YHSBaseNavigationController class]
                    rootViewController:[MineMainViewController class]
                       navigationTitle:NAVIGATION_BAR_TITLE_MINE
                       tabBarItemTitle:TAB_BAR_ITEM_NAME_MINE
                 tabBarNormalImageName:ICON_TAB_BAR_ITEM_MINE_NORMAL
                 tabBarSelectImageName:ICON_TAB_BAR_ITEM_MINE_SELECT];
}


#pragma mark -
#pragma mark 通过设置返回值来禁止某个UIViewController能否被选中
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    return YES;
}


#pragma mark 选中Tab项时被调用（在这里做某些操作：如隐藏状态栏，导航栏什么的）
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    
}


@end



