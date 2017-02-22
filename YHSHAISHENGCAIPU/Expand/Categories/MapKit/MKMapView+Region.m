//
//  MKMapView+Region.m
//  DZNCategories
//
//  Created by Ignacio Romero Zurbuchen on 4/18/13.
//  Copyright (c) 2013 DZN Labs. All rights reserved.
//  Licence: MIT-Licence
//  http://opensource.org/licenses/MIT
//

#import "MKMapView+Region.h"

@implementation MKMapView (Region)

- (BOOL)isValidRegion:(MKCoordinateRegion)region
{
    if (region.center.latitude > 90.0f || region.center.latitude < -90.0f ||
        region.center.longitude > 360.0f || region.center.longitude < -180.0f) {
        
        return YES;
    }
    else return NO;
}

- (MKCoordinateRegion)regionFromOrigin:(CLLocationCoordinate2D)origin toDestination:(CLLocationCoordinate2D)destination withTolerance:(CGFloat)tolerance
{
    CLLocationCoordinate2D _origin = origin;
    CLLocationCoordinate2D _destination = destination;
    
    _destination.latitude = MAX(_destination.latitude, destination.latitude);
    _destination.longitude = MAX(_destination.longitude, destination.longitude);
    
    _origin.latitude = MIN(_origin.latitude, origin.latitude);
    _origin.longitude = MIN(_origin.longitude, origin.longitude);
    
    MKCoordinateRegion region;
    region.span.latitudeDelta = fabs(_destination.latitude - _origin.latitude) * tolerance;
    region.span.longitudeDelta = fabs(_origin.longitude - _destination.longitude) * tolerance;
    region.center.latitude = _destination.latitude - (_destination.latitude - _origin.latitude) * 0.5;
    region.center.longitude = _destination.longitude + (_origin.longitude - _destination.longitude) * 0.5;
    
    return [self regionThatFits:region];
}

- (MKCoordinateRegion)regionFromOrigin:(CLLocationCoordinate2D)origin toDestination:(CLLocationCoordinate2D)destination
{
    return [self regionFromOrigin:origin toDestination:destination withTolerance:1.2];
}

- (MKCoordinateRegion)regionFromUserLocation
{
    return [self regionFromLocation:self.userLocation.coordinate];
}

- (MKCoordinateRegion)regionFromLocation:(CLLocationCoordinate2D)coordinate
{
    MKCoordinateRegion region = [self region];
    region.center = coordinate;
    return region;
}

- (MKCoordinateRegion)regionForAnnotations
{
    return [self regionForAnnotationsWithPadding:0];
}

- (MKCoordinateRegion)regionForAnnotationsWithPadding:(CGFloat)padding
{
    CLLocationDegrees minLat = 90.0;
    CLLocationDegrees maxLat = -90.0;
    CLLocationDegrees minLon = 180.0;
    CLLocationDegrees maxLon = -180.0;
    
    for (id <MKAnnotation> annotation in self.annotations) {
        if (annotation.coordinate.latitude < minLat) {
            minLat = annotation.coordinate.latitude;
        }
        if (annotation.coordinate.longitude < minLon) {
            minLon = annotation.coordinate.longitude;
        }
        if (annotation.coordinate.latitude > maxLat) {
            maxLat = annotation.coordinate.latitude;
        }
        if (annotation.coordinate.longitude > maxLon) {
            maxLon = annotation.coordinate.longitude;
        }
    }
    
    MKCoordinateSpan span = MKCoordinateSpanMake((maxLat - minLat)+padding*2, (maxLon - minLon)+padding*2);
    
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(((maxLat - span.latitudeDelta / 2))+padding, (maxLon - span.longitudeDelta / 2)+padding);
    
    return MKCoordinateRegionMake(center, span);
}

@end
