//
//  Pin.h
//  PhotoTrip
//
//  Created by Vineet Tiwari on 2015-06-04.
//  Copyright (c) 2015 vinny.co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <MapKit/MapKit.h>
@class Trip;

@interface Pin : NSObject <MKAnnotation>

@property (nonatomic) NSDate *createdAt;
@property (nonatomic) UIImage *image;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic, retain) Trip *tripRelation;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)aCoordinate andTitle:(NSString *)title andImage:(UIImage*) image;
@end
