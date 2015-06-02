//
//  NewTripViewController.m
//  PhotoTrip
//
//  Created by Vineet Tiwari on 2015-06-02.
//  Copyright (c) 2015 vinny.co. All rights reserved.
//

#import "NewTripViewController.h"
#import "CoreDataStack.h"
#import "Trip.h"

@interface NewTripViewController ()

@property (weak, nonatomic) IBOutlet UITextField *tripNameTextField;

@end

@implementation NewTripViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) insertTrip {

  CoreDataStack *coreDataStack = [CoreDataStack defaultStack];

  Trip *trip = [NSEntityDescription insertNewObjectForEntityForName:@"Trip" inManagedObjectContext:coreDataStack.managedObjectContext];

  trip.name = self.tripNameTextField.text;

  trip.date  = [[NSDate alloc] init];
  NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
  [dateFormat setDateFormat:@"MMMM dd, YYYY"];
  [coreDataStack saveContext];

}

- (IBAction)startTripButtonPressed:(UIButton *)sender {

  [self insertTrip];
  
  [self dismissViewControllerAnimated:YES completion:nil];
  
}

@end




























