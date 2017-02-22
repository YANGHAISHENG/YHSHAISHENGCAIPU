//
//  MKMapView+Region.h
//  DZNCategories
//
//  Created by Ignacio Romero Zurbuchen on 4/18/13.
//  Copyright (c) 2013 DZN Labs. All rights reserved.
//  Licence: MIT-Licence
//  http://opensource.org/licenses/MIT
//

#import <MapKit/MapKit.h>

@interface MKMapView (Region)

- (BOOL)isValidRegion:(MKCoordinateRegion)region;

- (MKCoordinateRegion)regionFromOrigin:(CLLocationCoordinate2D)origin toDestination:(CLLocationCoordinate2D)destination withTolerance:(CGFloat)tolerance;

- (MKCoordinateRegion)regionFromOrigin:(CLLocationCoordinate2D)origin toDestination:(CLLocationCoordinate2D)destination;

- (MKCoordinateRegion)regionFromUserLocation;

- (MKCoordinateRegion)regionFromLocation:(CLLocationCoordinate2D)coordinate;

- (MKCoordinateRegion)regionForAnnotations;

- (MKCoordinateRegion)regionForAnnotationsWithPadding:(CGFloat)padding;

@end
