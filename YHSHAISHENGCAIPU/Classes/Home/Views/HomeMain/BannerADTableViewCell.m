//
//  BannerADTableViewCell.m
//  YHSHAISHENGCAIPU
//
//  Created by YANGHAISHENG on 2017/2/22.
//  Copyright © 2017年 YANGHAISHENG. All rights reserved.
//

#import "BannerADTableViewCell.h"
#import "BannerADModel.h"


CGFloat const SCROLL_AD_HEIGHT = 200.0;

// Cell Identifier
NSString * const CELL_IDENTIFIER_BANNER_AD = @"BannerADTableViewCellID";


@interface BannerADTableViewCell () <SDCycleScrollViewDelegate>

/**
 * 根容器组件
 */
@property (nonnull, nonatomic, strong) UIView *rootContainerView;

/**
 * 公共容器组件
 */
@property (nonnull, nonatomic, strong) UIView *publicContainerView;

/**
 * 广告栏
 */
@property (nonatomic, strong) SDCycleScrollView *cycleBannerADView;
@property (nonatomic, strong) UILabel *cycleBannerTitleLabel;
@property (nonatomic, strong) NSMutableArray<NSString *> *cycleBannerTitleArray;

@end


@implementation BannerADTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createViewAtuoLayout];
    }
    return self;
}


#pragma make 创建子控件
- (void) createViewAtuoLayout
{
    WEAKSELF(weakSelf);
    
    // 根容器组件
    self.rootContainerView = ({
        UIView *view = [[UIView alloc] init];
        [self.contentView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.bottom.equalTo(weakSelf.contentView.mas_bottom).with.offset(0);
        }];
        
        view;
    });
    self.rootContainerView.mas_key = @"rootContainerView";
    
    
    // 公共容器组件
    self.publicContainerView = ({
        UIView *view = [[UIView alloc] init];
        [view.layer setMasksToBounds:YES];
        [self.rootContainerView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.bottom.equalTo(weakSelf.rootContainerView.mas_bottom).offset(0);
        }];
        
        view;
    });
    self.publicContainerView.mas_key = @"publicContainerView";
    
}


#pragma mark - 设置数据模型
- (void)setModel:(NSArray<BannerADModel *> *)model
{
    _model = model;
    
    if (!model || model.count == 0) {
        return;
    }
    
    // Cell复用机制会出现阴影
    for(UIView *view in self.publicContainerView.subviews) {
        [view removeFromSuperview];
    }
    
    
    WEAKSELF(weakSelf);
    
    
    // 广告数据信息
    NSMutableArray<NSString *> *titleArray = [NSMutableArray array];
    NSMutableArray<NSString *> *imageUrlArray = [NSMutableArray array];
    [_model enumerateObjectsUsingBlock:^(BannerADModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [titleArray addObject:obj.Title];
        [imageUrlArray addObject:obj.Img];
    }];
    [self setCycleBannerTitleArray:titleArray];
    
    
    // 滚动广告栏
    SDCycleScrollView *cycleBannerADView = [[SDCycleScrollView alloc] init];
    [cycleBannerADView setDelegate:self];
    [cycleBannerADView setAutoScrollTimeInterval:6.0];
    [cycleBannerADView setPageControlStyle:SDCycleScrollViewPageContolStyleClassic];
    [cycleBannerADView setPageDotColor:[UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.00]];
    [cycleBannerADView setCurrentPageDotColor:[UIColor colorWithRed:0.49 green:0.71 blue:0.27 alpha:1.00]];
    [cycleBannerADView setImageURLStringsGroup:imageUrlArray];
    [self.publicContainerView addSubview:cycleBannerADView];
    [cycleBannerADView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@(SCROLL_AD_HEIGHT));
    }];
    self.cycleBannerADView = cycleBannerADView;
    
    
    // 公共容器组件
    [self.publicContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.cycleBannerADView.mas_bottom);
    }];
    
    
    // 透明标题
    UILabel *cycleBannerTitleLabel = ({
        UILabel *label = [[UILabel alloc] init];
        [cycleBannerADView addSubview:label];
        [label setText:titleArray[0]];
        [label setTextColor:[UIColor whiteColor]];
        [label setFont:[UIFont systemFontOfSize:12]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label.layer setCornerRadius:8.0];
        [label.layer setMasksToBounds:YES];
        [label setBackgroundColor:[UIColor colorWithRed:0.96 green:0.04 blue:0.02 alpha:0.70]];
        
        // 计算文字宽高
        CGFloat titleWidth = 25;
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
        CGSize size = [titleArray[0] boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                                  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                               attributes:attributes
                                                  context:nil].size;
        titleWidth += size.width;
        
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cycleBannerADView.mas_bottom).offset(-45);
            make.centerX.equalTo(cycleBannerADView.mas_centerX).offset(0);
            make.bottom.equalTo(cycleBannerADView.mas_bottom).offset(-25);
            make.width.greaterThanOrEqualTo(@(titleWidth));
        }];
        
        
        label;
    });
    self.cycleBannerTitleLabel = cycleBannerTitleLabel;
    
}


#pragma mark - 触发操作事件
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    YHSDEBUGLog(@"%@", self.model[index].Title);
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectRowAtBannerADModel:)]) {
        [self.delegate didSelectRowAtBannerADModel:self.model[index]];
    }
}


/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
{
    // 广告栏透明标题
    if (self.cycleBannerTitleArray.count >= index) {
        
        self.cycleBannerTitleLabel.text = self.cycleBannerTitleArray[index];
        
        // 计算文字宽高
        CGFloat titleWidth = 15;
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:12]};
        CGSize size = [self.cycleBannerTitleArray[index] boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                                                      options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                                   attributes:attributes
                                                                      context:nil].size;
        titleWidth += size.width;
        
        [self.cycleBannerTitleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.greaterThanOrEqualTo(@(titleWidth));
        }];
        
    }
    
}



@end



