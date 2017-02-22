//
//  NSManagedObjectContext+Management.h
//  DZNCategories
//
//  Created by Ignacio Romero Zurbuchen on 8/24/13.
//  Copyright (c) 2013 DZN Labs. All rights reserved.
//

#import <CoreData/CoreData.h>

/* */
@interface NSManagedObjectContext (Management)

/* */
- (void)purgeAllObjectsForEntityName:(NSString *)entityName;

/* */
- (void)purgeAllObjectsForEntity:(NSEntityDescription *)entityDescription;

/* */
- (void)purgeAllObjects;

@end
