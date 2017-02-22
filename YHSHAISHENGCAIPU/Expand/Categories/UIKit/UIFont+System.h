//
//  UIFont+System.h
//  YHSCategories
//
//  Created by YANGHAISHENG on 2016/11/29.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
Complementary methods to add missing system fonts to UIFont API.
 */
@interface UIFont (System)

/*
 * Returns the font object used for standard interface items that are rendered in boldface and italic type in the specified size.
 *
 * @param size The size (in points) to which the font is scaled. This value must be greater than 0.0.
 * @returns A font object of the specified size.
 */
+ (UIFont *)boldItalicSystemFontOfSize:(CGFloat)size;

/*
 * Returns the font object used for standard interface items that are rendered in medium boldface type in the specified size.
 *
 * @param size The size (in points) to which the font is scaled. This value must be greater than 0.0.
 * @returns A font object of the specified size.
 */
+ (UIFont *)mediumSystemFontOfSize:(CGFloat)size;

/*
 * Returns the font object used for standard interface items that are rendered in lightface type in the specified size.
 *
 * @param size The size (in points) to which the font is scaled. This value must be greater than 0.0.
 * @returns A font object of the specified size.
 */
+ (UIFont *)lightSystemFontOfSize:(CGFloat)size;

/*
 * Returns the font object used for standard interface items that are rendered in lightface & italic type in the specified size.
 *
 * @param size The size (in points) to which the font is scaled. This value must be greater than 0.0.
 * @returns A font object of the specified size.
 */
+ (UIFont *)lightItalicSystemFontOfSize:(CGFloat)size;

/*
 * Returns the font object used for standard interface items that are rendered in ultra lightface type in the specified size.
 *
 * @param size The size (in points) to which the font is scaled. This value must be greater than 0.0.
 * @returns A font object of the specified size.
 */
+ (UIFont *)ultraLightSystemFontOfSize:(CGFloat)size;

/*
 * Returns the font object used for standard interface items that are rendered in thinface type in the specified size.
 *
 * @param size The size (in points) to which the font is scaled. This value must be greater than 0.0.
 * @returns A font object of the specified size.
 */
+ (UIFont *)thinSystemFontOfSize:(CGFloat)size;

/*
 * Returns an unloaded font with size.
 *
 * @param size The size (in points) to which the font is scaled. This value must be greater than 0.0.
 * @returns A font object of the specified size.
 */
+ (UIFont *)loadFontWithName:(NSString *)fontName size:(CGFloat)size;

@end
