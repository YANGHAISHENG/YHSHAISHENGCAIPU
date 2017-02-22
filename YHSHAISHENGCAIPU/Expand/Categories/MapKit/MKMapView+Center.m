//
//  MKMapView+Center.m
//  DZNCategories
//
//  Created by Ignacio Romero Zurbuchen on 4/18/13.
//  Copyright (c) 2013 DZN Labs. All rights reserved.
//  Licence: MIT-Licence
//  http://opensource.org/licenses/MIT
//

#import "MKMapView+Center.h"
#import "MKMapView+Region.h"

@implementation MKMapView (Center)

- (void)centerMapFromOrigin:(CLLocationCoordinate2D)origin toDestination:(CLLocationCoordinate2D)destination animated:(BOOL)animated;
{
    [self setRegion:[self regionFromOrigin:origin toDestination:destination] animated:animated];
}

- (void)centerMapToUserLocationAnimated:(BOOL)animated
{
    [self setRegion:[self regionFromUserLocation] animated:animated];
}

@end
