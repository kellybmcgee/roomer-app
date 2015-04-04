//
//  RoomBuilder.h
//  Roomer
//
//  Created by Kelly McGee on 4/4/15.
//  Copyright (c) 2015 Roomer. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface RoomBuilder : NSObject
+ (NSArray *)roomsFromJSON:(NSData *)objectNotation error:(NSError **)error;
@end
