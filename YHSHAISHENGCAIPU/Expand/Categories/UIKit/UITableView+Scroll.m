//
//  UITableView+Scroll.m
//  YHSCategories
//
//  Created by YANGHAISHENG on 2016/11/29.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "UITableView+Scroll.h"

@implementation UITableView (Scroll)

- (void)scrollTableToTopAnimated:(BOOL)animated
{
    [self scrollToRowAtIndexPath:[self firstIndexPath] atScrollPosition:UITableViewScrollPositionTop animated:animated];
}

- (void)scrollTableToBottomAnimated:(BOOL)animated
{
    [self scrollToRowAtIndexPath:[self lastIndexPath] atScrollPosition:UITableViewScrollPositionTop animated:animated];
}

- (NSIndexPath *)firstIndexPath
{
    return [NSIndexPath indexPathForRow:0 inSection:0];
}

- (NSIndexPath *)lastIndexPath
{
    NSInteger lastSection = [self.dataSource numberOfSectionsInTableView:self]-1;
    NSInteger lastRow = [self.dataSource tableView:self numberOfRowsInSection:lastSection]-1;
    
    if (lastSection < 0) lastSection = 0;
    if (lastRow < 0) lastRow = 0;
    
    return [NSIndexPath indexPathForRow:lastRow inSection:lastSection];
}

@end
