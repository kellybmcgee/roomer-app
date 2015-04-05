//
//  TableViewCell.h
//  Roomer
//
//  Created by Jeremy Ellison on 4/3/15.
//  Copyright (c) 2015 Roomer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property(strong, nonatomic) IBOutlet UILabel *roomNumberLabel;
@property(strong, nonatomic) IBOutlet UILabel *descriptionsLabel;
@property(strong, nonatomic) IBOutlet UILabel *availabilityLabel;

@end
