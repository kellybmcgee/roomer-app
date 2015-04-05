//
//  TableViewController.m
//  Roomer
//
//  Created by Jeremy Ellison on 4/3/15.
//  Copyright (c) 2015 Roomer. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Create Authorization Token!
    
    //Create Session Configuration
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //Configure Session Authentication [HEADERS]
    [sessionConfiguration setHTTPAdditionalHeaders:@{ @"Authorization" : @"Bearer eyJhbGciOiJSUzI1NiJ9.eyJhdWQiOlsiMjY2ZWJjYzgtYjBhMS00ZjgwLWFiMzktODUwNjE5OTBmZjk0Il0sImlzcyI6Imh0dHBzOlwvXC9vaWRjLm1pdC5lZHVcLyIsImp0aSI6ImVkNTUwYjg1LTViNzYtNDExMy1hYzIxLTVhZjAxODBlNzhjYyIsImlhdCI6MTQyODEyMDI0NH0.YQFjJI0L_hkDAyOAfYME-fbCypHmSaKLAq6B0AL0GT5C9uCUZMAAHbps7gn3H12pEE0-0Me57Abl2xIYJOKnnD26SeA1hOKx2VXeoAb6UcrrFlB8akacFOOiQ38m-7aZ6TGyy5gRMe8cyqE82DNk7_c4WiItpq26xI8MchSgkY6e1cCUSpCqFYMn4BTVqbX8vsKWzt9COK6kBGrUQt-hF9CpLoS6HL3v3c6PFNKVYltT67ylN7SRIloFiv5KBdDgnHKUehWkgHCXVUcVO3TaBsnIxPiFBXcrzb4cQkxCt8HcXHwgv_025fzaB7Nrf_70FwY8PVDBn21ioPw4p5bFjw" }];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:@"http://mocksvc.mulesoft.com/mocks/d421fa0f-073f-4c2e-b3bf-b15e4fd62ec3/classrooms/"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //Start JSON Parsing
        NSMutableArray *roomNumber = [[NSMutableArray alloc] init];
        NSMutableArray *roomDescription = [[NSMutableArray alloc] init];
        NSMutableArray *roomStatus = [[NSMutableArray alloc] init];
        NSMutableArray *availabilityDuration = [[NSMutableArray alloc] init];

        NSMutableDictionary *roomDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        NSLog(@"%@", roomDictionary);
        NSArray *apiroomdata = roomDictionary[@"data"];
        for ( NSDictionary *attributes in apiroomdata )
        {
            [roomNumber addObject:attributes[@"room"]];
            NSArray *features = attributes[@"features"];
            for ( NSDictionary *featureName in features)
            {
                [roomDescription addObject:featureName[@"name"]];
            }
            NSArray *availabilities = attributes[@"availabilities"];
            for ( NSDictionary *availabilityStatus in availabilities)
            {
                if(availabilityStatus[@"available"]) {
                    [roomStatus addObject: @"Open"];
                    NSString *endDateAndTime = availabilityStatus[@"end"];
                    NSCharacterSet *doNotWantT = [NSCharacterSet characterSetWithCharactersInString:@"T"];
                    NSString *noT = [[endDateAndTime componentsSeparatedByCharactersInSet: doNotWantT] componentsJoinedByString: @" "];
                    NSCharacterSet *doNotWantZ = [NSCharacterSet characterSetWithCharactersInString:@"Z"];
                    NSString *noTorZ = [[noT componentsSeparatedByCharactersInSet: doNotWantZ] componentsJoinedByString: @""];
                    noTorZ = [noTorZ stringByAppendingString:@".000"];
                    
                    NSString *endTime = [endDateAndTime componentsSeparatedByString:@"T"][1];
                    NSString *hours =[endTime componentsSeparatedByString:@":"][0];
                    NSString *minutes =[endTime componentsSeparatedByString:@":"][1];
                    int number = [hours intValue];
                    if (number >=4){
                        number = number - 4;
                    }
                    else{
                        number = number + 21;
                    }
                    NSString *amPm;
                    if(number <12){
                        amPm = @" am";
                    }
                    else {
                        number = number - 12;
                        amPm = @" pm";
                    }
                    hours = [NSString stringWithFormat:@"%d",number];
                    NSString *finalTime = [[[[@"Until " stringByAppendingString:hours] stringByAppendingString:@":"] stringByAppendingString:minutes] stringByAppendingString:amPm];
                    [availabilityDuration addObject: finalTime];
                }
                else {
                    [roomStatus addObject: @"Closed"];
                }
            }
            
        }
        self.RoomNumber = roomNumber;
        self.Description = roomDescription;
        self.Availability = roomStatus;
        self.LengthOfAvailable = availabilityDuration;
        
        // 6
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [self.tableView reloadData];
        });
    }];
    [dataTask resume];
    
  /*
    for ( NSDictionary *attributes in roominfo )
    {
        NSLog(@"Available?: %@", attributes[@"room"]);
    }
   */
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    _LengthOfAvailable = @[@"until 7pm", @"until 5pm", @"until 6pm", @"until 7pm", @"until 5pm", @"until 6pm"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
