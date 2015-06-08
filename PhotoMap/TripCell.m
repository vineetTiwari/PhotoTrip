//
//  TripCell.m
//  PhotoTrip
//
//  Created by Vineet Tiwari on 2015-06-08.
//  Copyright (c) 2015 vinny.co. All rights reserved.
//

#import "TripCell.h"
#import <QuartzCore/QuartzCore.h>

@interface TripCell()

@end

@implementation TripCell {

  CAGradientLayer* _gradientLayer;
  CGPoint _originalCenter;
  BOOL _deleteOnDragRelease;
}

const float UI_CUES_MARGIN = 10.0f;
const float UI_CUES_WIDTH = 50.0f;

- (instancetype)init
{
  self = [super init];
  if (self) {

    _gradientLayer = [CAGradientLayer layer];
    _gradientLayer.frame = self.bounds;
    _gradientLayer.colors = @[(id)[[UIColor colorWithWhite:1.0f alpha:0.2f] CGColor],
                              (id)[[UIColor colorWithWhite:1.0f alpha:0.1f] CGColor],
                              (id)[[UIColor clearColor] CGColor],
                              (id)[[UIColor colorWithWhite:0.0f alpha:0.1f] CGColor]];
    _gradientLayer.locations = @[@0.00f,
                                 @0.01f,
                                 @0.95f,
                                 @1.00f];
    [self.layer insertSublayer:_gradientLayer atIndex:0];

    UIGestureRecognizer* recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    recognizer.delegate = self;
    [self addGestureRecognizer:recognizer];

    _crossLabel = [self createCueLabel];
    _crossLabel.text = @"\u2717";
    _crossLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_crossLabel];
  }

  return self;
}

- (void) layoutSubviews {
  [super layoutSubviews];

  // ensure the gradient layers occupies the full bounds
  _gradientLayer.frame = self.bounds;
}


#pragma mark - horizontal pan gesture methods -

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {

  CGPoint translation = [gestureRecognizer translationInView:[self superview]];
  
  // Check for horizontal gesture
  if (fabs(translation.x) > fabs(translation.y)) {

    return YES;
  }

  return NO;
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {

  // 1
  if (recognizer.state == UIGestureRecognizerStateBegan) {

    // if the gesture has just started, record the current centre location
    _originalCenter = self.center;
  }

  // 2
  if (recognizer.state == UIGestureRecognizerStateChanged) {

    // translate the center
    CGPoint translation = [recognizer translationInView:self];

    self.center = CGPointMake(_originalCenter.x + translation.x, _originalCenter.y);
    // determine whether the item has been dragged far enough to initiate a delete / complete
    _deleteOnDragRelease = self.frame.origin.x < -self.frame.size.width / 2;

  }

  // 3
  if (recognizer.state == UIGestureRecognizerStateEnded) {

    // the frame this cell would have had before being dragged
    CGRect originalFrame = CGRectMake(0, self.frame.origin.y,
                                      self.bounds.size.width, self.bounds.size.height);
    if (!_deleteOnDragRelease) {
      // if the item is not being deleted, snap back to the original location
      [UIView animateWithDuration:0.2
                       animations:^{
                         self.frame = originalFrame;
                       }
       ];
    }
  }
}

- (UILabel*) createCueLabel {
  
  UILabel* label = [[UILabel alloc] initWithFrame:CGRectNull];
  label.textColor = [UIColor whiteColor];
  label.font = [UIFont boldSystemFontOfSize:32.0];
  label.backgroundColor = [UIColor clearColor];
  return label;
}

@end













