//
//  RoomObject.m
//  Roomer
//
//  Created by Jeremy Ellison on 4/5/15.
//  Copyright (c) 2015 Roomer. All rights reserved.
//

#import "RoomObject.h"

@implementation RoomObject

- (void) roomFromDictionary:(NSDictionary *)roomDict
{
    self.roomNumber = [roomDict objectForKey:@"room"];
    if ([[roomDict objectForKey:@"features"] count] > 0){
        self.roomDescription = [[[roomDict objectForKey:@"features"] objectAtIndex:0] objectForKey:@"name"];
    }
    else {
        self.roomDescription = @"";
    }
    NSString *capacity = [NSString stringWithFormat:@"%@",[roomDict objectForKey:@"capacity"]];
    NSString *fullCapacity = [capacity stringByAppendingString:@" capacity"];
    self.capacity = fullCapacity;
    
    NSArray *availabilities = roomDict[@"availabilities"];
    for ( NSDictionary *availabilityStatus in availabilities)
    {
        if(availabilityStatus[@"available"]) {
            //[roomStatus addObject: @"OPEN"];
            self.availability = @"OPEN";
            NSString *endDateAndTime = availabilityStatus[@"end"];
            NSCharacterSet *doNotWantT = [NSCharacterSet characterSetWithCharactersInString:@"T"];
            NSString *noT = [[endDateAndTime componentsSeparatedByCharactersInSet: doNotWantT] componentsJoinedByString: @" "];
            NSCharacterSet *doNotWantZ = [NSCharacterSet characterSetWithCharactersInString:@"Z"];
            NSString *noTorZ = [[noT componentsSeparatedByCharactersInSet: doNotWantZ] componentsJoinedByString: @""];
            noTorZ = [noTorZ stringByAppendingString:@".000"];
            
            NSString *endTime = [endDateAndTime componentsSeparatedByString:@"T"][1];
            NSString *hours =[endTime componentsSeparatedByString:@":"][0];
            NSString *minutes =[endTime componentsSeparatedByString:@":"][1];
            int number = [hours intValue];
            if (number >=4){
                number = number - 4;
            }
            else{
                number = number + 21;
            }
            NSString *amPm;
            if(number <12){
                amPm = @" am";
            }
            else {
                number = number - 12;
                amPm = @" pm";
            }
            hours = [NSString stringWithFormat:@"%d",number];
            NSString *finalTime = [[[[@"Until " stringByAppendingString:hours] stringByAppendingString:@":"] stringByAppendingString:minutes] stringByAppendingString:amPm];
            self.availabilityDuration = finalTime;
        }
        else {
            self.availability = @"CLOSED";
            self.availabilityDuration = @"";
        }
    }
    NSString *latitude;
    NSString *longitude;
   
    if([[roomDict objectForKey:@"room"]isEqualToString:@"35-308"]) {
        latitude = @"42.361128";
        longitude = @"-71.09192899999999";
    }
    else {
        latitude = ((NSString *)[roomDict objectForKey:@"latitude"]);
        longitude = ((NSString *)[roomDict objectForKey:@"longitude"]);
    }
    self.location = [[CLLocation alloc] initWithLatitude:[latitude doubleValue] longitude:[longitude doubleValue]];
    
}

@end

