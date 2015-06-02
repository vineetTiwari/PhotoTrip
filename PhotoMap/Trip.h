//
//  Trip.h
//  
//
//  Created by Vineet Tiwari on 2015-06-02.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Trip : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * name;

@end
