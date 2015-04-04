//
//  RoomerCommunicator.m
//  Roomer
//
//  Created by Kelly McGee on 4/4/15.
//  Copyright (c) 2015 Roomer. All rights reserved.
//

#import "RoomerCommunicator.h"
#import <CoreLocation/CoreLocation.h>

@import CoreLocation;
@implementation RoomerCommunicator

- (void)searchRoomsAtCoordinate:(CLLocationCoordinate2D)coordinate {
    
    //Create Session Configuration
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //Configure Session Authentication [HEADERS]
    [sessionConfiguration setHTTPAdditionalHeaders:@{ @"Authorization" : @"Bearer eyJhbGciOiJSUzI1NiJ9.eyJhdWQiOlsiMjY2ZWJjYzgtYjBhMS00ZjgwLWFiMzktODUwNjE5OTBmZjk0Il0sImlzcyI6Imh0dHBzOlwvXC9vaWRjLm1pdC5lZHVcLyIsImp0aSI6ImVkNTUwYjg1LTViNzYtNDExMy1hYzIxLTVhZjAxODBlNzhjYyIsImlhdCI6MTQyODEyMDI0NH0.YQFjJI0L_hkDAyOAfYME-fbCypHmSaKLAq6B0AL0GT5C9uCUZMAAHbps7gn3H12pEE0-0Me57Abl2xIYJOKnnD26SeA1hOKx2VXeoAb6UcrrFlB8akacFOOiQ38m-7aZ6TGyy5gRMe8cyqE82DNk7_c4WiItpq26xI8MchSgkY6e1cCUSpCqFYMn4BTVqbX8vsKWzt9COK6kBGrUQt-hF9CpLoS6HL3v3c6PFNKVYltT67ylN7SRIloFiv5KBdDgnHKUehWkgHCXVUcVO3TaBsnIxPiFBXcrzb4cQkxCt8HcXHwgv_025fzaB7Nrf_70FwY8PVDBn21ioPw4p5bFjw" }];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:@"http://mocksvc.mulesoft.com/mocks/d421fa0f-073f-4c2e-b3bf-b15e4fd62ec3/classrooms/3-333"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"%@", json);
    }];
    
    [dataTask resume];
}
@end

