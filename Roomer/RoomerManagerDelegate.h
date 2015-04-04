//
//  RoomerManagerDelegate.h
//  Roomer
//
//  Created by Kelly McGee on 4/4/15.
//  Copyright (c) 2015 Roomer. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RoomerManagerDelegate
- (void)didReceiveRooms:(NSArray *)rooms;
- (void)fetchingRoomsFailedWithError:(NSError *)error;
@end
