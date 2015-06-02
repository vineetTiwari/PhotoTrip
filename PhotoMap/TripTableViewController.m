//
//  ViewController.m
//  PhotoMap
//
//  Created by Vineet Tiwari on 2015-06-02.
//  Copyright (c) 2015 vinny.co. All rights reserved.
//

#import "TripTableViewController.h"
#import "NewTripViewController.h"

@interface TripTableViewController ()

@end

@implementation TripTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - TableViewControllerDataSource -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

  return 1;

}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

  return cell;

}

#pragma mark - Segue - 

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

  if ([segue.identifier isEqualToString:@"presentModally"]) {

    NewTripViewController *newTripTableViewController = [[NewTripViewController alloc] init];
    newTripTableViewController = (NewTripViewController *)segue.destinationViewController;

  }
}

@end
































