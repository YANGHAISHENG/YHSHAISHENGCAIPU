//
//  UINavigationController+PushViewController.m
//  YHSAPPDEVELOPMENT
//
//  Created by YANGHAISHENG on 2016/12/6.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "UINavigationController+PushViewController.h"


@implementation UINavigationController (PushViewController)


- (void)pushViewController:(UIViewController *)viewController removeViewController:(UIViewController *)removeViewController
{
    [self pushViewController:viewController removeViewController:removeViewController animated:YES];
}


- (void)pushViewController:(UIViewController *)viewController removeViewController:(UIViewController *)removeViewController animated:(BOOL)animated
{
    // 删除视图控制器
    NSMutableArray *filterViewControllers = [NSMutableArray array];
    for (int i = 0; i < self.viewControllers.count; i++) {
        UIViewController *filterViewController = [self.viewControllers objectAtIndex:i];
        if ([filterViewController isKindOfClass:[removeViewController class]]) {
            continue;
        }
        [filterViewControllers addObject:filterViewController];
    }
    
    // 追加视图控制器
    if (viewController) {
        [filterViewControllers addObject:viewController];
    }
    
    // 重置视图控制器
    [self setViewControllers:[NSArray arrayWithArray:filterViewControllers] animated:animated];
}


- (void)pushViewController:(UIViewController *)viewController removeViewControllerAtIndex:(NSInteger)index
{
    [self pushViewController:viewController removeViewControllerAtIndex:index animated:YES];
}


- (void)pushViewController:(UIViewController *)viewController removeViewControllerAtIndex:(NSInteger)index animated:(BOOL)animated
{
    // 删除视图控制器
    NSMutableArray<UIViewController *> *filterViewControllers = [NSMutableArray arrayWithArray:self.viewControllers];
    if (0 < index && self.viewControllers.count > index) {
        [filterViewControllers removeObjectAtIndex:index];
    }
    
    // 追加视图控制器
    if (viewController) {
        [filterViewControllers addObject:viewController];
    }
    
    // 重置视图控制器
    [self setViewControllers:[NSArray arrayWithArray:filterViewControllers] animated:animated];
}


- (void)pushViewController:(UIViewController *)viewController removeViewControllersAtIndexes:(NSIndexSet *)indexes
{
    [self pushViewController:viewController removeViewControllersAtIndexes:indexes animated:YES];
}


- (void)pushViewController:(UIViewController *)viewController removeViewControllersAtIndexes:(NSIndexSet *)indexes animated:(BOOL)animated
{
    // 删除视图控制器
    NSMutableArray<UIViewController *> *filterViewControllers = [NSMutableArray arrayWithArray:self.viewControllers];
    [filterViewControllers removeObjectsAtIndexes:indexes];
    
    // 追加视图控制器
    if (viewController) {
        [filterViewControllers addObject:viewController];
    }
    
    // 重置视图控制器
    [self setViewControllers:[NSArray arrayWithArray:filterViewControllers] animated:animated];
}


- (void)pushViewControllers:(NSArray<UIViewController *> *)viewControllers removeViewControllersAtIndexes:(NSIndexSet *)indexes
{
    [self pushViewControllers:viewControllers removeViewControllersAtIndexes:indexes animated:YES];
}


- (void)pushViewControllers:(NSArray<UIViewController *> *)viewControllers removeViewControllersAtIndexes:(NSIndexSet *)indexes animated:(BOOL)animated
{
    // 删除视图控制器
    NSMutableArray<UIViewController *> *filterViewControllers = [NSMutableArray arrayWithArray:self.viewControllers];
    [filterViewControllers removeObjectsAtIndexes:indexes];
    
    // 追加视图控制器数组
    if (viewControllers.count > 0) {
        [filterViewControllers addObjectsFromArray:viewControllers];
    }
    
    // 重置视图控制器
    [self setViewControllers:[NSArray arrayWithArray:filterViewControllers] animated:animated];
}


@end




