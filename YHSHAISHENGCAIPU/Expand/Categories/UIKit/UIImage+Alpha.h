//
//  UIImage+Alpha.h
//  YHSCategories
//
//  Created by YANGHAISHENG on 2016/11/29.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 * Set of methods to manage alpha channels in UIImage objects.
 */
@interface UIImage (Alpha)

/*
 * Checks if the image as an alpha channel.
 */
- (BOOL)hasAlpha;

/*
 * Removes the alpha channel completly.
 *
 * @returns A new non-transparent image.
 */
- (UIImage *)removeAlpha;

/*
 * Fills the alpha channel with white color.
 *
 * @returns A new alpha-filled image.
 */
- (UIImage *)fillAlpha;

/*
 * Fills the alpha channel with a custom color.
 *
 * @param color The custom color of the alpha channel
 * @returns A new alpha-filled image.
 */
- (UIImage *)fillAlphaWithColor:(UIColor *)color;

@end
