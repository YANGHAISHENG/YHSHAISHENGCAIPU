//
//  NSManagedObjectContext+Management.m
//  DZNCategories
//
//  Created by Ignacio Romero Zurbuchen on 8/24/13.
//  Copyright (c) 2013 DZN Labs. All rights reserved.
//

#import "NSManagedObjectContext+Management.h"

@implementation NSManagedObjectContext (Management)

- (void)purgeAllObjects
{
    NSManagedObjectModel *model = [[self persistentStoreCoordinator] managedObjectModel];
    for (NSEntityDescription *entity in [model entities]) {
        [self purgeAllObjectsForEntity:entity];
    }
}

- (void)purgeAllObjectsForEntityName:(NSString *)entityName
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:self];
    [self purgeAllObjectsForEntity:entity];
}

- (void)purgeAllObjectsForEntity:(NSEntityDescription *)entity
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *items = [self executeFetchRequest:fetchRequest error:&error];
    
    for (NSManagedObject *managedObject in items) {
    	[self deleteObject:managedObject];
    	NSLog(@"%@ object deleted", entity.name);
    }
    if (![self save:&error]) {
    	NSLog(@"Error deleting %@ - error:%@", entity.name,error);
    }
}

@end
