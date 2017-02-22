//
//  YHSBaseTableRefreshViewController.m
//  YHSHAISHENGCAIPU
//
//  Created by YANGHAISHENG on 2017/2/22.
//  Copyright © 2017年 YANGHAISHENG. All rights reserved.
//

#import "YHSBaseTableRefreshViewController.h"

@interface YHSBaseTableRefreshViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation YHSBaseTableRefreshViewController


#pragma mark -
#pragma mark 视图生命周期（初始化）
- (instancetype)init
{
    self = [super init];
    if (self) {
        _page = 1;
        _limit = 10;
        _offset = 0;
        
        _isTableViewReloadData = NO; // 是否强制刷新reloadData（默认NO）
        _hasTableViewRefresh = NO; // 默认不创建表格
        _hasRefreshHeader = YES; // 是否可下拉刷新（默认YES）
        _hasRefreshFooter = YES; // 是否可上拉加载（默认YES）
        _hasRefreshOnce = NO; // 是否只可下拉刷新1次（默认NO）(数据固定的页面使用，如：我的、设置)
        
        _isEmptyDataSetShouldDisplay = NO; // 是否显示EmptyDataSet空白页（默认NO）
        _isEmptyDataSetShouldAllowScroll = YES; // 是否允许滚动（默认YES）
        _isEmptyDataSetShouldAllowImageViewAnimate = YES; // 图片是否要动画效果（默认YES）
    }
    return self;
}


#pragma mark 视图生命周期（加载视图）
- (void)viewDidLoad
{
    [super viewDidLoad];
    
}


#pragma mark 监听网络变化后执行 - 有网络
- (void)viewDidLoadWithNetworkingStatus
{
    // 配置UI界面
    [self createUIRefreshTable:NO];
    
    // 请求网络数据
    [self.tableViewRefresh.mj_header beginRefreshing];
}


#pragma mark 监听网络变化后执行 - 无网络
- (void)viewDidLoadWithNoNetworkingStatus
{
    // 配置UI界面
    [self createUIRefreshTable:NO];
    
    // 重新设置可刷新数据
    [self.tableViewRefresh setMj_header:self.tableViewRefreshHeader];
    [self.tableViewRefresh setMj_footer:self.tableViewRefreshFooter];
    
    // 请求网络数据
    [self.tableViewRefresh.mj_header beginRefreshing];
}


#pragma mark -
#pragma mark 请求地址（子类继承实现）
- (NSString *)getRequestURLString
{
    return [YHSNetworkingManager makeRequestURLString:nil];
}


#pragma mark 请求参数（子类继承实现）
- (NSMutableDictionary *)getRequestParamerterWithKeys
{
    return [YHSNetworkingManager makeRequestParamerterWithKeys:nil Values:nil];
}


#pragma mark 请求网络数据（下拉刷新数据）
- (void)loadData
{
    // 每次刷新时重置
    self.offset = 0;
    self.page = self.offset/self.limit + 1;
    
    // 加载更多数据
    [self loadMoreData];
    
}


#pragma mark 请求网络数据（上拉加载数据）
- (void)loadMoreData
{
    WEAKSELF(weakSelf);
    
    YHSDEBUGLog(@"加载前：第[%ld]页，偏移量[%ld]，限制量[%ld]", weakSelf.page, weakSelf.offset, self.limit);
    
    // 验证网络状态，无网则直接返回
    if ([YHSNetworkingManager sharedNetworkingManager].networkReachabilityStatus == YHSNetworkStatusUnknown
        || [YHSNetworkingManager sharedNetworkingManager].networkReachabilityStatus == YHSNetworkStatusNotReachable) {
        
        // 加载本地缓存数据
        [self loadCacheDataThen:^(BOOL success, NSUInteger count) {
            
            if (count < weakSelf.limit) {
                
                // 下拉刷新控件，没有更多数据
                [weakSelf.tableViewRefresh.mj_header endRefreshing];
                
                // 上拉刷新控件，没有更多数据
                [weakSelf.tableViewRefresh.mj_footer endRefreshingWithNoMoreData];
                
                // 上拉刷新控件，置空（不显示已加载完成数据）
                weakSelf.tableViewRefresh.mj_footer = nil;
                
            } else {
                
                // 下拉刷新控件，结束刷新状态
                [weakSelf.tableViewRefresh.mj_header endRefreshing];
                
                // 上拉刷新控件，结束刷新状态
                [weakSelf.tableViewRefresh.mj_footer endRefreshing];
                
                // 上拉刷新控件，重新赋值
                [weakSelf.tableViewRefreshFooter setState:MJRefreshStateIdle];
                [weakSelf.tableViewRefresh setMj_footer:weakSelf.tableViewRefreshFooter];
            }
            
            // 加载成功
            if (success && count) {
                
                // 刷新表格
                [weakSelf.tableViewRefresh reloadData];
                
            } else {
                
                // 是否显示EmptyDataSet空白页（默认NO）
                [weakSelf setIsEmptyDataSetShouldDisplay:YES];
                
                // 刷新加载EmptyDataSet空白页
                [weakSelf.tableViewRefresh reloadEmptyDataSet];
                
            }
            
            // 是否需要强制刷新表格
            if (!success && self.isTableViewReloadData) {
                
                // 刷新表格
                [weakSelf.tableViewRefresh reloadData];
                
            }
            
            YHSDEBUGLog(@"加载后：第[%ld]页，偏移量[%ld]，限制量[%ld]", weakSelf.page, weakSelf.offset, self.limit);
            
            // 加载完数据后，其它操作
            [weakSelf viewDidLoadAfterLoadNetworkDataOrCacheData];
            
        }];
        
        return;
        
    } else {
        
        // 请求数据
        [self loadNetworkDataThen:^(BOOL success, NSUInteger count){
            
            if (count < weakSelf.limit) {
                
                // 下拉刷新控件，没有更多数据
                [weakSelf.tableViewRefresh.mj_header endRefreshing];
                
                // 上拉刷新控件，没有更多数据
                [weakSelf.tableViewRefresh.mj_footer endRefreshingWithNoMoreData];
                
                // 上拉刷新控件，置空（不显示已加载完成数据）
                weakSelf.tableViewRefresh.mj_footer = nil;
                
            } else {
                
                // 下拉刷新控件，结束刷新状态
                [weakSelf.tableViewRefresh.mj_header endRefreshing];
                
                // 上拉刷新控件，结束刷新状态
                [weakSelf.tableViewRefresh.mj_footer endRefreshing];
                
                // 上拉刷新控件，重新赋值
                [weakSelf.tableViewRefreshFooter setState:MJRefreshStateIdle];
                [weakSelf.tableViewRefresh setMj_footer:weakSelf.tableViewRefreshFooter];
                
            }
            
            // 加载成功
            if (success && count) {
                
                // 刷新表格
                [weakSelf.tableViewRefresh reloadData];
                
                // 增加偏移量
                if (count < weakSelf.limit) {
                    weakSelf.offset += count;
                } else {
                    weakSelf.offset += weakSelf.limit;
                }
                weakSelf.page = weakSelf.offset/weakSelf.limit+1;
                
                // 是否只可下拉刷新1次（默认NO）
                if (weakSelf.hasRefreshOnce) {
                    [weakSelf.tableViewRefresh setMj_header:nil];
                    [weakSelf.tableViewRefresh setMj_footer:nil];
                }
                
            } else {
                
                // 是否显示EmptyDataSet空白页（默认NO）
                [weakSelf setIsEmptyDataSetShouldDisplay:YES];
                
                // 刷新加载EmptyDataSet空白页
                [weakSelf.tableViewRefresh reloadEmptyDataSet];
                
            }
            
            // 是否需要强制刷新表格
            if (!success && self.isTableViewReloadData) {
                
                // 刷新表格
                [weakSelf.tableViewRefresh reloadData];
                
            }
            
            YHSDEBUGLog(@"加载后：第[%ld]页，偏移量[%ld]，限制量[%ld]", weakSelf.page, weakSelf.offset, self.limit);
            
            // 加载完数据后，其它操作
            [weakSelf viewDidLoadAfterLoadNetworkDataOrCacheData];
            
        }];
        
    }
    
}


#pragma mark 请求网络数据（请求逻辑处理）
- (void)loadNetworkDataThen:(void (^)(BOOL success, NSUInteger count))then
{
    WEAKSELF(weakSelf);
    
    // 加载显示等待进度提示框
    // MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // 在默认优先级的 Global Dispatch Queue 中执行块(Block)，并行处理
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 请求数据是否成功
        __block BOOL isSuccess = NO;
        __block NSUInteger listCount = 0; // 请求到的数据数量
        
        // 请求地址与参数
        NSString *url = [weakSelf getRequestURLString];
        NSMutableDictionary *params = [weakSelf getRequestParamerterWithKeys];
        YHSDEBUGLog(@"请求地址：%@ \n 请求参数：%@", url, params);
        
        // 验证请求连接的正确性
        if ([YHSSystemUtil validateEmpty:url]) {
            return ;
        }
        
        // 数据分页处理
        [params setObject:[NSNumber numberWithInteger:_page] forKey:@"page"];
        [params setObject:[NSNumber numberWithInteger:_limit] forKey:@"length"];
        
        // 请求网络数据
        [YHSNetworkingManager POST:url parameters:params responseCache:^(id responseCache) {
            
            /*
             
             // 如果有网络，则直接请求网络数据，不需要加载缓存
             
             // 加载解析缓存数据结果
             NSMutableArray *responseTableData = [NSMutableArray array];
             
             // 加载解析缓存数据
             if (responseCache != nil) {
             responseTableData = [weakSelf loadNetworkDataOrCacheData:responseCache];
             }
             
             // 更新加载数据状态（用于刷新数据表格）
             listCount = responseTableData.count;
             if (listCount > 0) {
             isSuccess = YES;
             WDYDEBUGLog(@"加载解析缓存数据成功");
             } else {
             isSuccess = NO;
             WDYDEBUGLog(@"加载解析缓存数据失败");
             }
             
             */
            
        } success:^(id responseObject) {
            
            // 加载解析网络数据
            NSMutableArray *responseTableData = [weakSelf loadNetworkDataOrCacheData:responseObject];
            
            // 更新请求数据状态（用于刷新数据表格）
            listCount = responseTableData.count - (weakSelf.page-1)*weakSelf.limit;
            if (listCount > 0) {
                isSuccess = YES;
                YHSDEBUGLog(@"加载请求网络数据成功");
            } else {
                isSuccess = NO;
                YHSDEBUGLog(@"没有更多数据");
            }
            
            // 在 Main Dispatch Queue 中执行块(Block)，串行处理
            dispatch_async(dispatch_get_main_queue(), ^{
                
                // 隐藏显示等待进度提示框
                // [hud hideAnimated:YES];
                
                // 刷新界面
                !then ?: then(isSuccess, listCount);
                
            });
            
        } failure:^(NSError *error) {
            
            YHSDEBUGLog(@"加载请求网络数据异常：%@", error);
            
            // 在 Main Dispatch Queue 中执行块(Block)，串行处理
            dispatch_async(dispatch_get_main_queue(), ^{
                
                // 隐藏显示等待进度提示框
                // [hud hideAnimated:YES];
                
                // 刷新界面
                !then ?: then(isSuccess, listCount);
                
            });
            
        }];
        
    }); // dispatch_async
    
}


#pragma mark 请求缓存数据（根据URL加载缓存数据）
- (void)loadCacheDataThen:(void (^)(BOOL success, NSUInteger count))then
{
    WEAKSELF(weakSelf);
    
    // 加载显示等待进度提示框
    // MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // 在默认优先级的 Global Dispatch Queue 中执行块(Block)，并行处理
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 请求数据是否成功
        __block BOOL isSuccess = NO;
        __block NSUInteger listCount = 0; // 请求到的数据数量
        
        // 请求地址
        NSString *url = [weakSelf getRequestURLString];
        
        // 验证请求连接的正确性
        if ([YHSSystemUtil validateEmpty:url]) {
            return ;
        }
        
        // 获取本地缓存数据
        id responseCache = [YHSNetworkingCache getResponseCacheForKey:url];
        
        // 加载解析缓存数据
        NSMutableArray *responseTableData = [self loadNetworkDataOrCacheData:responseCache];
        
        // 更新加载数据状态（用于刷新数据表格）
        listCount = responseTableData.count;
        if (listCount > 0) {
            isSuccess = YES;
            YHSDEBUGLog(@"加载解析缓存数据成功");
        } else {
            isSuccess = NO;
            YHSDEBUGLog(@"加载解析缓存数据失败");
        }
        
        // 在 Main Dispatch Queue 中执行块(Block)，串行处理
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // 隐藏显示等待进度提示框
            // [hud hideAnimated:YES];
            
            // 刷新界面
            !then ?: then(isSuccess, listCount);
            
        });
        
    }); // dispatch_async
    
}


#pragma mark 请求网络数据或加载缓存（子类继承实现处理过程）
- (NSMutableArray *)loadNetworkDataOrCacheData:(id)responseDataOrCacheData
{
    // TODO:子类继承实现处理过程
    
    return nil;
}


#pragma mark -
#pragma mark 加载完数据后，其它操作，每次刷新加载数据后都会执行
- (void)viewDidLoadAfterLoadNetworkDataOrCacheData
{
    
}



#pragma mark 创建界面表格
- (void)createUIRefreshTable:(BOOL)force
{
    WEAKSELF(weakSelf);
    
    
    // 是否创建表格
    if (!_hasTableViewRefresh) {
        return;
    }
    
    
    // 表格已经存在则无需创建，直接返回；否则强制创建表格
    if (self.tableViewRefresh && !force) {
        return;
    }
    
    
    // 强制创建表格
    if (force && self.tableViewRefresh) {
        [self.tableViewRefresh removeFromSuperview];
        [self setTableViewRefresh:nil];
    }
    
    
    // 创建表格
    {
        // 创建表格
        self.tableViewRefresh = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:self.tableViewRefresh];
        self.tableViewRefresh.delegate = self;
        self.tableViewRefresh.dataSource = self;
        self.tableViewRefresh.estimatedRowHeight = 200;
        self.tableViewRefresh.fd_debugLogEnabled = YES;
        self.tableViewRefresh.showsVerticalScrollIndicator = NO;
        self.tableViewRefresh.backgroundColor = [UIColor whiteColor];
        self.tableViewRefresh.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
        // 添加约束确实表格位置大小
        if ([self.navigationController fd_prefersNavigationBarHidden]) {
            // 系统导航栏已隐藏-自定义导航栏UINavigationBar
            [self.tableViewRefresh mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.view.mas_top).offset(STATUS_NAVIGATION_BAR_HEIGHT);
                make.left.equalTo(weakSelf.view).with.offset(0.0);
                make.bottom.equalTo(weakSelf.mas_bottomLayoutGuide).with.offset(0.0);
                make.right.equalTo(weakSelf.view).with.offset(0.0);
            }];
        } else {
            // 系统导航栏未隐藏-自定义导航栏TitleView
            [self.tableViewRefresh mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.mas_topLayoutGuide).with.offset(0.0);
                make.left.equalTo(weakSelf.view).with.offset(0.0);
                make.bottom.equalTo(weakSelf.mas_bottomLayoutGuide).with.offset(0.0);
                make.right.equalTo(weakSelf.view).with.offset(0.0);
            }];
        }
        
        
        // 空白数据背景
        self.tableViewRefresh.emptyDataSetSource = self;
        self.tableViewRefresh.emptyDataSetDelegate = self;
        
        
        // 设置背景
        UIView *backgroundView = [[UIView alloc] init];
        [backgroundView setBackgroundColor:TABLEVIEW_BACK_VIEW_BACKGROUND_COLOR];
        [self.tableViewRefresh setBackgroundView:backgroundView];
        
        
        // 表头表尾
        self.tableViewRefresh.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        self.tableViewRefresh.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        
        
        // 下拉刷新
        if (self.hasRefreshHeader) {
            MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
            [refreshHeader.stateLabel setFont:[UIFont systemFontOfSize:[YHSAutoresizeUtil getAutosizeFontSize:YHSRefreshAutoFooterFontSize+1.0]]];
            [refreshHeader.stateLabel setTextColor:[UIColor colorWithRed:0.50 green:0.50 blue:0.51 alpha:1.00]];
            [refreshHeader.lastUpdatedTimeLabel setFont:[UIFont systemFontOfSize:[YHSAutoresizeUtil getAutosizeFontSize:YHSRefreshAutoFooterFontSize]]];
            [refreshHeader.lastUpdatedTimeLabel setTextColor:[UIColor colorWithRed:0.50 green:0.50 blue:0.51 alpha:1.00]];
            [refreshHeader setBackgroundColor:TABLEVIEW_BACK_VIEW_BACKGROUND_COLOR];
            [self setTableViewRefreshHeader:refreshHeader];
            [self.tableViewRefresh setMj_header:refreshHeader];
        }
        
        
        // 上拉加载
        if (self.hasRefreshFooter) {
            MJRefreshAutoNormalFooter *refreshFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
            [refreshFooter setTitle:YHSRefreshAutoFooterIdleText forState:MJRefreshStateIdle];
            [refreshFooter setTitle:YHSRefreshAutoFooterRefreshingText forState:MJRefreshStateRefreshing];
            [refreshFooter setTitle:YHSRefreshAutoFooterNoMoreDataText forState:MJRefreshStateNoMoreData];
            [refreshFooter.stateLabel setFont:[UIFont systemFontOfSize:[YHSAutoresizeUtil getAutosizeFontSize:YHSRefreshAutoFooterFontSize]]];
            [refreshFooter.stateLabel setTextColor:[UIColor colorWithRed:0.50 green:0.50 blue:0.51 alpha:1.00]];
            [refreshFooter setBackgroundColor:TABLEVIEW_BACK_VIEW_BACKGROUND_COLOR];
            [self setTableViewRefreshFooter:refreshFooter];
            // [self.tableViewRefresh setMj_footer:refreshFooter]; // 在loadMoreData刷新加载数据后，根据请求结果确定是否可上拉加载
        }
        
        
        // 必须被注册到 UITableView 中
        [self tableViewRefreshRegisterClass:self.tableViewRefresh];
        
    }
    
}


#pragma mark 注册UITableViewCell（子类继承实现）
- (void)tableViewRefreshRegisterClass:(UITableView *)tableView
{
    
}


#pragma mark 数据模型（懒加载）
- (NSMutableArray *)tableDataRefresh
{
    if (!_tableDataRefresh) {
        _tableDataRefresh = [NSMutableArray array];
    }
    return _tableDataRefresh;
}


#pragma mark - TableView data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0.0f;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0.0f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0.0f;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGFloat height = 0.01f;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableViewRefresh.frame.size.width, height)];
    [headerView setBackgroundColor:TABLEVIEW_HEADER_VIEW_BACKGROUND_COLOR];
    return headerView;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    CGFloat height = 0.01f;
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableViewRefresh.frame.size.width, height)];
    [footerView setBackgroundColor:TABLEVIEW_FOOTER_VIEW_BACKGROUND_COLOR];
    return footerView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}



@end



