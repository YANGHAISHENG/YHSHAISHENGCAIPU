//
//  CLLocation+Coordinate.m
//  DZNCategories
//
//  Created by Ignacio Romero Zurbuchen on 4/18/13.
//  Copyright (c) 2013 DZN Labs. All rights reserved.
//  Licence: MIT-Licence
//  http://opensource.org/licenses/MIT
//

#import "CLLocation+Coordinate.h"

@implementation CLLocation (Coordinate)

bool CLLocationCoordinateIsEmpty(CLLocationCoordinate2D coord)
{
    return CLLocationCoordinate2DAreEqual(coord, CLLocationCoordinate2DZero()) ? true : false;
}

bool CLLocationCoordinate2DAreEqual(CLLocationCoordinate2D coord1, CLLocationCoordinate2D coord2)
{
    return (coord1.latitude == coord2.latitude && coord1.longitude == coord2.longitude) ? true : false;
}

CLLocationCoordinate2D CLLocationCoordinate2DZero()
{
    return CLLocationCoordinate2DMake(0, 0);
}

NSString *NSStringFromCLLocationCoordinate(CLLocationCoordinate2D coord)
{
    return [NSString stringWithFormat:@"%f,%f",coord.latitude,coord.longitude];
}

bool CLLocationCoordinateRectIsEmpty(CLLocationCoordinateRect rect)
{
    return (rect.bottomLeft.latitude == 0 && rect.bottomLeft.longitude == 0 &&
            rect.topRight.latitude == 0 && rect.topRight.longitude == 0) ? true : false;
}

NSString *NSStringFromCLLocationCoordinateRect(CLLocationCoordinateRect rect)
{
    return [NSString stringWithFormat:@"%@,%@", NSStringFromCLLocationCoordinate(rect.bottomLeft), NSStringFromCLLocationCoordinate(rect.topRight)];
}

CLLocationCoordinateRect CLLocationCoordinateRectMake(CLLocationCoordinate2D bottomLeft, CLLocationCoordinate2D topRight)
{
    CLLocationCoordinateRect rect;
    
    rect.bottomLeft.latitude = bottomLeft.latitude;
	rect.bottomLeft.longitude = bottomLeft.longitude;
    
    rect.topRight.latitude = topRight.latitude;
	rect.topRight.longitude = topRight.longitude;
    
    return rect;
}

CLLocationCoordinateRect CLLocationCoordinateRectWithPreset(CLLocationCoordinateRectPreset preset)
{
    switch (preset) {
            
        case CLLocationCoordinateRectPresetWorld:
            return CLLocationCoordinateRectMake(CLLocationCoordinate2DMake(-180, -90), CLLocationCoordinate2DMake(180, 90));
            break;
            
        case CLLocationCoordinateRectPresetSanFransisco:
            return CLLocationCoordinateRectMake(CLLocationCoordinate2DMake(-122.75, 36.8), CLLocationCoordinate2DMake(-121.75, 37.8));
            break;
            
        case CLLocationCoordinateRectPresetNewYork:
            return CLLocationCoordinateRectMake(CLLocationCoordinate2DMake(-74, 40), CLLocationCoordinate2DMake(-73, 41));
            break;
        
        case CLLocationCoordinateRectPresetSantiago:
            return CLLocationCoordinateRectMake(CLLocationCoordinate2DMake(-70.8, -33.6), CLLocationCoordinate2DMake(-70.5, -33.3));
            break;
            
        default:
            return CLLocationCoordinateRectMake(CLLocationCoordinate2DMake(0, 0), CLLocationCoordinate2DMake(0, 0));
            break;
    }
}

//TODO: Fix because it doesn't really work...
CLLocationCoordinateRect CLLocationCoordinateRectFromCenter(CLLocationCoordinate2D center, CLLocationDistance radius)
{
    CLLocationCoordinateRect result;
	double earthRadius = 6371.01 * 1000.0; //in meters
    
	// angular distance in radians on a great circle
	double radDist = radius/ earthRadius;
	double radLat = center.latitude * kDegreesToRadians;
	double radLon = center.longitude * kDegreesToRadians;
    
	double minLat = radLat - radDist;
	double maxLat = radLat + radDist;
    
	double minLon, maxLon;
	if (minLat > -M_PI/2 && maxLat < M_PI/2) {
		double deltaLon = asin(sin(radDist) / cos(radLat));
		minLon = radLon - deltaLon;
		if (minLon < -M_PI) minLon += 2 * M_PI;
		maxLon = radLon + deltaLon;
		if (maxLon > M_PI) maxLon -= 2 * M_PI;
	} else {
		// a pole is within the distance
		minLat = fmax(minLat, -M_PI/2);
		maxLat = fmin(maxLat, M_PI/2);
		minLon = -M_PI;
		maxLon = M_PI;
	}
    
	result.bottomLeft.latitude = minLat * kRadiansToDegrees;
	result.topRight.longitude = minLon  * kRadiansToDegrees;
	result.topRight.latitude = maxLat  * kRadiansToDegrees;
	result.bottomLeft.longitude = maxLon  * kRadiansToDegrees;
    
	return result;
}

@end
