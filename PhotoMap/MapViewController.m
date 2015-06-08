//
//  MapViewController.m
//  PhotoTrip
//
//  Created by Vineet Tiwari on 2015-06-03.
//  Copyright (c) 2015 vinny.co. All rights reserved.
//

#import "MapViewController.h"
#import "CoreDataStack.h"
#import "Pin.h"
#import "DetailViewController.h"
#import <Photos/Photos.h>

@interface MapViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, MKMapViewDelegate, CLLocationManagerDelegate, NSFetchedResultsControllerDelegate>{

  CLLocationManager *_locationManager;
  bool initialLocationSet;

}

@property (nonatomic) UIImagePickerController *imagePicker;
@property (nonatomic) CLLocation *currentLocation;
@property (nonatomic) NSFetchedResultsController *fetchedResultsController;

- (IBAction)cameraButtonPressed:(id)sender;

@end

@implementation MapViewController

#pragma mark - View controller life cycle -

- (void)viewDidLoad {
  [super viewDidLoad];

  self.tripMapView.showsUserLocation = true;
  self.tripMapView.delegate = self;

  initialLocationSet = false;
  _locationManager = [[CLLocationManager alloc] init];
  [_locationManager requestWhenInUseAuthorization];
  [_locationManager startUpdatingLocation];
  _locationManager.delegate = self;

  MKPointAnnotation *pin = [[MKPointAnnotation alloc] init];
  CLLocationCoordinate2D startPoint;
  startPoint.latitude = 49.268950;
  startPoint.longitude = -123.153739;
  pin.coordinate = startPoint;
  pin.title = @"start point";

  [self.tripMapView addAnnotation:pin];

  [self setupImagePicker];

}

#pragma mark - UIImagePickerDelegate -

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

  UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
  [self dismissViewControllerAnimated:YES completion:^{

    [self showImageAsAPin:chosenImage];

  }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
  [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Actions -

- (IBAction)cameraButtonPressed:(id)sender {
  [self showPickerAlert];
}

#pragma mark - General methods -

- (void)setupImagePicker {
  self.imagePicker = [[UIImagePickerController alloc] init];
  self.imagePicker.delegate = self;
}

- (void)showPickerAlert {
  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];

  UIAlertAction *takePhoto = [UIAlertAction actionWithTitle:@"Take photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    [self presentImagePickerCamera:YES];
  }];
  [alertController addAction:takePhoto];

  UIAlertAction *library = [UIAlertAction actionWithTitle:@"Choose from library" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    [self presentImagePickerCamera:NO];
  }];
  [alertController addAction:library];

  [self presentViewController:alertController animated:YES completion:nil];
}

- (void)presentImagePickerCamera:(BOOL)camera {
  self.imagePicker.sourceType = camera ?
  UIImagePickerControllerSourceTypeCamera:
  UIImagePickerControllerSourceTypePhotoLibrary;

  [self presentViewController:self.imagePicker animated:YES completion:nil];
}

- (void)showImageAsAPin:(UIImage *)image {

 CLLocationCoordinate2D currentPoint;
  currentPoint.latitude = self.currentLocation.coordinate.latitude;
  currentPoint.longitude = self.currentLocation.coordinate.longitude;

  Pin *photoPin = [[Pin alloc] initWithCoordinate:currentPoint andTitle:@"Tap Me" andImage:image];

  [self.tripMapView addAnnotation:photoPin];
}

#pragma mark - CLLocationManagerDelegate -


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
  NSLog(@"Got error %@", [error localizedDescription]);
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
  self.currentLocation = [locations firstObject];

  if (!initialLocationSet){

    MKCoordinateRegion startingRegion;
    CLLocationCoordinate2D loc = self.currentLocation.coordinate;
    startingRegion.center = loc;
    startingRegion.span.latitudeDelta = 0.02;
    startingRegion.span.longitudeDelta = 0.02;
    [self.tripMapView setRegion:startingRegion];

    initialLocationSet = true;
  }

}

#pragma mark - MKMapViewDelegate -

- (void)locationManager:(CLLocationManager *)manager
didChangeAuthorizationStatus:(CLAuthorizationStatus)status{

}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {

  if (annotation == self.tripMapView.userLocation){
    return nil;
  }

  Pin *pin = (Pin*) annotation;

    static NSString* annotationIdentifier = @"startpoint";

    MKPinAnnotationView* pinView = [[MKPinAnnotationView alloc]
                                    initWithAnnotation:pin reuseIdentifier:annotationIdentifier];

    pinView.canShowCallout = YES;
//    pinView.pinColor = MKPinAnnotationColorGreen;
    pinView.annotation = annotation;
    pinView.calloutOffset = CGPointMake(-15, 0);

    pinView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];

  return pinView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {


  Pin *pin = (Pin*)view.annotation;

    DetailViewController *detailViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"DetailViewController"];

    detailViewController.image = pin.image;

    [self.navigationController pushViewController:detailViewController animated:YES];


}

#pragma mark - Fetching The Data -

- (NSFetchRequest *)pinFetchRequest {


  NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Pin"];

  fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"createdAt" ascending:NO]];

  return fetchRequest;
}

- (NSFetchedResultsController *)fetchedResultsController {

  if (_fetchedResultsController != nil) {

    return _fetchedResultsController;
  }

  CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
  NSFetchRequest *fetchRequest = [self pinFetchRequest];
  _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:coreDataStack.managedObjectContext sectionNameKeyPath:nil cacheName:nil];

  _fetchedResultsController.delegate = self;

  return _fetchedResultsController;
}


@end








