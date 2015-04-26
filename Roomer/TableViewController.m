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
#import "DetailViewController.h"


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
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        completionHandler(NSURLSessionAuthChallengeUseCredential,credential);
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
    [sessionConfiguration setHTTPAdditionalHeaders:@{ @"Authorization" : @"Bearer eyJhbGciOiJSUzI1NiJ9.eyJleHAiOjE0Mjg0NDc2NDYsImF1ZCI6WyIzNjAxOTk4OS1iOTZkLTQzM2MtODdkNi1kYTUwZGYzNGY4ZDAiXSwiaXNzIjoiaHR0cHM6XC9cL29pZGMubWl0LmVkdVwvIiwianRpIjoiMjcyY2JiYjAtMmMwNC00ODc2LWEyMjItNDhhMWZjNjEzNzkyIiwiaWF0IjoxNDI4NDQ0MDQ2fQ.VG0d29lg8_w0jIcnFuNK6VBX2Ey-_wzFoF_o-IN8gxeVw2sTNoZasUKIa5SX-fNaWoQ8JHMV5IDyUPv03g5wmo6WEDipSQJCYSuFO_J4vRCIGud9Q5nHU9Wp4dyl_GIaweNshP6ZT9RnrcWd9aWsyYEmR2RD57Fv4GH54whX-Zgd7PkSbc5qb02BkHAr3EPJ2TfDK88KIFTz7iRCDdB6OHWePLsoNN9bHNXq3Cq8jf68bMPGea0ga_dm0eb6wv_KgPd4JGcs_AwoUZia286OihssdTDzz4HDpnIe3E9T-cKzdXxRYmQ85lXKt-MRKWDdsf2l5Ygw01kJ3nShnkcqiw" }];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:Nil];
    [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:@"https://mit-oauth-flow.cloudhub.io/"];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:@"https://mit-oauth-flow.cloudhub.io/classrooms"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //NSLog(@"%@", dataTask);
        //Start JSON Parsing
        NSMutableDictionary *roomDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        //NSLog(@"%@", roomDictionary);
        NSMutableArray *allRooms = [[NSMutableArray alloc] init];
        for (NSMutableDictionary *room in roomDictionary[@"data"]){
            RoomObject *currentRoom = [[RoomObject alloc] init];
            [currentRoom roomFromDictionary:room];
            if([currentRoom.roomNumber isEqual:@"35-308"]) {
                if([[room objectForKey:@"latitude" ] isEqual:@"<null>"] && [[room   objectForKey:@"longitude" ] isEqual:@"<null>"]) {
                continue;
            }
        }
            [allRooms addObject:currentRoom];
        }
        NSArray *sortedArray = [allRooms sortedArrayUsingComparator:^NSComparisonResult(RoomObject *r1, RoomObject *r2){
            
            NSNumber *r1Distance = [NSNumber numberWithDouble:[r1.location distanceFromLocation:userLocation]];
            NSNumber *r2Distance = [NSNumber numberWithDouble:[r2.location distanceFromLocation:userLocation]];
            
            return [r1Distance compare:r2Distance];
            
        }];
        /*NSString *latitude = @"42.3598";
        NSString *longitude = @"-71.0921";
        CLLocation *hardCodedLocation = [[CLLocation alloc] initWithLatitude:[latitude doubleValue] longitude:[longitude doubleValue]];*/
        
        
        NSMutableArray *roomNumbers = [[NSMutableArray alloc] init];
        NSMutableArray *descriptions = [[NSMutableArray alloc] init];
        NSMutableArray *availabilities = [[NSMutableArray alloc] init];
        NSMutableArray *availabilityDurations = [[NSMutableArray alloc] init];
        NSMutableArray *capacity = [[NSMutableArray alloc] init];
        NSMutableArray *distance = [[NSMutableArray alloc] init];
        
        for (RoomObject *room in sortedArray)
        {
            [roomNumbers addObject:[@"Room " stringByAppendingString:room.roomNumber]];
            [descriptions addObject:room.roomDescription];
            [availabilities addObject:room.availability];
            [availabilityDurations addObject:room.availabilityDuration];
            [capacity addObject:room.capacity];
            NSNumber *metersDistance =[NSNumber numberWithDouble:[room.location distanceFromLocation:userLocation]];
            if([metersDistance compare:@(150)] > 0){
                NSNumber *milesDistance = @([metersDistance floatValue]* 0.000621371);
                NSString *distanceString = [milesDistance stringValue];
                distanceString = [distanceString substringToIndex:(3)];
                [distance addObject:[distanceString stringByAppendingString:@" mi"]];
            }
            else {
                NSNumber *feetDistance = @([metersDistance floatValue]* 3.2808);
                NSInteger *feetTruncated = [feetDistance integerValue];
                int feetIntTruncated = (int) feetTruncated;
                feetIntTruncated = (feetIntTruncated / 10) * 10;
                feetDistance = [NSNumber numberWithInt:feetIntTruncated];
                NSString *distanceString = [feetDistance stringValue];
                [distance addObject:[distanceString stringByAppendingString:@" feet"]];
            }
        }
        
        [roomNumbers addObject:@"Room 1-111"];
        [descriptions addObject:@"Chalkboard"];
        [availabilities addObject:@"OPEN"];
        [availabilityDurations addObject: @"Until 9pm"];
        [capacity addObject:@"Capacity: 20 people"];
        [distance addObject:@"200 Feet"];
        /*NSLog(@"%@", userLocation);
        NSNumber *metersDistance =[NSNumber numberWithDouble:[hardCodedLocation distanceFromLocation:userLocation]];
        if([metersDistance compare:@(150)] > 0){
            NSNumber *milesDistance = @([metersDistance floatValue]* 0.000621371);
            NSString *distanceString = [milesDistance stringValue];
            distanceString = [distanceString substringToIndex:(3)];
            [distance addObject:[distanceString stringByAppendingString:@" mi"]];
        }
        else {
            NSNumber *feetDistance = @([metersDistance floatValue]* 3.2808);
            NSInteger *feetTruncated = [feetDistance integerValue];
            int feetIntTruncated = (int) feetTruncated;
            feetIntTruncated = (feetIntTruncated / 10) * 10;
            feetDistance = [NSNumber numberWithInt:feetIntTruncated];
            NSString *distanceString = [feetDistance stringValue];
            [distance addObject:[distanceString stringByAppendingString:@" feet"]];
        }*/
        self.RoomNumber = roomNumbers;
        self.Description = descriptions;
        self.Availability = availabilities;
        self.LengthOfAvailable = availabilityDurations;
        self.capacities = capacity;
        self.distances = distance;
        
        // 6
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [self.tableView reloadData];
        });
    }];
    [dataTask resume];
    

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"ShowDetails"]) {
        DetailViewController *detailViewController = [segue destinationViewController];
        NSIndexPath *myIndexPath = [self.tableView indexPathForSelectedRow];
        int row = [myIndexPath row];
        detailViewController.DetailModual = @[_RoomNumber[row], _Description[row], _Availability[row], _LengthOfAvailable[row], _capacities[row], _distances[row] ];
        
    }
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
    /*if([cell.AvailabilityLabel.text isEqual: @"OPEN"]){
        cell.AvailabilityLabel.textColor = [UIColor greenColor];
    }
    else {
        cell.AvailabilityLabel.textColor = [UIColor redColor];
    }*/
    cell.LengthOfAvailableLabel.text = _LengthOfAvailable[row];
    cell.CapacityLabel.text = _capacities[row];
    cell.DistanceLabel.text = _distances[row];
    
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
