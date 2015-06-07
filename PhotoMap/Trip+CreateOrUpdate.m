//
//  Trip+CreateOrUpdate.m
//  PhotoTrip
//
//  Created by Vineet Tiwari on 2015-06-04.
//  Copyright (c) 2015 vinny.co. All rights reserved.
//

#import "Trip+CreateOrUpdate.h"
#import "CoreDataStack.h"

@implementation Trip (CreateOrUpdate)


+ (Trip *)tripWithName:(NSString *)name date:(NSDate *)date {


  NSEntityDescription *entityDescription = [NSEntityDescription entityForName:[self entityName] inManagedObjectContext:[CoreDataStack defaultStack].managedObjectContext];

  Trip *newTrip = [[Trip alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:[CoreDataStack defaultStack].managedObjectContext];

  return newTrip;
}

+ (NSString *)entityName {

  return @"Trip";
}

@end
