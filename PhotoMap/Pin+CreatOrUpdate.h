//
//  Pin+CreatOrUpdate.h
//  PhotoTrip
//
//  Created by Vineet Tiwari on 2015-06-04.
//  Copyright (c) 2015 vinny.co. All rights reserved.
//

#import "Pin.h"
#import "Trip.h"
#import <UIKit/UIKit.h>

@interface Pin (CreatOrUpdate)

+ (Pin *) pinWithLatitude:(double)latitude longitude:(double)longitude image:(UIImage *)image title:(NSString *)title trip:(Trip *)trip;

+ (NSString *)entityName;

@end
