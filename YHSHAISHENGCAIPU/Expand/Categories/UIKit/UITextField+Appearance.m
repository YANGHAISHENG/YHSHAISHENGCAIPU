//
//  UITextField+Appearance.m
//  YHSCategories
//
//  Created by YANGHAISHENG on 2016/11/29.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "UITextField+Appearance.h"

@implementation UITextField (Appearance)


- (void)setPlaceholderColor:(UIColor *)color
{
    [self setValue:color forKeyPath:@"_placeholderLabel.textColor"];
}

- (UIColor *)placeholderColor
{
    return [self valueForKey:@"_placeholderLabel.textColor"];
}


- (void)setPlaceholderFont:(UIFont *)font
{
    [self setValue:font forKeyPath:@"_placeholderLabel.font"];
}

- (UIFont *)placeholderFont
{
    return [self valueForKey:@"_placeholderLabel.font"];
}

@end
