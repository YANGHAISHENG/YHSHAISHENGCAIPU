//
//  UIImage+Effect.h
//  YHSCategories
//
//  Created by YANGHAISHENG on 2016/11/29.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 * Special effects to be applied to UIImage objects.
 */
@interface UIImage (Effect)

/*
 */
- (UIImage *)imageWithMask:(UIImage *)maskImg;

/*
 */
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;

/*
 */
+ (UIImage *)imageWithColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius;

/*
 */
- (UIImage *)coloredImage:(UIColor *)color;

/*
 * Transforms the image to grayscale.
 *
 * @returns The new grayscale image.
 */
- (UIImage *)imageToGrayscale;

/*
 */
- (UIImage *)circular;

/*
 */
- (UIImage *)circularWithBorderColor:(UIColor *)color andBorderWidth:(CGFloat)width;

/*
 */
- (UIImage *)circularWithOutterBorderColor:(UIColor *)color andBorderWidth:(CGFloat)width;


@end
