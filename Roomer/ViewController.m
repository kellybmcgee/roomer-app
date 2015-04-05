//
//  ViewController.m
//  Roomer
//
//  Created by Jeremy Ellison on 4/3/15.
//  Copyright (c) 2015 Roomer. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "CoreLocationController.h"

@interface ViewController ()
{
    
}
@end

@implementation ViewController {
    NSString *latitude;
    NSString *longitude;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

    self.locationController = [[CoreLocationController alloc] init];
    self.locationController.delegate = self;
    [self.locationController.locationManager startUpdatingLocation];
}

- (void)update:(CLLocation *)location {
     NSLog(@"got it");
    //latitude = [NSString stringWithFormat:@"Latitude: %f", [location coordinate].latitude];
    latitude= [NSString stringWithFormat:@"Latitude: %f", [location coordinate].latitude];
    longitude = [NSString stringWithFormat:@"Longitude: %f", [location coordinate].longitude];
}

- (void)locationError:(NSError *)error {
    NSLog(@"Error");

    latitude= [error description];
    longitude = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
