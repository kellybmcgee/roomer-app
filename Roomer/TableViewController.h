//
//  TableViewController.h
//  Roomer
//
//  Created by Jeremy Ellison on 4/3/15.
//  Copyright (c) 2015 Roomer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface TableViewController : UITableViewController<CLLocationManagerDelegate>

@property (nonatomic, strong) NSArray *RoomNumber;
@property (nonatomic, strong) NSArray *Description;
@property (nonatomic, strong) NSArray *Availability;
@property (nonatomic, strong) NSArray *LengthOfAvailable;

@property (strong, nonatomic) CLLocationManager *myLocMan;

@end
