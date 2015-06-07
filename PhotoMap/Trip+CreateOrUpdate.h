//
//  Trip+CreateOrUpdate.h
//  PhotoTrip
//
//  Created by Vineet Tiwari on 2015-06-04.
//  Copyright (c) 2015 vinny.co. All rights reserved.
//

#import "Trip.h"

@interface Trip (CreateOrUpdate)

+ (Trip *)tripWithName:(NSString *)name date:(NSDate *)date;

+ (NSString *)entityName;

@end
