//
//  HomeMainViewController.m
//  YHSHAISHENGCAIPU
//
//  Created by YANGHAISHENG on 2017/2/21.
//  Copyright © 2017年 YANGHAISHENG. All rights reserved.
//

#import "HomeMainViewController.h"

@interface HomeMainViewController ()

@end

@implementation HomeMainViewController


#pragma mark - 导航栏右边按钮类型（默认不显示按钮）
- (YHSNavBarButtonItemType)navigationBarRightButtonItemType
{
    return YHSNavBarButtonItemTypeCustom;
}


#pragma mark - 设置导航栏右边按钮控件标题
- (void)setupNavigationBarRightButtonItemTitle
{
    [self setNavigationBarRightButtonItemTitle:@"搜索"];
}


#pragma mark - 响应导航栏右侧按钮事件
- (void)pressNavigationBarRightButtonItem:(id)sender
{
    YHSBaseNavigationBarViewController *viewController = [[YHSBaseNavigationBarViewController alloc] init];
    [viewController setTitle:@"搜索查询"];
    [self.navigationController pushViewController:viewController animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
