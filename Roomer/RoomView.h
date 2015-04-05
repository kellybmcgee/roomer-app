//
//  RoomView.h
//  Roomer
//
//  Created by Jeremy Ellison on 4/4/15.
//  Copyright (c) 2015 Roomer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoomView : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *roomNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionsLabel;
@property (strong, nonatomic) IBOutlet UIImage *availabilityLabel;
@property (strong, nonatomic) IBOutlet UIImageView *roomImage;

@property (strong, nonatomic) NSArray *detailModel;

@end
