//
//  YHSBaseNetworkReachabilityViewController.m
//  YHSHAISHENGCAIPU
//
//  Created by YANGHAISHENG on 2017/2/22.
//  Copyright © 2017年 YANGHAISHENG. All rights reserved.
//

#import "YHSBaseNetworkReachabilityViewController.h"

@interface YHSBaseNetworkReachabilityViewController ()

@end

@implementation YHSBaseNetworkReachabilityViewController


- (instancetype)init
{
    self = [super init];
    if (self) {
        _showNetworkReachabilityStatusLabel = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addNetworkReachability];
    
    [self doWithNetworkReachabilityStatus:[YHSNetworkingManager sharedNetworkingManager].networkReachabilityStatus];
}


#pragma mark - 注册监听网络变化
- (void)addNetworkReachability
{
    NSNotificationCenter * notificationCenter = [NSNotificationCenter defaultCenter]; // 通知中心
    [notificationCenter addObserver:self
                           selector:@selector(listenerWithNetworkReachabilityStatus:)  // 调用self中recvBcast:方法
                               name:NOTIFICATION_NETWORKING_STATUS_FREQUENCY  // 广播频段
                             object:nil  // 广播站，一般设置空，设置空则只要是第三个参数内频段内的广播都可以接受，不区分广播站。
     ];
}


// 监听网络变化后执行
- (void) listenerWithNetworkReachabilityStatus:(NSNotification *) notify {
    
    YHSDEBUGLog(@"%s", __FUNCTION__);
    
    NSDictionary *userInfo = notify.userInfo;
    NSNumber *networkReachabilityStatus = (NSNumber *)userInfo[NOTIFICATION_NETWORKING_STATUS_KEY];
    switch (networkReachabilityStatus.intValue) {
        case YHSNetworkStatusUnknown: {
            [self doWithNetworkReachabilityStatus:YHSNetworkStatusUnknown];
            break;
        }
        case YHSNetworkStatusNotReachable: {
            [self doWithNetworkReachabilityStatus:YHSNetworkStatusNotReachable];
            break;
        }
        case YHSNetworkStatusReachableViaWWAN: {
            [self doWithNetworkReachabilityStatus:YHSNetworkStatusReachableViaWWAN];
            break;
        }
        case YHSNetworkStatusReachableViaWiFi: {
            [self doWithNetworkReachabilityStatus:YHSNetworkStatusReachableViaWiFi];
            break;
        }
        default: {
            break;
        }
    }
    
}


// 监听网络变化后执行
- (void)doWithNetworkReachabilityStatus:(YHSNetworkStatus)networkReachabilityStatus
{
    
    YHSDEBUGLog(@"%s", __FUNCTION__);
    
    // 弱引用self
    WEAKSELF(weakSelf);
    
    // 判断当前网络状态
    switch (networkReachabilityStatus) {
        case YHSNetworkStatusUnknown:
        case YHSNetworkStatusNotReachable: {
            
            // 根据网络状态进行加载处理
            [self viewDidLoadWithNoNetworkingStatus];
            
            // 无网络状态提示信息
            if (!self.currentNetworkReachabilityStatusLabel && _showNetworkReachabilityStatusLabel) {
                UILabel *currentNetworkReachabilityStatusLabel = ({
                    NSString *title = @"世界上最遥远的距离就是没网，请检查网络设置";
                    UILabel *label = [[UILabel alloc] init];
                    [self.view addSubview:label];
                    [label setText:title];
                    [label setTextColor:[UIColor whiteColor]];
                    [label setFont:[UIFont boldSystemFontOfSize:[YHSAutoresizeUtil getAutosizeFontSize:NETWORKING_STATUS_FONT_SIZE]]];
                    [label setTextAlignment:NSTextAlignmentCenter];
                    [label.layer setCornerRadius:0.0];
                    [label.layer setMasksToBounds:YES];
                    [label setBackgroundColor:[UIColor colorWithRed:1.00 green:0.77 blue:0.18 alpha:1.00]];
                    
                    // 是否自定义导航栏（系统导航栏已隐藏）
                    if ([self.navigationController fd_prefersNavigationBarHidden]) {
                        [label mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.top.equalTo(weakSelf.view.mas_top).offset(STATUS_NAVIGATION_BAR_HEIGHT);
                            make.centerX.equalTo(weakSelf.view.mas_centerX).offset(0);
                            make.width.equalTo(weakSelf.view.mas_width);
                            make.height.equalTo(@(NETWORKING_STATUS_VIEW_HEIGHT));
                        }];
                    } else {
                        [label mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.top.equalTo(weakSelf.mas_topLayoutGuide).offset(0.0);
                            make.centerX.equalTo(weakSelf.view.mas_centerX).offset(0);
                            make.width.equalTo(weakSelf.view.mas_width);
                            make.height.equalTo(@(NETWORKING_STATUS_VIEW_HEIGHT));
                        }];
                    }
                    
                    label;
                });
                self.currentNetworkReachabilityStatusLabel = currentNetworkReachabilityStatusLabel;
            }
            
            return;
        }
        case YHSNetworkStatusReachableViaWWAN:
        case YHSNetworkStatusReachableViaWiFi: {
            
            // 删除网络状态提示信息
            if (self.currentNetworkReachabilityStatusLabel) {
                [self.currentNetworkReachabilityStatusLabel removeFromSuperview];
                self.currentNetworkReachabilityStatusLabel = nil;
            }
            
            // 根据网络状态进行加载处理
            [self viewDidLoadWithNetworkingStatus];
            
        }
    }
    
}


// 根据网络状态进行加载处理
- (void)viewDidLoadWithNetworkingStatus
{
    
}

// 根据网络状态进行加载处理
- (void)viewDidLoadWithNoNetworkingStatus
{
    
}


@end
