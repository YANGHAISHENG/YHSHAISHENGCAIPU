//
//  UITextField+Behaviour.h
//  YHSCategories
//
//  Created by YANGHAISHENG on 2016/11/29.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Behaviour)

/*
 * Replaces the lower case strings by uppercase on the fly.
 * To be used on UITextFieldDelegate method textField:shouldChangeCharactersInRange:replacementString:
 *
 * @param range The range of characters to be replaced
 * @param string The replacement string.
 */
- (void)shouldCapitalizeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

@end
