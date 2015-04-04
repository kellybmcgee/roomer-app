//
//  RoomerCommunicationDelegate.h
//  Roomer
//
//  Created by Kelly McGee on 4/4/15.
//  Copyright (c) 2015 Roomer. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RoomerCommunicationDelegate <NSObject>
- (void)receivedRoomsJSON:(NSData *)objectNotation;
- (void)fetchingRoomsFailedWithError:(NSError *)error;
@end
