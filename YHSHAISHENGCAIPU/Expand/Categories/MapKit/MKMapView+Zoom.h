//
//  MKMapView+Zoom.h
//  DZNCategories
//
//  Created by Ignacio Romero Zurbuchen on 11/05/13.
//  Copyright (c) 2013 DZN Labs. All rights reserved.
//  Licence: MIT-Licence
//  http://opensource.org/licenses/MIT
//

#import <MapKit/MapKit.h>

@interface MKMapView (Zoom)

/* The current zoom level of the map.
 Based on Troy's Blog article on http://troybrant.net/blog/2010/01/set-the-zoom-level-of-an-mkmapview/ */
@property (nonatomic, readonly) NSUInteger zoomLevel;

@end
