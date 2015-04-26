//
//  DetailViewController.h
//  Roomer
//
//  Created by Jeremy Ellison on 4/24/15.
//  Copyright (c) 2015 Roomer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property(strong, nonatomic) IBOutlet UILabel *RoomNumberLabel;
@property(strong, nonatomic) IBOutlet UILabel *DescriptionLabel;
@property(strong, nonatomic) IBOutlet UILabel *AvailabilityLabel;
@property(strong, nonatomic) IBOutlet UILabel *LengthOfAvailableLabel;
@property(strong, nonatomic) IBOutlet UILabel *CapacityLabel;
@property(strong, nonatomic) IBOutlet UILabel *DistanceLabel;

@property(strong, nonatomic) NSArray *DetailModual;


@end
