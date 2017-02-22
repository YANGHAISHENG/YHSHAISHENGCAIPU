//
//  YHSBaseNavigationController.m
//  YHSAPPFRAMEWORK
//
//  Created by YANGHAISHENG on 2016/11/28.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSBaseNavigationController.h"

@interface YHSBaseNavigationController ()

@end

@implementation YHSBaseNavigationController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 导航条标题配置
    NSDictionary *titleTextAttributes = @{ NSForegroundColorAttributeName : NAVIGATION_BAR_TITLE_COLOR_DEFAULT };
    [[self navigationBar] setTitleTextAttributes:titleTextAttributes];
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 设置导航条字体
    NSDictionary *titleTextAttributes = @{ NSFontAttributeName : NAVIGATION_BAR_TITLE_FONT_DEFAULT };
    [viewController.navigationItem.backBarButtonItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [viewController setAutomaticallyAdjustsScrollViewInsets:NO];
    
    [super pushViewController:viewController animated:animated];
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated title:(NSString *)title
{
    [viewController setTitle:title];
    
    [self pushViewController:viewController animated:animated];
}


- (void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers
{
    if (self.viewControllers.count > 0) {
        viewControllers[viewControllers.count-1].hidesBottomBarWhenPushed = YES;
    }
    
    [viewControllers[viewControllers.count-1] setAutomaticallyAdjustsScrollViewInsets:NO];
    
    [super setViewControllers:viewControllers];
}


- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewControllers[viewControllers.count-1].hidesBottomBarWhenPushed = YES;
    }
    
    [viewControllers[viewControllers.count-1] setAutomaticallyAdjustsScrollViewInsets:NO];
    
    [super setViewControllers:viewControllers animated:animated];
}


- (UIViewController *)childViewControllerForStatusBarStyle
{
    // 这个接口很重要，默认返回值为nil。当我们调用setNeedsStatusBarAppearanceUpdate时，系统会调用application.window的rootViewController的preferredStatusBarStyle方法。但是我们的程序里一般都是用UINavigationController做root，如果是这种情况，那我们自己的UIViewController里的preferredStatusBarStyle根本不会被调用。
    
    // 这种情况下childViewControllerForStatusBarStyle就派上用场了，我们要子类化一个UINavigationController，在这个子类里面重写childViewControllerForStatusBarStyle方法，像此方法一样。
    
    return self.topViewController;
    
    // 上面代码的意思就是说，不要调用自己(就是UINavigationController)的preferredStatusBarStyle方法，而是去调用navigationController.topViewController的preferredStatusBarStyle方法，这样写的话，就能保证当前显示的UIViewController的preferredStatusBarStyle方法能影响statusBar的前景部分。
}


@end



