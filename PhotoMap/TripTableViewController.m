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
#import "MapViewController.h"

@interface TripTableViewController ()<NSFetchedResultsControllerDelegate>

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
  [dateFormat setDateFormat:@"MMMM dd, YYYY - hh:mma"];

  cell.detailTextLabel.text = [dateFormat stringFromDate:trip.date]; ;

  return cell;

}

#pragma mark - Segue - 

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

  if ([segue.identifier isEqualToString:@"presentModally"]) {

    NewTripViewController *newTripTableViewController = [[NewTripViewController alloc] init];
    newTripTableViewController = (NewTripViewController *)segue.destinationViewController;

  }

  if ([segue.identifier isEqualToString:@"show"]) {

    MapViewController *mapViewController = [[MapViewController alloc] init];
    mapViewController = (MapViewController *)segue.destinationViewController;
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

  _fetchedResultsController.delegate = self;

  return _fetchedResultsController;
}

#pragma mark - Deleting/Editing the cell -

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {

  return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

  Trip *trip = [self.fetchedResultsController objectAtIndexPath:indexPath];
  CoreDataStack *coreDataStack = [CoreDataStack defaultStack];

  [[coreDataStack managedObjectContext] deleteObject:trip];
  [coreDataStack saveContext];
}

#pragma mark - Deleting Animation Logic -

//Methods to get an animation when the cell object is deleted :

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {

  [self.tableView beginUpdates];
}

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {

  switch (type) {
    case NSFetchedResultsChangeInsert:
      [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
      break;
    case NSFetchedResultsChangeDelete:
      [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
      break;

    case NSFetchedResultsChangeUpdate:
      [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
      break;

    default:
      break;
  }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {

  [self.tableView endUpdates];
}





@end
































