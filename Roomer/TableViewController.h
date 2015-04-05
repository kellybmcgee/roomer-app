//
//  TableViewController.h
//  Roomer
//
//  Created by Jeremy Ellison on 4/3/15.
//  Copyright (c) 2015 Roomer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UITableViewController

@property (nonatomic, strong) NSArray *roomNumber;
@property (nonatomic, strong) NSArray *descriptions;
@property (nonatomic, strong) NSArray *availability;

@end
