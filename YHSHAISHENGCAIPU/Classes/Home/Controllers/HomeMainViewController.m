//
//  HomeMainViewController.m
//  YHSHAISHENGCAIPU
//
//  Created by YANGHAISHENG on 2017/2/21.
//  Copyright © 2017年 YANGHAISHENG. All rights reserved.
//

#import "HomeMainViewController.h"
#import "BannerADTableViewCell.h"
#import "BannerADModel.h"


@interface HomeMainViewController () <BannerADTableViewCellDelegate>

@end


@implementation HomeMainViewController


#pragma mark -
#pragma mark 事件处理 - 表格 Secion 头部事件
- (void)didSelectIndexAtHomeMainTableSecionHeader:(NSInteger)tableSection
{
    YHSDEBUGLog(@"TabSection Header -> %ld", tableSection);
    
    switch (tableSection) {
        case YHSCookBookTableSectionBanner:
        case YHSCookBookTableSectionTools: { // 分类工具
            
            return ;
        }
        case YHSCookBookTableSectionHotsAlbum: { // 热门专辑

            return ;
        }
        case YHSCookBookTableSectionYourLove: { // 猜你喜欢

            return ;
        }
        case YHSCookBookTableSectionRecommed: // 热门推荐
        case YHSCookBookTableSectionGoods: { // 到家商品
            
            return ;
        }
        case YHSCookBookTableSectionQualityRead: { // 精品阅读

            return ;
        }
        case YHSCookBookTableSectionHotsActivity: { // 热门活动

            return ;
        }
        case YHSCookBookTableSectionHaoDouVIP: { // 好豆达人

            return ;
        }
        case YHSCookBookTableSectionPublish: { // 分享美食
            
            return ;
        }
    }
    
}




#pragma mark -
#pragma mark 视图生命周期（初始化）
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isTableViewReloadData = NO; // 是否强制刷新reloadData（默认NO）
        self.hasTableViewRefresh = YES; // 基类创建表格UITableView
    }
    return self;
}


#pragma mark 设置导航条是否隐藏
- (BOOL)prefersNavigationBarHidden
{
    return NO;
}


#pragma mark 视图生命周期（加载视图）
- (void)viewDidLoad
{
    [super viewDidLoad];

    
}


#pragma mark 加载完数据后，其它操作，每次刷新加载数据后都会执行
- (void)viewDidLoadAfterLoadNetworkDataOrCacheData
{
    
}


#pragma mark 注册UITableViewCell
- (void)tableViewRefreshRegisterClass:(UITableView *)tableView
{
    [self.tableViewRefresh registerClass:[BannerADTableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER_BANNER_AD];
    
    
}


#pragma mark -
#pragma mark 请求地址（子类继承实现）
- (NSString *)getRequestURLString
{
    return @"http://api.haodou.com/index.php?appid=2&appkey=9ef269eec4f7a9d07c73952d06b5413f&format=json&sessionid=1462965652904&vc=83&vn=6.1.0&loguid=9798666&deviceid=haodou864601020999058&uuid=72b9cf70da593de0478cbb90f6025bf7&channel=huawei_v610&method=Index.index&virtual=&signmethod=md5&v=2&timestamp=1462970899&nonce=0.1726062234284439&appsign=0b7453175cacb0a7a5cb1f37a7f1942b";
}


#pragma mark 请求参数（子类继承实现）
- (NSMutableDictionary *)getRequestParamerterWithKeys
{
    return @{@"uid":@"9798666",
             @"sign":@"a8b56ca6aefe903b94030c71e145d536",
             @"limit":@"10",
             @"offset":@"0",
             @"uuid":@"72b9cf70da593de0478cbb90f6025bf7"}.mutableCopy;
}


#pragma mark 请求网络数据或加载缓存
- (NSMutableArray *)loadNetworkDataOrCacheData:(id)responseDataOrCacheData
{
    // 弱引用self
    WEAKSELF(weakSelf);
    
    
    // 请求成功，解析数据
    NSDictionary *data = ((NSDictionary *)responseDataOrCacheData)[@"result"];
    YHSDEBUGLog(@"%@", data);
    
    
    /////////////////////////////////////////////////////////////////
    // A、组装数据 -> 开始
    /////////////////////////////////////////////////////////////////
    
    
    // 0.广告横幅
    NSMutableArray<BannerADModel *> *bannerModelArray = [NSMutableArray array];
    [data[@"recipe"][@"list"] enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
        BannerADModel *model = [BannerADModel mj_objectWithKeyValues:dict];
        
        /*
         {
         "Title": "活动",
         "Img": "http:\/\/img1.hoto.cn\/haodou\/recipe_mobile_ad\/2016\/05\/1463741843.jpg",
         "Url": "haodourecipe:\/\/haodou.com\/openurlid\/?id=590044"
         }, {
         "Title": "成都美食大盘点",
         "Img": "http:\/\/img1.hoto.cn\/haodou\/recipe_mobile_ad\/2016\/05\/1463739108.jpg",
         "Url": "haodourecipe:\/\/haodou.com\/collect\/info\/?id=9571757"
         }, {
         "Title": "活动",
         "Img": "http:\/\/img1.hoto.cn\/haodou\/recipe_mobile_ad\/2016\/05\/1463877710.jpg",
         "Url": "haodourecipe:\/\/haodou.com\/opentopic\/?url=http%3A%2F%2Fm.haodou.com%2Ftopic-458446.html&id=458446"
         }, {
         "Title": "超赞的下饭菜",
         "Img": "http:\/\/img1.hoto.cn\/haodou\/recipe_mobile_ad\/2016\/05\/1463738785.jpg",
         "Url": "haodourecipe:\/\/haodou.com\/collect\/info\/?id=12599959"
         }, {
         "Title": "我们“蕉”往吧",
         "Img": "http:\/\/img1.hoto.cn\/haodou\/recipe_mobile_ad\/2016\/05\/1463743624.jpg",
         "Url": "haodourecipe:\/\/haodou.com\/collect\/info\/?id=12600047"
         }, {
         "Title": "鱼香肉丝",
         "Img": "http:\/\/img1.hoto.cn\/haodou\/recipe_mobile_ad\/2016\/05\/1463743688.jpg",
         "Url": "haodourecipe:\/\/haodou.com\/recipe\/info\/?id=1071703&video=0"
         }, {
         "Title": "红薯干果粥",
         "Img": "http:\/\/img1.hoto.cn\/haodou\/recipe_mobile_ad\/2016\/05\/1463568626.jpg",
         "Url": "haodourecipe:\/\/haodou.com\/recipe\/info\/?id=1070878&video=0"
         }
         */
        
        // 过滤数据（现阶段只有collect、recipe可以访问）
        if ([model.Url containsaString:@"haodou.com/collect/info/?id="] || [model.Url containsaString:@"haodou.com/recipe/info/?id="]) {
            [bannerModelArray addObject:model];
        }
    }];
    
    
    
    
    /////////////////////////////////////////////////////////////////
    // A、组装数据 -> 结束
    /////////////////////////////////////////////////////////////////
    
    
    /////////////////////////////////////////////////////////////////
    // B、配置数据源 DataSource  -> 开始
    /////////////////////////////////////////////////////////////////
    if (0 == self.offset) {
        
        weakSelf.tableDataRefresh = [NSMutableArray array];
        
        // 循环广告
        [weakSelf.tableDataRefresh addObject:@[bannerModelArray].mutableCopy];
        
    } else {
        
        // 循环广告
        [weakSelf.tableDataRefresh replaceObjectAtIndex:0 withObject:@[bannerModelArray].mutableCopy];

    }
    /////////////////////////////////////////////////////////////////
    // B、配置数据源 DataSource  -> 结束
    /////////////////////////////////////////////////////////////////
    
    return weakSelf.tableDataRefresh;
}


#pragma mark - TableView data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tableDataRefresh.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.tableDataRefresh.count > 0 && self.tableDataRefresh.count > section) {
        
        NSMutableArray *group = self.tableDataRefresh[section];
        
        return group.count;
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
            // 广告横幅
        case YHSCookBookTableSectionBanner: {
            BannerADTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER_BANNER_AD];
            if (!cell) {
                cell = [[BannerADTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER_BANNER_AD];
            }
            cell.delegate = self;
            cell.model = self.tableDataRefresh[indexPath.section][indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        default: {
            return nil;
        }
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
            // 广告横幅
        case YHSCookBookTableSectionBanner: {
            return [self.tableViewRefresh fd_heightForCellWithIdentifier:CELL_IDENTIFIER_BANNER_AD cacheByIndexPath:indexPath configuration:^(BannerADTableViewCell *cell) {
                cell.model = self.tableDataRefresh[indexPath.section][indexPath.row];
            }];
        }
        default: {
            return 0.0;
        }
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGFloat height = 55.0;
    
    NSMutableArray *group = self.tableDataRefresh[section];
    
    switch (section) {
            // 广告横幅
        case YHSCookBookTableSectionBanner: {
            return nil;
        }
        default: {
            return nil;
        }
    }
    
    return nil;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    CGFloat height = 15.0;
    
    NSMutableArray *group = self.tableDataRefresh[section];
    
    switch (section) {
            // 广告横幅
        case YHSCookBookTableSectionBanner: {
            return nil;
        }
        default: {
            return nil;
        }
    }
    
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height = 45.0;
    
    NSMutableArray *group = self.tableDataRefresh[section];
    
    switch (section) {
            // 广告横幅
        case YHSCookBookTableSectionBanner: {
            return 0.01f;
        }
        default: {
            return 0.01f;
        }
    }
    
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CGFloat height = 15.0;
    
    NSMutableArray *group = self.tableDataRefresh[section];
    
    switch (section) {
            // 广告横幅
        case YHSCookBookTableSectionBanner: {
            return 0.01f;
        }
        default: {
            return 0.01f;
        }
    }
    
    return 0.01f;
}



@end




