//
//  NSFetchedResultsController+Safe.m
//  DZNCategories
//
//  Created by Ignacio Romero Zurbuchen on 6/28/13.
//  Copyright (c) 2013 DZN Labs. All rights reserved.
//  Licence: MIT-Licence
//  http://opensource.org/licenses/MIT
//

#import "NSFetchedResultsController+Safe.h"

@implementation NSFetchedResultsController (Safe)

- (id)safeObjectAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.fetchedObjects count] > 0)
    {
        NSInteger limit = 0;
        for (int i = 0; i < (indexPath.section+1); i++) {
            for (int j = 0; j < (indexPath.row+1); j++) {
                limit++;
            }
        }

        if (limit < [self.fetchedObjects count]) return [self objectAtIndexPath:indexPath];
        else return nil;
    }
    else return nil;
}

@end
