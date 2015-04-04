//
//  RoomerCommunicator.h
//  Roomer
//
//  Created by Kelly McGee on 4/4/15.
//  Copyright (c) 2015 Roomer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol RoomerCommunicationDelegate;

@interface RoomerCommunicator : NSObject

@property (weak, nonatomic) id<RoomerCommunicationDelegate> delegate;

- (void)searchRoomsAtCoordinate:(CLLocationCoordinate2D)coordinate;

@end
