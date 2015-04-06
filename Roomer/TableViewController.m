//
//  TableViewController.m
//  Roomer
//
//  Created by Jeremy Ellison on 4/3/15.
//  Copyright (c) 2015 Roomer. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"
#import "RoomObject.h"

@import CoreLocation;

@interface TableViewController ()
    

@end

@interface NSURLRequest (DummyInterface)
+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString*)host;
+ (void)setAllowsAnyHTTPSCertificate:(BOOL)allow forHost:(NSString*)host;
@end

@implementation TableViewController
CLLocation *userLocation;

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler{
    if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]){
        //if([challenge.protectionSpace.host isEqualToString:@"mit.edu"]){
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        completionHandler(NSURLSessionAuthChallengeUseCredential,credential);
        //}
    }
}

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    userLocation = manager.location;
    NSLog(@"%@", userLocation);
    [self.myLocMan stopUpdatingLocation];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myLocMan = [[CLLocationManager alloc] init];
    
    [self.myLocMan setDelegate:self];
    [self.myLocMan requestWhenInUseAuthorization];
    [self.myLocMan requestAlwaysAuthorization];
    [self.myLocMan startUpdatingLocation];
    
    // Create Authorization Token!
    
    //Create Session Configuration
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //Configure Session Authentication [HEADERS]
    [sessionConfiguration setHTTPAdditionalHeaders:@{ @"Authorization" : @"Bearer eyJhbGciOiJSUzI1NiJ9.eyJleHAiOjE0MjgzNTE0MDgsImF1ZCI6WyJkNWVlODk5MC0xY2EwLTQ1OGMtYmQ2ZS04Mzg0ZDEzNzI4YTkiXSwiaXNzIjoiaHR0cHM6XC9cL29pZGMubWl0LmVkdVwvIiwianRpIjoiNjc0MWI1ZjUtY2UxOC00MDk5LTgxYTAtOGFmN2RlYjkxMGEzIiwiaWF0IjoxNDI4MzQ3ODA4fQ.ltqaZXixHwa25u-o2AaR1eijHP6xy8Pototjgj5eUDvi1axm18CNqTtWWMJn4XoCHA1NC-XGytJmhCNbqJGmdIfmGhlz1z9_HVjPQPdQvdHPvzYu4ytyke3itMR2LWCBO5YfrifE4SqTlpchsKCR3VpXciChUDjmALCxz5G95R_GGa5kgG_aSEbE4c3nlT5abxo9ln0CXAWRH5Pl90SvNaeBfxxtir4vRMEIJF4d33xkpncI2Na6cHNS5CGQ1dri-H56NVjc7zGVovLtNzQsq1TVWR-fTJ9RWQgdM81Sz2arBZTrq__0DIWY5CGtKeFnQGC5290oTwS1WeHak-VOGw" }];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:Nil];
    [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:@"https://mit-oauth-flow.cloudhub.io/"];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:@"https://mit-oauth-flow.cloudhub.io/classrooms"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //NSLog(@"%@", dataTask);
        //Start JSON Parsing
        NSMutableDictionary *roomDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        NSLog(@"%@", roomDictionary);
        NSMutableArray *allRooms = [[NSMutableArray alloc] init];
        for (NSMutableDictionary *room in roomDictionary[@"data"]){
            RoomObject *currentRoom = [[RoomObject alloc] init];
            [currentRoom roomFromDictionary:room];
            [allRooms addObject:currentRoom];
        }
        /*NSArray *sortedArray = [allRooms sortedArrayUsingComparator:^NSComparisonResult(RoomObject *r1, RoomObject *r2){
            
            NSNumber *r1Distance = [NSNumber numberWithDouble:[r1.location distanceFromLocation:userLocation]];
            NSNumber *r2Distance = [NSNumber numberWithDouble:[r2.location distanceFromLocation:userLocation]];
            
            return [r1Distance compare:r2Distance];
            
        }];*/
        
        NSMutableArray *roomNumbers = [[NSMutableArray alloc] init];
        NSMutableArray *descriptions = [[NSMutableArray alloc] init];
        //NSMutableArray *availabilities = [[NSMutableArray alloc] init];
        //NSMutableArray *availabilityDurations = [[NSMutableArray alloc] init];
        
        for (RoomObject *room in allRooms)
        {
            [roomNumbers addObject:room.roomNumber];
            [descriptions addObject:room.roomDescription];
            //[availabilities addObject:room.availability];
            //[availabilityDurations addObject:room.availabilityDuration];
        }
        
        self.RoomNumber = roomNumbers;
        self.Description = descriptions;
        //self.Availability = availabilities;
        //self.LengthOfAvailable = availabilityDurations;

        
        // 6
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [self.tableView reloadData];
        });
    }];
    [dataTask resume];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    
    
    
}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _RoomNumber.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"TableViewCell";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    NSInteger row = [indexPath row];
    
    cell.RoomNumberLabel.text = _RoomNumber[row];
    cell.DescriptionLabel.text = _Description[row];
    cell.AvailabilityLabel.text = _Availability[row];
    cell.LengthOfAvailableLabel.text = _LengthOfAvailable[row];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
