//
//  MapViewController.m
//  PhotoTrip
//
//  Created by Vineet Tiwari on 2015-06-03.
//  Copyright (c) 2015 vinny.co. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic) UIImagePickerController *imagePicker;

- (IBAction)cameraButtonPressed:(id)sender;

@end

@implementation MapViewController

#pragma mark - View controller life cycle -

- (void)viewDidLoad {
  [super viewDidLoad];

  [self setupImagePicker];
}

#pragma mark - UIImagePickerDelegate -

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
  UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
  [self showImageAsAPin:chosenImage];
  [self dismissViewControllerAnimated:YES completion:nil];
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

}

@end