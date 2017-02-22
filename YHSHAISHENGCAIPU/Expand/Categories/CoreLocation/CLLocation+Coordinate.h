//
//  CLLocation+Coordinate.h
//  DZNCategories
//
//  Created by Ignacio Romero Zurbuchen on 4/18/13.
//  Copyright (c) 2013 DZN Labs. All rights reserved.
//  Licence: MIT-Licence
//  http://opensource.org/licenses/MIT
//

#import <CoreLocation/CoreLocation.h>
#include <math.h>

static const double kDegreesToRadians = M_PI / 180.0;
static const double kRadiansToDegrees = 180.0 / M_PI;

@interface CLLocation (Coordinate)

typedef struct {
	CLLocationCoordinate2D bottomLeft;
	CLLocationCoordinate2D topRight;
} CLLocationCoordinateRect;

typedef enum CLLocationCoordinateRectPreset {
    CLLocationCoordinateRectPresetEmpty = 0,
    CLLocationCoordinateRectPresetWorld,
    CLLocationCoordinateRectPresetSanFransisco,
    CLLocationCoordinateRectPresetNewYork,
    CLLocationCoordinateRectPresetSantiago
} CLLocationCoordinateRectPreset;


/*
 Return true if 'coord' is empty (that is, if it has zero values for latitude and longitude),
 Return false otherwise. A null coordinate is defined to be empty.
*/
bool CLLocationCoordinateIsEmpty(CLLocationCoordinate2D coord);

/*
 
*/
bool CLLocationCoordinate2DAreEqual(CLLocationCoordinate2D coord1, CLLocationCoordinate2D coord2);

/*
 
*/
bool CLLocationCoordinate2DAreEqual(CLLocationCoordinate2D coord1, CLLocationCoordinate2D coord2);

/*
 
*/
NSString *NSStringFromCLLocationCoordinate(CLLocationCoordinate2D coord);

/*
 Returns true if 'rect' is empty (that is, if it has zero values for topLeft and bottomRight coordinates),
 Returns false otherwise. A null rect is defined to be empty.
*/
bool CLLocationCoordinateRectIsEmpty(CLLocationCoordinateRect rect);

/*

*/
NSString *NSStringFromCLLocationCoordinateRect(CLLocationCoordinateRect rect);

/*
 
*/
CLLocationCoordinateRect CLLocationCoordinateRectMake(CLLocationCoordinate2D topLeft, CLLocationCoordinate2D bottomRight);

/*
 
*/
CLLocationCoordinateRect CLLocationCoordinateRectWithPreset(CLLocationCoordinateRectPreset preset);

/*
 
*/
CLLocationCoordinateRect CLLocationCoordinateRectFromCenter(CLLocationCoordinate2D center, CLLocationDistance radius);


@end
