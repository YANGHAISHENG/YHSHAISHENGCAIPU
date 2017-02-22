//
//  YHSBaseTableRefreshViewController+EmptyDataSet.m
//  YHSHAISHENGCAIPU
//
//  Created by YANGHAISHENG on 2017/2/22.
//  Copyright © 2017年 YANGHAISHENG. All rights reserved.
//

#import "YHSBaseTableRefreshViewController+EmptyDataSet.h"

@implementation YHSBaseTableRefreshViewController (EmptyDataSet)


#pragma mark - DZNEmptyDataSetSource Methods


- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    YHSDEBUGLog(@"%s", __FUNCTION__);
    
    NSString *text = @"没有查找到相关数据";
    
    NSDictionary *attributes = @{ NSFontAttributeName : [UIFont systemFontOfSize:[YHSAutoresizeUtil getAutosizeFontSize:16.0]],
                                  NSForegroundColorAttributeName : [UIColor colorWithRed:0.78 green:0.78 blue:0.78 alpha:1.00]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}


- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    YHSDEBUGLog(@"%s", __FUNCTION__);
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSString *text = @"";
    NSDictionary *attributes = @{ NSFontAttributeName: [UIFont systemFontOfSize:[YHSAutoresizeUtil getAutosizeFontSize:16.0]],
                                  NSForegroundColorAttributeName:[UIColor colorWithRed:0.78 green:0.78 blue:0.78 alpha:1.00],
                                  NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}


- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"empty_search_result"];
}


- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return -[YHSAutoresizeUtil getAutosizeViewHeight:50.0f];
}


- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor whiteColor];
}


#pragma mark - DZNEmptyDataSetDelegate Methods

#pragma mark 是否显示空白页，默认YES
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return self.isEmptyDataSetShouldDisplay;
}


#pragma mark 是否允许滚动，默认NO
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return self.isEmptyDataSetShouldAllowScroll;
}


#pragma mark 图片是否要动画效果，默认NO
- (BOOL) emptyDataSetShouldAllowImageViewAnimate:(UIScrollView *)scrollView {
    return self.isEmptyDataSetShouldAllowImageViewAnimate;
}



@end




