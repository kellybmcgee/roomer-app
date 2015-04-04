//
//  RoomerManager.m
//  Roomer
//
//  Created by Kelly McGee on 4/4/15.
//  Copyright (c) 2015 Roomer. All rights reserved.
//

#import "RoomerManager.h"
#import "RoomBuilder.h"
#import "RoomerCommunicator.h"

@implementation RoomerManager
- (void)fetchRoomsAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    [self.communicator searchRoomsAtCoordinate:coordinate];
}

#pragma mark - RoomerCommunicatorDelegate

- (void)receivedRoomsJSON:(NSData *)objectNotation
{
    NSError *error = nil;
    NSArray *rooms = [RoomBuilder roomsFromJSON:objectNotation error:&error];
    
    if (error != nil) {
        [self.delegate fetchingRoomsFailedWithError:error];
        
    } else {
        [self.delegate didReceiveRooms:rooms];
    }
}

- (void)fetchingRoomsFailedWithError:(NSError *)error
{
    [self.delegate fetchingRoomsFailedWithError:error];
}
@end
