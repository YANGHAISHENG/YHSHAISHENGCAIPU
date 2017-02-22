//
//  YHSBaseTabBarController.h
//  YHSAPPFRAMEWORK
//
//  Created by YANGHAISHENG on 2016/11/28.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHSBaseTabBarController : UITabBarController


#pragma mark 添加子导航控制器
- (void)addChildNavigationController:(Class)navigationControllerClass
                  rootViewController:(Class)rootViewControllerClass
                     navigationTitle:(NSString *)navigationTitle
                     tabBarItemTitle:(NSString *)tabBarItemTitle
               tabBarNormalImageName:(NSString *)normalImageName
               tabBarSelectImageName:(NSString *)selectImageName;


@end




