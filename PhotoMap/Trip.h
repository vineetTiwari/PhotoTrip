//
//  Trip.h
//  PhotoTrip
//
//  Created by Vineet Tiwari on 2015-06-03.
//  Copyright (c) 2015 vinny.co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject;

@interface Trip : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *pinRelation;
@end

@interface Trip (CoreDataGeneratedAccessors)

- (void)addPinRelationObject:(NSManagedObject *)value;
- (void)removePinRelationObject:(NSManagedObject *)value;
- (void)addPinRelation:(NSSet *)values;
- (void)removePinRelation:(NSSet *)values;

@end
