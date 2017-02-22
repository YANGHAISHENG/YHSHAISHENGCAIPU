//
//  UITextField+Behaviour.m
//  YHSCategories
//
//  Created by YANGHAISHENG on 2016/11/29.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "UITextField+Behaviour.h"

@implementation UITextField (Behaviour)

- (void)shouldCapitalizeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    UITextPosition *beginning = self.beginningOfDocument;
    UITextPosition *start = [self positionFromPosition:beginning offset:range.location];
    UITextPosition *end = [self positionFromPosition:start offset:range.length];
    UITextRange *textRange = [self textRangeFromPosition:start toPosition:end];

    [self replaceRange:textRange withText:[string uppercaseString]];
}

@end
