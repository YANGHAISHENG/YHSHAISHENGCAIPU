//
//  UIImage+Frame.h
//  YHSCategories
//
//  Created by YANGHAISHENG on 2016/11/29.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 * Easier way to retrieve your app's screenshot based the device type & orientation.
 */
@interface UIImage (Splash)

/*
 * Returns the appropriate splash image based on the device type
 *
 * @returns A the original splash screen image.
 */
+ (UIImage *)splashImage;

/*
 * Returns the appropriate splash image based on the device type and orientation.
 *
 * @param orientation The orientation of the device.
 * @returns A the original splash screen image.
 */
+ (UIImage *)splashImageForInterfaceOrientation:(UIInterfaceOrientation)orientation;

@end
