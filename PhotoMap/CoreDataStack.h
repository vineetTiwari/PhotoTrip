//
//  CoreDataStack.h
//  PhotoMap
//
//  Created by Vineet Tiwari on 2015-06-02.
//  Copyright (c) 2015 vinny.co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataStack : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (instancetype)defaultStack;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;



@end
