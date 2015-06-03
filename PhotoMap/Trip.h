//
//  Trip.h
//  PhotoTrip
//
//  Created by Vineet Tiwari on 2015-06-02.
//  Copyright (c) 2015 vinny.co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Trip : NSManagedObject

@property (nonatomic) NSDate *date;
@property (nonatomic, retain) NSString * name;

//@property (nonatomic, readonly) NSString *sectionName;

@end
