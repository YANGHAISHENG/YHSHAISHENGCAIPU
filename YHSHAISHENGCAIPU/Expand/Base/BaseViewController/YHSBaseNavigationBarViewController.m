//
//  YHSBaseNavigationBarViewController.m
//  YHSAPPDEVELOPMENT
//
//  Created by YANGHAISHENG on 2016/12/4.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSBaseNavigationBarViewController.h"


@interface YHSBaseNavigationBarViewController ()

@end


@implementation YHSBaseNavigationBarViewController


#pragma mark -
#pragma mark 视图生命周期（初始化）
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


#pragma mark 视图生命周期（加载视图）
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 导航栏类型
    switch ([self setupNavigationBarType]) {
            // 默认系统导航栏
        case YHSNavBarTypeDefaultNaviBarView: {
            [self setFd_prefersNavigationBarHidden:[self prefersNavigationBarHidden]];
            break;
        }
            // 自定义导航栏（隐藏系统导航栏，自定义导航栏）
        case YHSNavBarTypeCustomNaviBarView: {
            [self setFd_prefersNavigationBarHidden:YES];
            break;
        }
        default: {
            break;
        }
    }
    
    // 自定义配置导航栏
    [self setupNavigationBar];
    
}


#pragma mark 视图生命周期（将要显示）
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 设置导航条背景
    if (!self.fd_prefersNavigationBarHidden) {
        [self setupNavigationBarBackgroundColor];
    }
    
}


#pragma mark -
#pragma mark 设置导航条是否隐藏（默认:否）
- (BOOL)prefersNavigationBarHidden
{
    return NO;
}


#pragma mark 设置导航条类型（默认:YHSNavBarTypeDefaultNaviBarView）
- (YHSNavBarType)setupNavigationBarType
{
    return YHSNavBarTypeDefaultNaviBarView;
}


#pragma mark 自定义配置导航栏
- (void)setupNavigationBar
{
    // 导航栏类型
    switch ([self setupNavigationBarType]) {
            // 默认系统导航栏
        case YHSNavBarTypeDefaultNaviBarView: {
            [self setupNavigationBarDefault];
            break;
        }
            // 自定义导航栏（隐藏系统导航栏，自定义导航栏）
        case YHSNavBarTypeCustomNaviBarView: {
            [self setupNavigationBarCustom];
            break;
        }
        default: {
            break;
        }
    }
    
}


#pragma mark 设置状态栏背景色
- (UIColor *)setupStatusBarColor
{
    return [self setupNavigationBarColor];
}


#pragma mark 设置导航条背景色
- (UIColor *)setupNavigationBarColor
{
    return NAVIGATION_BAR_BACKGROUND_COLOR_DEFAULT;
}


#pragma mark 设置导航条背景图片
- (UIImage *)setupNavigationBarBackgroundImage
{
    return [UIImage imageWithColor:[self setupNavigationBarColor]
                           andSize:CGSizeMake(self.navigationController.navigationBar.frame.size.width, STATUS_NAVIGATION_BAR_HEIGHT)];
}


#pragma mark 设置导航条背景图片（是否强制使用图片设置导航条背景）
- (BOOL)setupNavigationBarBackgroundImageForce
{
    return NO;
}


#pragma mark 设置导航栏按钮、标题区域内容
- (void)setupNavigationBarView
{
    // 导航栏类型
    switch ([self setupNavigationBarType]) {
            // 默认系统导航栏
        case YHSNavBarTypeDefaultNaviBarView: {
            [self setupNavigationBarViewDefault];
            break;
        }
            // 自定义导航栏（隐藏系统导航栏，自定义导航栏）
        case YHSNavBarTypeCustomNaviBarView: {
            [self setupNavigationBarViewCustom];
            break;
        }
        default: {
            break;
        }
    }
}


#pragma mark 设置导航条标题字体
- (UIFont *)setupNavigationBarTitleFont
{
    return NAVIGATION_BAR_TITLE_FONT_DEFAULT;
}


#pragma mark 设置导航条标题颜色
- (UIColor *)setupNavigationBarTitleColor
{
    return NAVIGATION_BAR_TITLE_COLOR_DEFAULT;
}


#pragma mark 设置导航栏标题
- (void)setupNavigationBarTitleViewTitle
{
    [self setNavigationBarTitleViewTitle:self.title];
}


#pragma mark 创建导航栏标题控件
- (void)createNavigationBarTitleView:(UIView *)navigationBarTitleView
{
    UILabel *label = [UILabel new];
    NSInteger titleLength = self.navigationBarTitleViewTitle.length > NAVIGATION_BAR_TITLE_MAX_NUM ? NAVIGATION_BAR_TITLE_MAX_NUM :self.navigationBarTitleViewTitle.length;
    [label setText:[self.navigationBarTitleViewTitle substringToIndex:titleLength]];
    [label setFont:[self setupNavigationBarTitleFont]];
    [label setTextColor:[self setupNavigationBarTitleColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [navigationBarTitleView addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(navigationBarTitleView.mas_centerX);
        make.centerY.equalTo(navigationBarTitleView.mas_centerY);
    }];
}


#pragma mark 导航栏左边按钮类型
- (YHSNavBarButtonItemType)navigationBarLeftButtonItemType
{
    if (self.navigationController.viewControllers.count > 1) {
        return YHSNavBarButtonItemTypeDefault;
    }
    return YHSNavBarButtonItemTypeNone;
}


#pragma mark 导航栏右边按钮类型
- (YHSNavBarButtonItemType)navigationBarRightButtonItemType
{
    return YHSNavBarButtonItemTypeNone;
}


#pragma mark 设置导航栏左边按钮标题
- (void)setupNavigationBarLeftButtonItemTitle
{
    [self setNavigationBarLeftButtonItemTitle:NAVIGATION_BAR_BUTTON_TITLE_LEFT];
}


#pragma mark 设置导航栏右边按钮标题
- (void)setupNavigationBarRightButtonItemTitle
{
    [self setNavigationBarRightButtonItemTitle:NAVIGATION_BAR_BUTTON_TITLE_RIGHT];
}


#pragma mark 设置导航栏左边按钮控件标题字体
- (UIFont *)setupNavigationBarLeftButtonItemTitleFont
{
    return NAVIGATION_BAR_BUTTON_TITLE_FONT;
}


#pragma mark 设置导航栏右边按钮控件标题字体
- (UIFont *)setupNavigationBarRightButtonItemTitleFont
{
    return NAVIGATION_BAR_BUTTON_TITLE_FONT;
}


#pragma mark 设置导航栏左边按钮控件标题颜色（正常）
- (UIColor *)setupNavigationBarLeftButtonItemTitleColorNormal
{
    return NAVIGATION_BAR_BUTTON_TITLE_COLOR_NORMAL;
}


#pragma mark 设置导航栏右边按钮控件标题颜色（正常）
- (UIColor *)setupNavigationBarRightButtonItemTitleColorNormal
{
    return NAVIGATION_BAR_BUTTON_TITLE_COLOR_NORMAL;
}


#pragma mark 设置导航栏左边按钮控件标题颜色（选中）
- (UIColor *)setupNavigationBarLeftButtonItemTitleColorSelect
{
    return NAVIGATION_BAR_BUTTON_TITLE_COLOR_SELECT;
}


#pragma mark 设置导航栏右边按钮控件标题颜色（选中）
- (UIColor *)setupNavigationBarRightButtonItemTitleColorSelect
{
    return NAVIGATION_BAR_BUTTON_TITLE_COLOR_SELECT;
}


#pragma mark 设置导航栏左边按钮控件图标（正常）
- (NSString *)setupNavigationBarLeftButtonItemImageNormal
{
    YHSNavBarButtonItemType barButtonItemType = [self navigationBarLeftButtonItemType];
    
    switch (barButtonItemType) {
            // 无按钮
        case YHSNavBarButtonItemTypeNone: {
            
            break;
        }
            // 默认返回
        case YHSNavBarButtonItemTypeDefault: {
            return ICON_NAVIGATION_BAR_BUTTON_BACK_ARROW;
            break;
        }
            // 搜索
        case YHSNavBarButtonItemTypeSearch: {
            return ICON_NAVIGATION_BAR_BUTTON_SEARCH;
            break;
        }
            // 自定义
        case YHSNavBarButtonItemTypeCustom: {
            
        }
        default: {
            break;
        }
    }
    
    return nil;
}


#pragma mark 设置导航栏右边按钮控件图标（正常）
- (NSString *)setupNavigationBarRightButtonItemImageNormal
{
    YHSNavBarButtonItemType barButtonItemType = [self navigationBarRightButtonItemType];
    
    switch (barButtonItemType) {
            // 无按钮
        case YHSNavBarButtonItemTypeNone: {
            
            break;
        }
            // 默认返回
        case YHSNavBarButtonItemTypeDefault: {
            return ICON_NAVIGATION_BAR_BUTTON_BACK_ARROW;
            break;
        }
            // 搜索
        case YHSNavBarButtonItemTypeSearch: {
            return ICON_NAVIGATION_BAR_BUTTON_SEARCH;
            break;
        }
            // 自定义
        case YHSNavBarButtonItemTypeCustom: {
            
        }
        default: {
            break;
        }
    }
    
    return nil;
}


#pragma mark 设置导航栏左边按钮控件图标（选中）
- (NSString *)setupNavigationBarLeftButtonItemImageSelect
{
    YHSNavBarButtonItemType barButtonItemType = [self navigationBarLeftButtonItemType];
    
    switch (barButtonItemType) {
            // 无按钮
        case YHSNavBarButtonItemTypeNone: {
            
            break;
        }
            // 默认返回
        case YHSNavBarButtonItemTypeDefault: {
            return ICON_NAVIGATION_BAR_BUTTON_BACK_ARROW;
            break;
        }
            // 搜索
        case YHSNavBarButtonItemTypeSearch: {
            return ICON_NAVIGATION_BAR_BUTTON_SEARCH;
            break;
        }
            // 自定义
        case YHSNavBarButtonItemTypeCustom: {
            
        }
        default: {
            break;
        }
    }
    
    return nil;
}


#pragma mark 设置导航栏右边按钮控件图标（选中）
- (NSString *)setupNavigationBarRightButtonItemImageSelect
{
    YHSNavBarButtonItemType barButtonItemType = [self navigationBarRightButtonItemType];
    
    switch (barButtonItemType) {
            // 无按钮
        case YHSNavBarButtonItemTypeNone: {

            break;
        }
            // 默认返回
        case YHSNavBarButtonItemTypeDefault: {
            return ICON_NAVIGATION_BAR_BUTTON_BACK_ARROW;
            break;
        }
            // 搜索
        case YHSNavBarButtonItemTypeSearch: {
            return ICON_NAVIGATION_BAR_BUTTON_SEARCH;
            break;
        }
            // 自定义
        case YHSNavBarButtonItemTypeCustom: {

        }
        default: {
            break;
        }
    }

    return nil;
}


#pragma mark 创建导航栏左边按钮控件
- (UIView *)createNavigationBarLeftButtonItem
{
    UIView *ctl_btn = nil;
    
    YHSNavBarButtonItemType barButtonItemType = [self navigationBarLeftButtonItemType];
    UIFont *titleFont = [self setupNavigationBarLeftButtonItemTitleFont];
    UIColor *titleNormalColor = [self setupNavigationBarLeftButtonItemTitleColorNormal];
    UIColor *titleSelectColor = [self setupNavigationBarLeftButtonItemTitleColorSelect];
    NSString *iconNameNormal = [self setupNavigationBarLeftButtonItemImageNormal];
    NSString *iconNameSelect = [self setupNavigationBarLeftButtonItemImageSelect];
    NSString *title = (nil == [self navigationBarLeftButtonItemTitle]) ? @"": [self navigationBarLeftButtonItemTitle];
    SEL actionSel = @selector(pressNavigationBarLeftButtonItem:);
    
    switch (barButtonItemType) {
            // 无按钮
        case YHSNavBarButtonItemTypeNone: {
            ctl_btn = [[UIView alloc] initWithFrame:CGRectZero];
            break;
        }
            // 默认返回
        case YHSNavBarButtonItemTypeDefault: {
            ctl_btn = [self createNavigationBarButtonItemTypeDefaultTitle:title
                                                         titleNormalColor:titleNormalColor
                                                         titleSelectColor:titleSelectColor
                                                                titleFont:titleFont
                                                           iconNameNormal:iconNameNormal
                                                           iconNameSelect:iconNameSelect
                                                                   action:actionSel];
            break;
        }
            // 搜索
        case YHSNavBarButtonItemTypeSearch: {
            ctl_btn = [self createNavigationBarButtonItemTypeSearchTitle:title
                                                        titleNormalColor:titleNormalColor
                                                        titleSelectColor:titleSelectColor
                                                               titleFont:titleFont
                                                          iconNameNormal:iconNameNormal
                                                          iconNameSelect:iconNameSelect
                                                                  action:actionSel];
            break;
        }
            // 自定义
        case YHSNavBarButtonItemTypeCustom: {
            ctl_btn = [self createNavigationBarButtonItemTypeCustomTitle:title
                                                        titleNormalColor:titleNormalColor
                                                        titleSelectColor:titleSelectColor
                                                               titleFont:titleFont
                                                          iconNameNormal:iconNameNormal
                                                          iconNameSelect:iconNameSelect
                                                                  action:actionSel];
        }
        default: {
            break;
        }
    }
    
    return ctl_btn;
}


#pragma mark 创建导航栏右边按钮控件
- (UIView *)createNavigationBarRightButtonItem
{
    UIView *ctl_btn = nil;
    
    YHSNavBarButtonItemType barButtonItemType = [self navigationBarRightButtonItemType];
    UIFont *titleFont = [self setupNavigationBarRightButtonItemTitleFont];
    UIColor *titleNormalColor = [self setupNavigationBarRightButtonItemTitleColorNormal];
    UIColor *titleSelectColor = [self setupNavigationBarRightButtonItemTitleColorSelect];
    NSString *iconNameNormal = [self setupNavigationBarRightButtonItemImageNormal];
    NSString *iconNameSelect = [self setupNavigationBarRightButtonItemImageSelect];
    NSString *title = (nil == [self navigationBarRightButtonItemTitle]) ? @"": [self navigationBarRightButtonItemTitle];
    SEL actionSel = @selector(pressNavigationBarRightButtonItem:);
    
    switch (barButtonItemType) {
            // 无按钮
        case YHSNavBarButtonItemTypeNone: {
            ctl_btn = [[UIView alloc] initWithFrame:CGRectZero];
            break;
        }
            // 默认返回
        case YHSNavBarButtonItemTypeDefault: {
            ctl_btn = [self createNavigationBarButtonItemTypeDefaultTitle:title
                                                         titleNormalColor:titleNormalColor
                                                         titleSelectColor:titleSelectColor
                                                                titleFont:titleFont
                                                           iconNameNormal:iconNameNormal
                                                           iconNameSelect:iconNameSelect
                                                                   action:actionSel];
            break;
        }
            // 搜索
        case YHSNavBarButtonItemTypeSearch: {
            ctl_btn = [self createNavigationBarButtonItemTypeSearchTitle:title
                                                        titleNormalColor:titleNormalColor
                                                        titleSelectColor:titleSelectColor
                                                               titleFont:titleFont
                                                          iconNameNormal:iconNameNormal
                                                          iconNameSelect:iconNameSelect
                                                                  action:actionSel];
            break;
        }
            // 自定义
        case YHSNavBarButtonItemTypeCustom: {
            ctl_btn = [self createNavigationBarButtonItemTypeCustomTitle:title
                                                        titleNormalColor:titleNormalColor
                                                        titleSelectColor:titleSelectColor
                                                               titleFont:titleFont
                                                          iconNameNormal:iconNameNormal
                                                          iconNameSelect:iconNameSelect
                                                                  action:actionSel];
        }
        default: {
            break;
        }
    }
    
    
    return ctl_btn;
}


#pragma mark 响应导航栏左侧按钮事件
- (void)pressNavigationBarLeftButtonItem:(id)sender;
{
    YHSNavBarButtonItemType barButtonItemType = [self navigationBarLeftButtonItemType];
    
    YHSDEBUGLog(@"NavBarButtonItemType is %ld", barButtonItemType);
    
    switch (barButtonItemType) {
            // 无按钮
        case YHSNavBarButtonItemTypeNone: {
            
            break;
        }
            // 默认返回
        case YHSNavBarButtonItemTypeDefault: {
            
            [self.navigationController popViewControllerAnimated:YES];
            
            break;
        }
            // 搜索
        case YHSNavBarButtonItemTypeSearch: {
            // 子类继承此方法进行处理
            break;
        }
            // 自定义
        case YHSNavBarButtonItemTypeCustom: {
            // 子类继承此方法进行处理
            break;
        }
        default:
            break;
    }
    
}


#pragma mark 响应导航栏右侧按钮事件
- (void)pressNavigationBarRightButtonItem:(id)sender
{
    YHSNavBarButtonItemType barButtonItemType = [self navigationBarRightButtonItemType];
    
    YHSDEBUGLog(@"NavBarButtonItemType is %ld", barButtonItemType);
    
    switch (barButtonItemType) {
            // 无按钮
        case YHSNavBarButtonItemTypeNone: {
            
            break;
        }
            // 默认返回
        case YHSNavBarButtonItemTypeDefault: {
            
            [self.navigationController popViewControllerAnimated:YES];
            
            break;
        }
            // 搜索
        case YHSNavBarButtonItemTypeSearch: {
            // 子类继承此方法进行处理
            break;
        }
            // 自定义
        case YHSNavBarButtonItemTypeCustom: {
            // 子类继承此方法进行处理
            break;
        }
        default:
            break;
    }
}


#pragma mark 创建导航栏按钮控件YHSNavBarButtonItemTypeDefault
- (UIView *)createNavigationBarButtonItemTypeDefaultTitle:(NSString *)title
                                         titleNormalColor:(UIColor *)normalColor
                                         titleSelectColor:(UIColor *)selectColor
                                                titleFont:(UIFont *)font
                                           iconNameNormal:(NSString *)iconNameNormal
                                           iconNameSelect:(NSString *)iconNameSelect
                                                   action:(SEL)action
{
    // 按钮正常标题
    NSMutableAttributedString *attributedNormalTitle = [[NSMutableAttributedString alloc] initWithString:title];
    [attributedNormalTitle addAttribute:NSForegroundColorAttributeName value:normalColor range:NSMakeRange(0, title.length)];
    [attributedNormalTitle addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, title.length)];
    CGSize titleSize = [title sizeWithAttributes:@{ NSFontAttributeName:font }];
    
    // 按钮选中标题
    NSMutableAttributedString *attributedSelectTitle = [[NSMutableAttributedString alloc] initWithString:title];
    [attributedSelectTitle addAttribute:NSForegroundColorAttributeName value:selectColor range:NSMakeRange(0, title.length)];
    [attributedSelectTitle addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, title.length)];
    
    // 自定义按钮
    CGFloat btnWidth = MIN(15+titleSize.width, NAVIGATION_BAR_BUTTON_MAX_WIDTH); // 按钮最大宽度
    CGFloat imageSizeWidth = 15.0f;
    CGFloat imageSizeHeight = NAVIGATION_BAR_HEIGHT;
    CGRect btnFrame = CGRectMake(0, 0, btnWidth, NAVIGATION_BAR_HEIGHT);
    UIButton *btn = [[UIButton alloc] initWithFrame:btnFrame];
    [btn setAttributedTitle:attributedNormalTitle forState:UIControlStateNormal];
    [btn setAttributedTitle:attributedSelectTitle forState:UIControlStateHighlighted];
    [btn setImage:[[UIImage imageNamed:iconNameNormal] imageByScalingProportionallyToSize:CGSizeMake(imageSizeWidth, imageSizeHeight)]
         forState:UIControlStateNormal];
    [btn setImage:[[UIImage imageNamed:iconNameSelect] imageByScalingProportionallyToSize:CGSizeMake(imageSizeWidth, imageSizeHeight)]
         forState:UIControlStateHighlighted];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];

    return btn;
}


#pragma mark 创建导航栏按钮控件YHSNavBarButtonItemTypeSearch
- (UIView *)createNavigationBarButtonItemTypeSearchTitle:(NSString *)title
                                        titleNormalColor:(UIColor *)normalColor
                                        titleSelectColor:(UIColor *)selectColor
                                               titleFont:(UIFont *)font
                                          iconNameNormal:(NSString *)iconNameNormal
                                          iconNameSelect:(NSString *)iconNameSelect
                                                  action:(SEL)action
{
    CGFloat btnWidth = 30.0f;
    CGFloat imageSize = 18.0f;
    CGRect btnFrame = CGRectMake(0, 0, btnWidth, NAVIGATION_BAR_HEIGHT);
    UIButton *btn = [[UIButton alloc] initWithFrame:btnFrame];
    [btn setImage:[[UIImage imageNamed:iconNameNormal] imageByScalingProportionallyToSize:CGSizeMake(imageSize, imageSize)]
         forState:UIControlStateNormal];
    [btn setImage:[[UIImage imageNamed:iconNameSelect] imageByScalingProportionallyToSize:CGSizeMake(imageSize, imageSize)]
         forState:UIControlStateHighlighted];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];

    return btn;
}


#pragma mark 创建导航栏按钮控件YHSNavBarButtonItemTypeCustom
- (UIView *)createNavigationBarButtonItemTypeCustomTitle:(NSString *)title
                                        titleNormalColor:(UIColor *)normalColor
                                        titleSelectColor:(UIColor *)selectColor
                                               titleFont:(UIFont *)font
                                          iconNameNormal:(NSString *)iconNameNormal
                                          iconNameSelect:(NSString *)iconNameSelect
                                                  action:(SEL)action
{
    // 按钮正常标题
    NSMutableAttributedString *attributedNormalTitle = [[NSMutableAttributedString alloc] initWithString:title];
    [attributedNormalTitle addAttribute:NSForegroundColorAttributeName value:normalColor range:NSMakeRange(0, title.length)];
    [attributedNormalTitle addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, title.length)];
    CGSize titleSize = [title sizeWithAttributes:@{ NSFontAttributeName:font }];
    
    // 按钮选中标题
    NSMutableAttributedString *attributedSelectTitle = [[NSMutableAttributedString alloc] initWithString:title];
    [attributedSelectTitle addAttribute:NSForegroundColorAttributeName value:selectColor range:NSMakeRange(0, title.length)];
    [attributedSelectTitle addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, title.length)];
    
    // 自定义按钮
    CGFloat maxWidth = MIN(10+titleSize.width, NAVIGATION_BAR_BUTTON_MAX_WIDTH); // 按钮最大宽度
    CGRect btnFrame = CGRectMake(0, 0, maxWidth, NAVIGATION_BAR_HEIGHT);
    UIButton *btn = [[UIButton alloc] initWithFrame:btnFrame];
    [btn setAttributedTitle:attributedNormalTitle forState:UIControlStateNormal];
    [btn setAttributedTitle:attributedSelectTitle forState:UIControlStateHighlighted];
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];

    return btn;
}


#pragma mark - Private
#pragma mark 自定义配置导航栏（默认系统导航栏）
- (void)setupNavigationBarDefault
{
    // 找出导航条底部横线并隐藏
    {
        UIImageView *hairLineImageView = [self findNavigationBarHairlineImageView:self.navigationController.navigationBar];
        [self setNavigationBarHairlineImageView:hairLineImageView];
        [self.navigationBarHairlineImageView setHidden:NO];
    }
    
    // 隐藏导航条、不隐藏状态栏、导航条为空
    if (!self.naviStatusBarCustomView && [self prefersNavigationBarHidden] && ![self prefersStatusBarHidden] ) {
        
        // 显示导航条+状态栏父容器大小
        CGRect naviStatusBarFrame = CGRectMake(0, 0, SCREEN_WIDTH, STATUS_NAVIGATION_BAR_HEIGHT);
        
        // 显示导航条容器大小
        CGRect navigationBarFrame = CGRectMake(0, STATUS_BAR_HEIGHT, SCREEN_WIDTH, NAVIGATION_BAR_HEIGHT);
        
        // 显示状态栏
        if ([self prefersNavigationBarHidden] && ![self prefersStatusBarHidden]) {
            naviStatusBarFrame = CGRectMake(0, 0, SCREEN_WIDTH, STATUS_BAR_HEIGHT);
            navigationBarFrame = CGRectMake(0, 0, SCREEN_WIDTH, 0);
        }
        
        // 导航栏+状态栏容器
        UIView *naviStatusBarCustomView = ({
            UIView *view = [[UIView alloc] initWithFrame:naviStatusBarFrame];
            [view setTag:STATUS_NAVIGATION_BAR_TAG];
            [view setBackgroundColor:[self setupStatusBarColor]];
            [self.view addSubview:view];
            
            view;
        });
        self.naviStatusBarCustomView = naviStatusBarCustomView;
        
        // 自定义导航条视图
        UIView *navigationBarCustomView = ({
            UIView *view = [[UIView alloc] initWithFrame:navigationBarFrame];
            [view setBackgroundColor:[self setupNavigationBarColor]];
            [naviStatusBarCustomView addSubview:view];
            
            view;
        });
        self.navigationBarCustomView = navigationBarCustomView;
        
        // 底部发丝线
        UIView *navigationBarHairlineImageView = ({
            UIView *view = [[UIView alloc] init];
            [view setFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT-NAVIGATION_BAR_HAIR_LINE_HEIGHT, SCREEN_WIDTH, NAVIGATION_BAR_HAIR_LINE_HEIGHT)];
            [view setBackgroundColor:NAVIGATION_BAR_HAIR_LINE_COLOR];
            [navigationBarCustomView addSubview:view];
            
            view;
        });
        self.navigationBarHairlineImageView = navigationBarHairlineImageView;
    }
    
    // 隐藏导航条
    if ([self prefersNavigationBarHidden]) {
        return;
    }
    
    // 设置导航栏按钮、标题区域内容
    [self setupNavigationBarView];
}


#pragma mark 自定义配置导航栏（隐藏系统导航栏，自定义导航栏）
- (void)setupNavigationBarCustom
{
    // 导航条和状态栏都隐藏
    if ([self prefersNavigationBarHidden] && [self prefersStatusBarHidden]) {
        return;
    }
    
    // 如果导航条为空，则创建导航条视图
    if (!self.navigationBarCustomView) {
        
        // 显示导航条+状态栏父容器大小
        CGRect naviStatusBarFrame = CGRectMake(0, 0, SCREEN_WIDTH, STATUS_NAVIGATION_BAR_HEIGHT);
        
        // 显示导航条容器大小
        CGRect navigationBarFrame = CGRectMake(0, STATUS_BAR_HEIGHT, SCREEN_WIDTH, NAVIGATION_BAR_HEIGHT);
        
        // 显示状态栏
        if ([self prefersNavigationBarHidden] && ![self prefersStatusBarHidden]) {
            naviStatusBarFrame = CGRectMake(0, 0, SCREEN_WIDTH, STATUS_BAR_HEIGHT);
            navigationBarFrame = CGRectMake(0, 0, SCREEN_WIDTH, 0);
        }
        // 显示导航条
        else if (![self prefersNavigationBarHidden] && [self prefersStatusBarHidden]) {
            naviStatusBarFrame = CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATION_BAR_HEIGHT);
            navigationBarFrame = CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATION_BAR_HEIGHT);
        }
        // 显示状态栏+导航条
        else if (![self prefersNavigationBarHidden] && ![self prefersStatusBarHidden]) {
            naviStatusBarFrame = CGRectMake(0, 0, SCREEN_WIDTH, STATUS_NAVIGATION_BAR_HEIGHT);
            navigationBarFrame = CGRectMake(0, STATUS_BAR_HEIGHT, SCREEN_WIDTH, NAVIGATION_BAR_HEIGHT);
        }
        
        // 状态栏+导航条容器（64）
        UIView *naviStatusBarCustomView = ({
            UIView *view = [[UIView alloc] initWithFrame:naviStatusBarFrame];
            [view setBackgroundColor:[self setupStatusBarColor]];
            [self.view addSubview:view];
            
            view;
        });
        self.naviStatusBarCustomView = naviStatusBarCustomView;
        
        // 导航条容器（44）
        if (![self prefersNavigationBarHidden]) {
            // 自定义导航条视图
            UIView *navigationBarCustomView = ({
                UIView *view = [[UIView alloc] initWithFrame:navigationBarFrame];
                [view setBackgroundColor:[self setupNavigationBarColor]];
                [naviStatusBarCustomView addSubview:view];
                
                view;
            });
            self.navigationBarCustomView = navigationBarCustomView;
            
            // 导航条底部发丝线
            UIView *navigationBarHairlineImageView = ({
                UIView *view = [[UIView alloc] init];
                [view setFrame:CGRectMake(0, navigationBarFrame.size.height-NAVIGATION_BAR_HAIR_LINE_HEIGHT, navigationBarFrame.size.width, NAVIGATION_BAR_HAIR_LINE_HEIGHT)];
                [view setBackgroundColor:NAVIGATION_BAR_HAIR_LINE_COLOR];
                [navigationBarCustomView addSubview:view];
                
                view;
            });
            self.navigationBarHairlineImageView = navigationBarHairlineImageView;
        }
        
    }
    
    // 隐藏导航条
    if ([self prefersNavigationBarHidden]) {
        return;
    }
    
    // 设置导航栏按钮、标题区域内容
    [self setupNavigationBarView];
}


#pragma mark 设置导航栏按钮、标题区域内容（默认系统导航栏）
- (void)setupNavigationBarViewDefault
{
    // 设置导航条背景
    [self setupNavigationBarBackgroundColor];
    
    
    // 左选项按钮
    if ([self navigationBarLeftButtonItemType]) {
        // 设置按钮标题
        [self setupNavigationBarLeftButtonItemTitle];
        // 创建按钮控件
        self.navigationBarLeftButtonItem = [self createNavigationBarLeftButtonItem];
        if (self.navigationBarLeftButtonItem) {
            // 调整控件位置
            UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.navigationBarLeftButtonItem];
            if([[NSObject OSVersion] floatValue] >= 7.0) {
                /**
                 * width为正数时，相当于UIButton向右移动width数值个像素
                 * width为负数时，正好相反，相当于往左移动width数值个像素
                 */
                UIBarButtonItem *spacerItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                            target:nil
                                                                                            action:nil];
                spacerItem.width = -NAVIGATION_BAR_SCREEN_MARGIN*1.0;
                [[self navigationItem] setLeftBarButtonItems:@[spacerItem, leftItem]];
            } else {
                [[self navigationItem] setLeftBarButtonItem:leftItem  animated:NO];
            }

            // 验证是否为UIControl
            if ([self.navigationBarLeftButtonItem isKindOfClass:[UIControl class]]) {
                [(UIControl *)self.navigationBarLeftButtonItem addTarget:self
                                                                  action:@selector(pressNavigationBarLeftButtonItem:)
                                                        forControlEvents:UIControlEventTouchUpInside];
            } else {
                //
                
            }
        }
    }
    
    
    // 右选项按钮
    if ([self navigationBarRightButtonItemType]) {
        // 设置按钮标题
        [self setupNavigationBarRightButtonItemTitle];
        // 创建按钮控件
        self.navigationBarRightButtonItem = [self createNavigationBarRightButtonItem];
        if (self.navigationBarRightButtonItem) {
            // 调整控件位置
            UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.navigationBarRightButtonItem];
            if([[NSObject OSVersion] floatValue] >= 7.0) {
                /**
                 * width为正数时，相当于UIButton向左移动width数值个像素
                 * width为负数时，正好相反，相当于往右移动width数值个像素
                 */
                UIBarButtonItem *spacerItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                            target:nil
                                                                                            action:nil];
                spacerItem.width = -NAVIGATION_BAR_SCREEN_MARGIN*1.0;
                [[self navigationItem] setRightBarButtonItems:@[spacerItem, rightItem]];
            } else {
                [[self navigationItem] setRightBarButtonItem:rightItem  animated:NO];
            }
            
            // 验证是否为UIControl
            if ([self.navigationBarRightButtonItem isKindOfClass:[UIControl class]]) {
                [(UIControl *)self.navigationBarRightButtonItem addTarget:self
                                                                   action:@selector(pressNavigationBarRightButtonItem:)
                                                         forControlEvents:UIControlEventTouchUpInside];
            } else {
                //
                
            }
            
        }
    }
    
    
    // 标题区域
    {
        CGFloat maxWidth = MAX(CGRectGetWidth(self.navigationBarLeftButtonItem.frame) , CGRectGetWidth(self.navigationBarRightButtonItem.frame)) + NAVIGATION_BAR_SCREEN_MARGIN;
        CGRect titleRect = CGRectMake(NAVIGATION_BAR_SCREEN_MARGIN+maxWidth, 0, SCREEN_WIDTH - 2*(NAVIGATION_BAR_SCREEN_MARGIN + maxWidth), NAVIGATION_BAR_HEIGHT);
        UIView *titleContainerView = [[UIView alloc] initWithFrame:titleRect];
        [self setNavigationBarTitleView:titleContainerView];
        [self.navigationItem setTitleView:titleContainerView];
        
        // 导航条标题视图配置
        [self setupNavigationBarTitleViewTitle];
        [self createNavigationBarTitleView:self.navigationBarTitleView];
    }
    
}


#pragma mark 设置导航栏按钮、标题区域内容（隐藏系统导航栏，自定义导航栏）
- (void)setupNavigationBarViewCustom
{
    // 隐藏系统默认的导航按钮
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
    [[self navigationItem] setLeftBarButtonItem:leftItem  animated:NO];
    [[self navigationItem] setRightBarButtonItem:rightItem  animated:NO];
    
    
    // 左选项按钮
    if ([self navigationBarLeftButtonItemType]) {
        // 设置按钮标题
        [self setupNavigationBarLeftButtonItemTitle];
        // 创建按钮控件
        self.navigationBarLeftButtonItem = [self createNavigationBarLeftButtonItem];
        if (self.navigationBarLeftButtonItem) {
            // 调整控件位置
            CGRect frame = CGRectMake(NAVIGATION_BAR_SCREEN_MARGIN,
                                      self.navigationBarLeftButtonItem.frame.origin.y,
                                      self.navigationBarLeftButtonItem.frame.size.width,
                                      self.navigationBarLeftButtonItem.frame.size.height);
            [self.navigationBarLeftButtonItem setFrame:frame];
            [self.navigationBarCustomView addSubview:self.navigationBarLeftButtonItem];
            
            // 验证是否为UIControl
            if ([self.navigationBarLeftButtonItem isKindOfClass:[UIControl class]]) {
                [(UIControl *)self.navigationBarLeftButtonItem addTarget:self
                                                                  action:@selector(pressNavigationBarLeftButtonItem:)
                                                        forControlEvents:UIControlEventTouchUpInside];
            } else {
                //
                
            }
        }
    }
    
    
    // 右选项按钮
    if ([self navigationBarRightButtonItemType]) {
        // 设置按钮标题
        [self setupNavigationBarRightButtonItemTitle];
        // 创建按钮控件
        self.navigationBarRightButtonItem = [self createNavigationBarRightButtonItem];
        if (self.navigationBarRightButtonItem) {
            // 调整控件位置
            CGRect frame = CGRectMake(SCREEN_WIDTH - NAVIGATION_BAR_SCREEN_MARGIN - self.navigationBarRightButtonItem.frame.size.width,
                                      self.navigationBarRightButtonItem.frame.origin.y,
                                      self.navigationBarRightButtonItem.frame.size.width,
                                      self.navigationBarRightButtonItem.frame.size.height);
            [self.navigationBarRightButtonItem setFrame:frame];
            [self.navigationBarCustomView addSubview:self.navigationBarRightButtonItem];
            
            // 验证是否为UIControl
            if ([self.navigationBarRightButtonItem isKindOfClass:[UIControl class]]) {
                [(UIControl *)self.navigationBarRightButtonItem addTarget:self
                                                                   action:@selector(pressNavigationBarRightButtonItem:)
                                                         forControlEvents:UIControlEventTouchUpInside];
            } else {
                //
                
            }
            
        }
    }
    
    
    // 标题区域
    {
        CGFloat maxWidth = MAX(CGRectGetWidth(self.navigationBarLeftButtonItem.frame) , CGRectGetWidth(self.navigationBarRightButtonItem.frame));
        CGRect titleRect = CGRectMake(NAVIGATION_BAR_SCREEN_MARGIN+maxWidth, 0, SCREEN_WIDTH - 2*(NAVIGATION_BAR_SCREEN_MARGIN + maxWidth), NAVIGATION_BAR_HEIGHT);
        UIView *titleContainerView = [[UIView alloc] initWithFrame:titleRect];
        [self setNavigationBarTitleView:titleContainerView];
        [self.navigationBarCustomView addSubview:titleContainerView];
        
        // 导航条标题视图配置
        [self setupNavigationBarTitleViewTitle];
        [self createNavigationBarTitleView:self.navigationBarTitleView];
    }
    
}


#pragma mark 设置导航栏背景色
- (void)setupNavigationBarBackgroundColor
{
    // 导航栏类型
    switch ([self setupNavigationBarType]) {
            // 默认系统导航栏
        case YHSNavBarTypeDefaultNaviBarView: {
            [self setupNavigationBarBackgroundColorDefault];
            break;
        }
            // 自定义导航栏（隐藏系统导航栏，自定义导航栏）
        case YHSNavBarTypeCustomNaviBarView: {
            // 设置自定义导航条背景色
            [self.navigationBarCustomView setBackgroundColor:[self setupNavigationBarColor]];
            break;
        }
        default: {
            break;
        }
    }

}


#pragma mark 设置导航栏背景色（默认系统导航栏）
- (void)setupNavigationBarBackgroundColorDefault
{
    // 是否强制使用图片设置导航条背景
    if (![self setupNavigationBarBackgroundImageForce]) {
        
        // 方法一：设置导航条背景（颜色）
        if ([self setupNavigationBarColor]) {
            // 设置是否有透明度(默认导航条是有透明度的)
            [self.navigationController.navigationBar setTranslucent:NO];
            // 设置导航条的颜色，这个改变的是导航条的背景色
            [self.navigationController.navigationBar setBarTintColor:[self setupNavigationBarColor]];
        }
        
    } else {
        
        // 方法二：设置导航条背景（图片）
        if ([self setupNavigationBarBackgroundImage]) {
            // 如果设置了navigationBar的setBackgroundImage:forBarMetrics:接口，那么上面的setBarTintColor接口就不能改变statusBar的背景色，statusBar的背景色就会变成纯黑色
            [self.navigationController.navigationBar setBackgroundImage:[self setupNavigationBarBackgroundImage]
                                                         forBarPosition:UIBarPositionAny
                                                             barMetrics:UIBarMetricsDefault];
        }
        
    }
    
    // 设置状态栏颜色（如果状态栏与导航条颜色不一样，则自定一个状态栏背景视图）
    if (![[self setupNavigationBarColor] isEqual:[self setupStatusBarColor]]) {
        
        // 隐藏导航条、不隐藏状态栏、导航条为空
        if (!self.naviStatusBarCustomView && ![self prefersStatusBarHidden] ) {
            
            // 显示导航条+状态栏父容器大小
            CGRect naviStatusBarFrame = CGRectMake(0, -STATUS_BAR_HEIGHT, SCREEN_WIDTH, STATUS_BAR_HEIGHT);
            
            // 显示导航条容器大小
            CGRect navigationBarFrame = CGRectMake(0, 0, SCREEN_WIDTH, 0);
            
            // 导航栏+状态栏容器
            UIView *naviStatusBarCustomView = ({
                UIView *view = [[UIView alloc] initWithFrame:naviStatusBarFrame];
                [view setTag:STATUS_NAVIGATION_BAR_TAG];
                [view setBackgroundColor:[self setupStatusBarColor]];
                [self.navigationController.navigationBar addSubview:view];
                
                view;
            });
            self.naviStatusBarCustomView = naviStatusBarCustomView;
            
            // 自定义导航条视图
            UIView *navigationBarCustomView = ({
                UIView *view = [[UIView alloc] initWithFrame:navigationBarFrame];
                [view setBackgroundColor:[self setupNavigationBarColor]];
                [naviStatusBarCustomView addSubview:view];
                
                view;
            });
            self.navigationBarCustomView = navigationBarCustomView;
            
            // 底部发丝线
            UIView *navigationBarHairlineImageView = ({
                UIView *view = [[UIView alloc] init];
                [view setFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT-NAVIGATION_BAR_HAIR_LINE_HEIGHT, SCREEN_WIDTH, NAVIGATION_BAR_HAIR_LINE_HEIGHT)];
                [view setBackgroundColor:NAVIGATION_BAR_HAIR_LINE_COLOR];
                [navigationBarCustomView addSubview:view];
                
                view;
            });
            self.navigationBarHairlineImageView = navigationBarHairlineImageView;
            
        } else {
            
            [self.naviStatusBarCustomView setBackgroundColor:[self setupStatusBarColor]];
            
        }
        
    } else {
        
        // 导航栏+状态栏容器（因为导航条是高度集成的，此容器可能在父类的导航条中进行了设置）
        [self.navigationController.navigationBar.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (view.tag == STATUS_NAVIGATION_BAR_TAG) {
                [view setBackgroundColor:[self setupStatusBarColor]];
                *stop = YES;
            }
            
        }];
        
    }
    
}


#pragma mark 找出导航栏底部横线
- (UIImageView *)findNavigationBarHairlineImageView:(UIView *)view
{
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findNavigationBarHairlineImageView:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}


#pragma mark 释放资源
- (void)dealloc
{
    _navigationBarCustomView = nil;
    _navigationBarHairlineImageView = nil;
    _navigationBarTitleView = nil;
    _navigationBarTitleViewTitle = nil;
    _navigationBarLeftButtonItem = nil;
    _navigationBarLeftButtonItemTitle = nil;
    _navigationBarRightButtonItem = nil;
    _navigationBarRightButtonItemTitle = nil;
}


@end




