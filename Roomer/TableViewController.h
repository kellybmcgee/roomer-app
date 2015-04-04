//
//  TableViewController.h
//  Roomer
//
//  Created by Jeremy Ellison on 4/3/15.
//  Copyright (c) 2015 Roomer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UITableViewController

@property (nonatomic, strong) NSArray *RoomNumber;
@property (nonatomic, strong) NSArray *Description;
@property (nonatomic, strong) NSArray *Availability;
@property (nonatomic, strong) NSArray *LengthOfAvailable;

@end
