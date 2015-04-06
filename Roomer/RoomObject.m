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
    
    //NSDictionary *availabilityDict = [[roomDict objectForKey:@"availablilites"] objectAtIndex:0];
        
    /*NSArray *availabilities = roomDict[@"availabilities"];
    for ( NSDictionary *availabilityStatus in availabilities)
    {
        if(availabilityStatus[@"available"]) {
            //[roomStatus addObject: @"Open"];
            self.availability = @"Open";
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
            //[availabilityDuration addObject: finalTime];
            self.availabilityDuration = finalTime;
        }
        else {
            //[roomStatus addObject: @"Closed"];
            self.availability = @"Closed";
            self.availabilityDuration = @"";
        }
    }*/

    
    /*if([availabilityDict objectForKey:@"available"]) self.availability = @"open"; else self.availability = @"closed";
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    NSDate *end = [df dateFromString:[availabilityDict objectForKey:@"end"]];
    end = [end dateByAddingTimeInterval:(-60.0*60.0*4.0)];
    NSString *dataString = [NSDateFormatter localizedStringFromDate:end dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
    NSLog(dataString);
    
    self.availabilityDuration = [@"Until " stringByAppendingString:@""];*/
    NSString *latitude = @"0";
    if([roomDict objectForKey:@"latitude"] != nil){
        latitude = ((NSString *)[roomDict objectForKey:@"latitude"]);
    }
    NSString *longitude  = @"0";;
    if([roomDict objectForKey:@"longitude"] != nil){
        longitude= ((NSString *)[roomDict objectForKey:@"longitude"]);
    }
    //self.location = [[CLLocation alloc] initWithLatitude:[latitude doubleValue] longitude:[longitude doubleValue]];
}

@end
