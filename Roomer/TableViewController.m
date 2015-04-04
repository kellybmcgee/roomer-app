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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    _RoomNumber = @[@"1-123",@"1-124", @"3-345", @"2-323", @"20-234", @"30-123"];
    _Description = @[@"20 seats, Blackboard", @"50 seats, Projector", @"20 seats, Blackboard, Projector", @"20 seats, Blackboard", @"50 seats, Projector", @"20 seats, Blackboard, Projector"];
    _Availability = @[@"Open", @"Closed", @"Open", @"Open", @"Closed", @"Open"];
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
