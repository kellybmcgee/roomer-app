//
//  RoomBuilder.m
//  Roomer
//
//  Created by Kelly McGee on 4/4/15.
//  Copyright (c) 2015 Roomer. All rights reserved.
//

#import "RoomBuilder.h"
#import "Rooms.h"

@implementation RoomBuilder
+ (NSArray *)roomsFromJSON:(NSData *)objectNotation error:(NSError **)error
{
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:objectNotation options:0 error:&localError];
    
    if (localError != nil) {
        *error = localError;
        return nil;
    }
    
    NSMutableArray *rooms = [[NSMutableArray alloc] init];
    
    NSArray *results = [parsedObject valueForKey:@"results"];
    NSLog(@"Count %lu", (unsigned long)results.count);
    
    for (NSDictionary *roomDic in results) {
        Rooms *room = [[Rooms alloc] init];
        
        for (NSString *key in roomDic) {
            if ([room respondsToSelector:NSSelectorFromString(key)]) {
                [room setValue:[roomDic valueForKey:key] forKey:key];
            }
        }
        
        [rooms addObject:room];
    }
    
    return rooms;
}

@end

