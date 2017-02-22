//
//  YHSBaseTableRefreshViewController.h
//  YHSHAISHENGCAIPU
//
//  Created by YANGHAISHENG on 2017/2/22.
//  Copyright © 2017年 YANGHAISHENG. All rights reserved.
//


#import "YHSBaseNetworkReachabilityViewController.h"
@class MJRefreshHeader, MJRefreshFooter;


@interface YHSBaseTableRefreshViewController : YHSBaseNetworkReachabilityViewController


@property (nonatomic, strong) UITableView *tableViewRefresh; // UITableView表格

@property (nonatomic, strong) NSMutableArray *tableDataRefresh; // UITableView数据源

@property (nonatomic, strong) MJRefreshHeader *tableViewRefreshHeader; // 下拉刷新控件

@property (nonatomic, strong) MJRefreshFooter *tableViewRefreshFooter; // 上拉刷新控件

@property (nonatomic, assign) BOOL hasTableViewRefresh; // 是否创建UITableView表格（默认不创建）

@property (nonatomic, assign) BOOL isTableViewReloadData; // 是否强制刷新reloadData（默认NO）

@property (nonatomic, assign) BOOL hasRefreshHeader; // 是否可下拉刷新（默认YES）

@property (nonatomic, assign) BOOL hasRefreshFooter; // 是否可上拉刷新（默认YES）

@property (nonatomic, assign) BOOL hasRefreshOnce; // 是否只可下拉刷新1次（默认NO）(数据固定的页面使用，如：我的、设置)

@property (nonatomic, assign) NSUInteger page; // 页数

@property (nonatomic, assign) NSUInteger limit; // 数量限制

@property (nonatomic, assign) NSUInteger offset; // 数据偏移量

@property (nonatomic, assign) BOOL isEmptyDataSetShouldDisplay; // 是否显示EmptyDataSet空白页（默认NO）

@property (nonatomic, assign) BOOL isEmptyDataSetShouldAllowScroll; // 是否允许滚动（默认YES）

@property (nonatomic, assign) BOOL isEmptyDataSetShouldAllowImageViewAnimate; // 图片是否要动画效果（默认YES）


#pragma mark 请求地址（子类继承实现）
- (NSString *)getRequestURLString;

#pragma mark 请求参数（子类继承实现）
- (NSMutableDictionary *)getRequestParamerterWithKeys;

#pragma mark 请求网络数据（下拉刷新数据）
- (void)loadData;

#pragma mark 请求网络数据（上拉加载数据）
- (void)loadMoreData;

#pragma mark 请求网络数据（请求逻辑处理）
- (void)loadNetworkDataThen:(void (^)(BOOL success, NSUInteger count))then;

#pragma mark 请求缓存数据（根据URL加载缓存数据）
- (void)loadCacheDataThen:(void (^)(BOOL success, NSUInteger count))then;

#pragma mark 请求网络数据或加载缓存（子类继承实现处理过程）
- (NSMutableArray *)loadNetworkDataOrCacheData:(id)responseDataOrCacheData;

#pragma mark 创建界面表格
- (void)createUIRefreshTable:(BOOL)force;

#pragma mark 注册UITableViewCell（子类继承实现）
- (void)tableViewRefreshRegisterClass:(UITableView *)tableView;

#pragma mark TableView data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;


@end




