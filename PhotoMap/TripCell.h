//
//  TripCell.h
//  PhotoTrip
//
//  Created by Vineet Tiwari on 2015-06-08.
//  Copyright (c) 2015 vinny.co. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TripCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *tripName;
@property (weak, nonatomic) IBOutlet UILabel *tripDate;
@property (nonatomic) UILabel *crossLabel;

@end
