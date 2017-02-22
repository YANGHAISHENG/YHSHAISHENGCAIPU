//
//  MKMapView+Zoom.m
//  DZNCategories
//
//  Created by Ignacio Romero Zurbuchen on 11/05/13.
//  Copyright (c) 2013 DZN Labs. All rights reserved.
//  Licence: MIT-Licence
//  http://opensource.org/licenses/MIT
//

#import "MKMapView+Zoom.h"

#define MERCATOR_OFFSET 268435456
#define MERCATOR_RADIUS 85445659.44705395
#define MAX_LEVELS 20

@implementation MKMapView (Zoom)

+ (double)longitudeToPixelSpaceX:(double)longitude
{
    return round(MERCATOR_OFFSET + MERCATOR_RADIUS * longitude * M_PI / 180.0);
}

+ (double)latitudeToPixelSpaceY:(double)latitude
{
    if (latitude == 90.0) {
        return 0;
    } else if (latitude == -90.0) {
        return MERCATOR_OFFSET * 2;
    } else {
        return round(MERCATOR_OFFSET - MERCATOR_RADIUS * logf((1 + sinf(latitude * M_PI / 180.0)) / (1 - sinf(latitude * M_PI / 180.0))) / 2.0);
    }
}

- (NSUInteger)zoomLevel
{
    MKCoordinateRegion region = self.region;
    
    double centerPixelX = [MKMapView longitudeToPixelSpaceX:region.center.longitude];
    double topLeftPixelX = [MKMapView longitudeToPixelSpaceX:region.center.longitude - region.span.longitudeDelta / 2];
    double scaledMapWidth = (centerPixelX - topLeftPixelX);
    
    CGSize mapSizeInPixels = self.bounds.size;
    double zoomScale = scaledMapWidth / mapSizeInPixels.width;
    double zoomExponent = log(zoomScale) / log(2);
    NSUInteger zoomLevel = (NSUInteger)(MAX_LEVELS - zoomExponent) + 2;

    return zoomLevel;
}

@end
