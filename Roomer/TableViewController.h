//
//  TableViewController.h
//  Roomer
//
//  Created by Jeremy Ellison on 4/3/15.
//  Copyright (c) 2015 Roomer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "AccessToken.h"

@interface TableViewController : UITableViewController<CLLocationManagerDelegate, NSURLSessionDataDelegate>

@property (nonatomic, strong) NSArray *RoomNumber;
@property (nonatomic, strong) NSArray *Description;
@property (nonatomic, strong) NSArray *Availability;
@property (nonatomic, strong) NSArray *LengthOfAvailable;
@property (nonatomic, strong) NSArray *capacities;
@property (nonatomic, strong) NSArray *distances;
@property (nonatomic, strong) NSArray *images;

@property (strong, nonatomic) CLLocationManager *myLocMan;




- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler;

@end