//
//  DetailViewController.m
//  Roomer
//
//  Created by Jeremy Ellison on 4/24/15.
//  Copyright (c) 2015 Roomer. All rights reserved.
//

#import "DetailViewController.h"
@implementation DetailViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    _RoomNumberLabel.text = _DetailModual[0];
    _DescriptionLabel.text = _DetailModual[1];
    _AvailabilityLabel.text = _DetailModual[2];
    _LengthOfAvailableLabel.text = _DetailModual[3];
    _CapacityLabel.text = _DetailModual[4];
    _DistanceLabel.text = [_DetailModual[5] stringByAppendingString:@" Away"];
    self.navigationItem.title = _DetailModual[0];
}
@end
