//
//  RoomerManager.h
//  Roomer
//
//  Created by Kelly McGee on 4/4/15.
//  Copyright (c) 2015 Roomer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import "RoomerManagerDelegate.h"
#import "RoomerCommunicationDelegate.h"

@class RoomerCommunicator;

@interface RoomerManager : NSObject<RoomerCommunicationDelegate>
@property (strong, nonatomic) RoomerCommunicator *communicator;
@property (weak, nonatomic) id<RoomerManagerDelegate> delegate;

- (void)fetchRoomsAtCoordinate:(CLLocationCoordinate2D)coordinate;
@end