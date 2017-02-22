//
//  UIScrollView+Scroll.h
//  YHSCategories
//
//  Created by YANGHAISHENG on 2016/11/29.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UIScrollViewDirection) {
    UIScrollViewDirectionNone,
    UIScrollViewDirectionTop,
    UIScrollViewDirectionBottom,
    UIScrollViewDirectionRight,
    UIScrollViewDirectionLeft
};

@interface UIScrollView (Scroll)

- (void)scrollToTopAnimated:(BOOL)animated;

- (void)scrollToBottomAnimated:(BOOL)animated;

- (BOOL)isOnTop;

- (BOOL)isOnBottom;

@end
