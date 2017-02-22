//
//  MKMapSnapshotter+Cache.h
//  DZNCategories
//
//  Created by Ignacio Romero Zurbuchen on 11/05/13.
//  Copyright (c) 2013 DZN Labs. All rights reserved.
//  Licence: MIT-Licence
//  http://opensource.org/licenses/MIT
//

#import "MKMapSnapshotter+Cache.h"
#import "MKGeometry+Rect.h"
#import "CLLocation+Coordinate.h"

#if __IPHONE_7_0 || __IPHONE_7_1

static NSString *cacheFolderName = @"com.dzn.MKMapSnapshot.default";

@implementation MKMapSnapshotter (Cache)

- (void)startCacheWithCompletionHandler:(MKMapSnapshotCachedCompletionHandler)completionHandler andOptions:(MKMapSnapshotOptions *)options
{
    if (CLLocationCoordinate2DIsValid(options.region.center))
    {
        NSString *center = NSStringFromCLLocationCoordinate(options.region.center);
        NSString *span = NSStringFromMKCoordinateSpan(options.region.span);
        NSString *size = NSStringFromCGSize(options.size);
        MKMapType mapType = options.mapType;
        CGFloat scale = options.scale;
        
        BOOL directory;
        NSError *error = nil;
        
        NSString *cacheDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *cachedImagesDirectory = [cacheDirectory stringByAppendingPathComponent:cacheFolderName];
        if (![[NSFileManager defaultManager] fileExistsAtPath:cachedImagesDirectory isDirectory:&directory]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:cachedImagesDirectory withIntermediateDirectories:NO attributes:nil error:&error];
            if (error) NSLog(@"contentsOfDirectoryAtPath error : %@",error.localizedDescription);
            //NSLog(@"cachedImagesDirectory : %@",cachedImagesDirectory);
        }
        
        NSString *name = [NSString stringWithFormat:@"mapsnapshot%d_%@_%@_%@", (int)mapType,size,center,span];
        NSString *path = [cachedImagesDirectory stringByAppendingPathComponent:name];
        if (scale == 2.0) path = [path stringByAppendingString:@"@2x"];
        path = [path stringByAppendingString:@".png"];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
            [self startWithCompletionHandler:^(MKMapSnapshot *snapshot, NSError *error) {
                
                UIImage *render = nil;
                
                if (options.showsPointsOfInterest) {
                    
                    // get the image associated with the snapshot
                    UIImage *image = snapshot.image;
                    
                    // Get the size of the final image
                    CGRect finalImageRect = CGRectMake(0, 0, image.size.width, image.size.height);
                    
                    // Get a standard annotation view pin. Clearly, Apple assumes that we'll only want to draw standard annotation pins!
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
                    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:@""];
                    pin.pinColor = MKPinAnnotationColorRed;
                    UIImage *pinImage = pin.image;
#pragma clang diagnostic pop
                    
                    // ok, let's start to create our final image
                    UIGraphicsBeginImageContextWithOptions(image.size, YES, image.scale);
                    
                    // first, draw the image from the snapshotter
                    [image drawAtPoint:CGPointMake(0, 0)];
                    
                    // now, let's iterate through the annotations and draw them, too
                    CGPoint point = [snapshot pointForCoordinate:options.region.center];
                    if (CGRectContainsPoint(finalImageRect, point)) // this is too conservative, but you get the idea
                    {
                        CGPoint pinCenterOffset = pin.centerOffset;
                        point.x -= pin.bounds.size.width / 2.0;
                        point.y -= pin.bounds.size.height / 2.0;
                        point.x += pinCenterOffset.x;
                        point.y += pinCenterOffset.y;
                        
                        [pinImage drawAtPoint:point];
                    }
                    
                    // grab the final image
                    render = UIGraphicsGetImageFromCurrentImageContext();
                    UIGraphicsEndImageContext();
                }
                else {
                    render = snapshot.image;
                }
                
                if (!error) {
                    [UIImagePNGRepresentation(render) writeToFile:path atomically:YES];
                }
                completionHandler(render,error);
            }];
        }
        else {
            NSData *data = [NSData dataWithContentsOfFile:path];
            completionHandler([UIImage imageWithData:data scale:scale],nil);
        }
    }
}

+ (void)clearCachedImages
{
    NSError *error = nil;
    
    NSString *cacheDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *cachedImagesDirectory = [cacheDirectory stringByAppendingPathComponent:cacheFolderName];
    
    NSArray *contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:cachedImagesDirectory error:&error];
    if (error) {
        NSLog(@"%s contentsOfDirectoryAtPath error : %@",__FUNCTION__, error.localizedDescription);
        return;
    }
    
    for (NSString *filePath in contents) {
        
        NSString *path = [cachedImagesDirectory stringByAppendingPathComponent:filePath];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            
            [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
            if (error) NSLog(@"removeItemAtPath error : %@",error.localizedDescription);
            else NSLog(@"removed Item At Path : %@",path);
        }
    }
}

@end

#endif
