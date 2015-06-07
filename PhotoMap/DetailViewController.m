//
//  DetailViewController.m
//  PhotoTrip
//
//  Created by Vineet Tiwari on 2015-06-07.
//  Copyright (c) 2015 vinny.co. All rights reserved.
//

#import "DetailViewController.h"
#import "Pin.h"

@implementation DetailViewController

- (void)viewDidLoad {
  [super viewDidLoad];

//  Pin *pin = [[Pin alloc] init];

  self.photoImageView.image = self.image;
}



@end
