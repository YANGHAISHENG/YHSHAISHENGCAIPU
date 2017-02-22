//
//  UIColor+Frame.h
//  YHSCategories
//
//  Created by YANGHAISHENG on 2016/11/29.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 * Special effects to be applied to UIColor objects.
 */
@interface UIColor (Effect)

/*
 * Returns a darker color version of current color.
 *
 * @returns A darker color.
 */
- (UIColor *)darkerColor;

/*
 * Returns a lighter color version of current color.
 *
 * @returns A light color.
 */
- (UIColor *)lighterColor;

/*
 * Returns a totally random color.
 *
 * @returns A random color.
 */
+ (UIColor *)randomColor;

@end
