//
//  DetailViewController.h
//  PhotoTrip
//
//  Created by Vineet Tiwari on 2015-06-07.
//  Copyright (c) 2015 vinny.co. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (nonatomic) UIImage *image;

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

@end