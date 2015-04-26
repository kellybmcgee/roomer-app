//
//  LoginViewController.m
//  Roomer
//
//  Created by Jeremy Ellison on 4/25/15.
//  Copyright (c) 2015 Roomer. All rights reserved.
//

#import "LoginViewController.h"

@implementation LoginViewController

- (IBAction)LoginButton:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://oidc.mit.edu/authorize?response_type=code&scope=openid%20profile&redirect_uri=roomer://authentication&client_id=73713554-005d-4152-a0a2-16e1db93f034"]];
    //NSString *newURL = [@"https://anypoint.mulesoft.com/apiplatform/mit-5/authentication/oauth2.html?" stringByAppendingString:code];
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:newURL]];
    
}

-(void)viewDidLoad {
    [super viewDidLoad];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
