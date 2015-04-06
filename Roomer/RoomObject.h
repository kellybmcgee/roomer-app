//
//  RoomObject.h
//  Roomer
//
//  Created by Jeremy Ellison on 4/5/15.
//  Copyright (c) 2015 Roomer. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;

@interface RoomObject : NSObject

@property (strong, nonatomic) NSString *roomNumber;
@property (strong, nonatomic) NSString *roomDescription;
@property (strong, nonatomic) NSString *availability;
@property (strong, nonatomic) NSString *availabilityDuration;
@property (strong, nonatomic) NSString *capacity;
@property (strong, nonatomic) CLLocation *location;

- (void) roomFromDictionary:(NSDictionary *)roomDict;

@end
