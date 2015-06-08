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
#import "TripCell.h"

@interface TripTableViewController ()<NSFetchedResultsControllerDelegate>

@property (nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic) NSMutableArray *trips;

@end

@implementation TripTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.tableView.delegate = self;

  self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  self.tableView.backgroundColor = [UIColor colorWithRed:78.0/225.0 green:81.0/225.0 blue:69.0/225.0 alpha:1.0];

  [self.fetchedResultsController performFetch:nil];

  [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTable) userInfo:nil repeats:YES];

}

#pragma mark - UITableViewDataDelegate protocol methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 50.0f;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(TripCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

  cell.backgroundColor = [self colorForIndex:indexPath.row];
}



- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {

  TripCell *cell = [[TripCell alloc] init];

  return cell.crossLabel.text;
}


#pragma mark - TableViewControllerDataSource -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

  id<NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController  sections][section];

//  self.trips = [[sectionInfo objects]mutableCopy];

//  return self.trips.count;

  return [sectionInfo numberOfObjects];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {


  TripCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

  Trip *trip = [self.fetchedResultsController objectAtIndexPath:indexPath];

  cell.tripName.text = trip.name;

  cell.tripName.backgroundColor = [UIColor clearColor];

  NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
  [dateFormat setDateFormat:@"MMMM dd, YYYY"];

  cell.tripDate.text = [dateFormat stringFromDate:trip.date]; ;

  return cell;

}

- (UIColor*)colorForIndex:(NSInteger) index {

  NSUInteger itemCount = self.tableView.indexPathsForVisibleRows.count - 0.6;
  float val = ((float)index / (float)itemCount) * 0.6;
  return [UIColor colorWithRed: 1.0 green:val blue: 0.0 alpha:1.0];
}


#pragma mark - Segue - 

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

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

  fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO]];

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
  [self.tableView reloadData];
}

#pragma mark - Deleting Animation Logic -

//Methods to get an animation when the cell object is deleted :

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {

  [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {

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

- (void)updateTable {

  [self.tableView reloadData];
}

@end