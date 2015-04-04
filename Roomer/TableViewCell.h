//
//  TableViewCell.h
//  Roomer
//
//  Created by Jeremy Ellison on 4/3/15.
//  Copyright (c) 2015 Roomer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property(strong, nonatomic) IBOutlet UILabel *RoomNumberLabel;
@property(strong, nonatomic) IBOutlet UILabel *DescriptionLabel;
@property(strong, nonatomic) IBOutlet UILabel *AvailabilityLabel;

@end
