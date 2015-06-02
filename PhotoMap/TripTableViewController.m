//
//  ViewController.m
//  PhotoMap
//
//  Created by Vineet Tiwari on 2015-06-02.
//  Copyright (c) 2015 vinny.co. All rights reserved.
//

#import "TripTableViewController.h"
#import "NewTripViewController.h"
#import "CoreDataStack.h"
#import "Trip.h"

@interface TripTableViewController ()

@property (nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation TripTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  [self.fetchedResultsController performFetch:nil];
}

#pragma mark - TableViewControllerDataSource -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

  id<NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController  sections][section];

  return [sectionInfo numberOfObjects];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

  Trip *trip = [self.fetchedResultsController objectAtIndexPath:indexPath];

  cell.textLabel.text = trip.name;

  NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
  [dateFormat setDateFormat:@"MMMM dd, YYYY"];
  
  cell.detailTextLabel.text = [dateFormat stringFromDate:trip.date]; ;

  return cell;

}

#pragma mark - Segue - 

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

  if ([segue.identifier isEqualToString:@"presentModally"]) {

    NewTripViewController *newTripTableViewController = [[NewTripViewController alloc] init];
    newTripTableViewController = (NewTripViewController *)segue.destinationViewController;

  }
}

#pragma mark - Fetching The Data -

- (NSFetchRequest *)tripListfetchRequest {


  NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Trip"];

  fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES]];

  return fetchRequest;
}

- (NSFetchedResultsController *)fetchedResultsController {

  if (_fetchedResultsController != nil) {

    return _fetchedResultsController;
  }

  CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
  NSFetchRequest *fetchRequest = [self tripListfetchRequest];
  _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:coreDataStack.managedObjectContext sectionNameKeyPath:nil cacheName:nil];

  return _fetchedResultsController;
}

@end
































