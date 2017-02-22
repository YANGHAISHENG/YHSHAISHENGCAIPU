//
//  YHSBaseNetworkReachabilityViewController.h
//  YHSHAISHENGCAIPU
//
//  Created by YANGHAISHENG on 2017/2/22.
//  Copyright © 2017年 YANGHAISHENG. All rights reserved.
//

#import "YHSBaseViewController.h"

@interface YHSBaseNetworkReachabilityViewController : YHSBaseViewController

@property (nonatomic, strong) UILabel *currentNetworkReachabilityStatusLabel;

@property (nonatomic, assign) BOOL showNetworkReachabilityStatusLabel; // 是否显示网络状态提示信息（默认显示）

// 监听网络变化后执行
- (void)doWithNetworkReachabilityStatus:(YHSNetworkStatus)networkReachabilityStatus;

// 根据网络状态进行加载处理
- (void)viewDidLoadWithNetworkingStatus;

// 根据网络状态进行加载处理
- (void)viewDidLoadWithNoNetworkingStatus;

@end
