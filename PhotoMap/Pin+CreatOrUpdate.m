//
//  Pin+CreatOrUpdate.m
//  PhotoTrip
//
//  Created by Vineet Tiwari on 2015-06-04.
//  Copyright (c) 2015 vinny.co. All rights reserved.
//

#import "Pin+CreatOrUpdate.h"
#import "CoreDataStack.h"

@implementation Pin (CreatOrUpdate)

+ (Pin *)pinWithLatitude:(double)latitude longitude:(double)longitude image:(UIImage *)image title:(NSString *)title trip:(Trip *)trip {

  NSEntityDescription *entityDescription = [NSEntityDescription entityForName:[self entityName] inManagedObjectContext:[CoreDataStack defaultStack].managedObjectContext];

  /*Pin *newPin = [[Pin alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:[CoreDataStack defaultStack].managedObjectContext];

  newPin.latitude = latitude;
  newPin.longitude = longitude;

  newPin.coordinate = CLLocationCoordinate2DMake(latitude, longitude);

  //newPin.image = image;
  newPin.createdAt = [NSDate date];

  if (trip) {
    newPin.tripRelation = trip;
  }*/

  return [Pin new];
}

+ (NSString *)entityName {

  return @"Pin";

}

@end
