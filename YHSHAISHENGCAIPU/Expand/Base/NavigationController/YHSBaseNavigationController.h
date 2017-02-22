//
//  YHSBaseNavigationController.h
//  YHSAPPFRAMEWORK
//
//  Created by YANGHAISHENG on 2016/11/28.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHSBaseNavigationController : UINavigationController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated title:(NSString *)title;

- (void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers;

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated;

@end





