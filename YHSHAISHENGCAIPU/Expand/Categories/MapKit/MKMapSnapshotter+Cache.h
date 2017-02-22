//
//  MKMapSnapshotter+Cache.h
//  DZNCategories
//
//  Created by Ignacio Romero Zurbuchen on 11/05/13.
//  Copyright (c) 2013 DZN Labs. All rights reserved.
//  Licence: MIT-Licence
//  http://opensource.org/licenses/MIT
//

#import <MapKit/MapKit.h>

#if __IPHONE_7_0 || __IPHONE_7_1

typedef void (^MKMapSnapshotCachedCompletionHandler)(UIImage *snapshot, NSError *error);

@interface MKMapSnapshotter (Cache)

- (void)startCacheWithCompletionHandler:(MKMapSnapshotCachedCompletionHandler)completionHandler andOptions:(MKMapSnapshotOptions *)options;

+ (void)clearCachedImages;

@end

#endif
