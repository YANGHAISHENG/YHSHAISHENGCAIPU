//
//  UIView+AutoLayout.h
//  YHSCategories
//
//  Created by YANGHAISHENG on 2016/11/29.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AutoLayout)

// Center alignment to superview
- (void)alignCenterToSuperview;

// Top alignments to superview
- (void)alignTopLeftToSuperview;
- (void)alignTopRightToSuperview;

// Bottom alignments to superview
- (void)alignBottomLeftToSuperview;
- (void)alignBottomRightToSuperview;

// Custom alignments to superview
- (void)alignToSuperviewWithAxes:(NSLayoutFormatOptions)axes;

@end
