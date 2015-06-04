//
//  Pin.h
//  PhotoTrip
//
//  Created by Vineet Tiwari on 2015-06-03.
//  Copyright (c) 2015 vinny.co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Trip;

@interface Pin : NSManagedObject

@property (nonatomic, retain) NSString * imagePath;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) Trip *tripRelation;

@end
