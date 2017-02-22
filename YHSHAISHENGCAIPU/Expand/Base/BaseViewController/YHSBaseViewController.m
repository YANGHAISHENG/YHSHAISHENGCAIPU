//
//  YHSBaseViewController.m
//  YHSAPPFRAMEWORK
//
//  Created by YANGHAISHENG on 2016/11/28.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSBaseViewController.h"


@interface YHSBaseViewController ()

@end


@implementation YHSBaseViewController


#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 视图背景色
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    // 监听通知UIContentSizeCategoryDidChangeNotification
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(contentSizeDidChangeNotification:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
}


- (void)contentSizeDidChangeNotification:(NSNotification*)notification
{
    [self contentSizeDidChange:notification.userInfo[UIContentSizeCategoryNewValueKey]];
}


- (void)contentSizeDidChange:(NSString *)size
{
    // Implement in subclass
    
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - Navigation


#pragma mark 设置状态栏是否隐藏
- (BOOL)prefersStatusBarHidden
{
    return NO;
}


#pragma mark 设置状态栏的前景色
- (UIStatusBarStyle)preferredStatusBarStyle
{
    // 默认黑色
    //return UIStatusBarStyleDefault;
    
    // 白色
    return UIStatusBarStyleLightContent;
}


@end





