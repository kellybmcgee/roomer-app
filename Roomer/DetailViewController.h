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
@property (strong, nonatomic) IBOutlet UIImageView *roomPicture;

@property(strong, nonatomic) NSArray *DetailModual;
@property (weak, nonatomic) IBOutlet UIImageView *clock;
@property (weak, nonatomic) IBOutlet UIImageView *pin;

@property (weak, nonatomic) IBOutlet UIImageView *dude;
@property (weak, nonatomic) IBOutlet UIImageView *star;
@property (weak, nonatomic) IBOutlet UIImageView *moreChecks;

@end
