//
//  CoreLocationController.h
//  Roomer
//
//  Created by Jeremy Ellison on 4/5/15.
//  Copyright (c) 2015 Roomer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreLocation/CoreLocation.h"

@protocol CoreLocationControllerDelegate
@required
- (void)update:(CLLocation *)location;
- (void)locationError:(NSError *)error;
@end

@interface CoreLocationController : NSObject <CLLocationManagerDelegate>

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) id delegate;

@end
