//
//  Pin.m
//  PhotoTrip
//
//  Created by Vineet Tiwari on 2015-06-04.
//  Copyright (c) 2015 vinny.co. All rights reserved.
//

#import "Pin.h"
#import "Trip.h"


@implementation Pin

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)aCoordinate andTitle:(NSString *)title andImage:(UIImage*) image
{
  self = [super init];
  if (self) {
    self.coordinate = aCoordinate;
    self.title = title;
    self.image = image;
  }
  return self;
}

@end
