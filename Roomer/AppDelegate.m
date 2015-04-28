//
//  AppDelegate.m
//  Roomer
//
//  Created by Jeremy Ellison on 4/3/15.
//  Copyright (c) 2015 Roomer. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor darkGrayColor];
    pageControl.backgroundColor = [[UIColor alloc]initWithRed:(10.0f) green:(0.0f) blue:(0.0f) alpha:(0.005)];
    [Parse setApplicationId:@"Rd3XtHnP60rHXe9D9saIL3fPK7vZ9iTskpeAIBiK"
                  clientKey:@"2TAzmZMaOHkJClvrBpZ6QMeOQgZLtiSAGdHrCqyk"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    NSDictionary *dimensions = @{
                                 // What type of news is this?
                                 @"category": @"politics",
                                 // Is it a weekday or the weekend?
                                 @"dayType": @"weekday",
                                 };
    // Send the dimensions to Parse along with the 'read' event
    
    [PFAnalytics trackEvent:@"read" dimensions:dimensions];
    return YES;
}
- (NSDictionary *)parseQueryString:(NSString *)query {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:6];
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    
    for (NSString *pair in pairs) {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
        NSString *key = [[elements objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *val = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [dict setObject:val forKey:key];
    }
    return dict;
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    // handler code here
    NSLog(@"%@",url);
    /*NSLog(@"query string: %@", [url query]);
     NSLog(@"host: %@", [url host]);
     NSLog(@"url path: %@", [url path]);
     NSDictionary *dict = [self parseQueryString:[url query]];
     NSLog(@"query dict: %@", dict);*/
    NSString *code = [url query];
    //NSString *newURL = [@"https://anypoint.mulesoft.com/apiplatform/mit-5/authentication/oauth2.html?" stringByAppendingString:code];
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:newURL]];
    NSString *clientID =@"client_id=73713554-005d-4152-a0a2-16e1db93f034&";
    NSString *clientSecret = @"client_secret=ANmGBpXtUoqYQtd6BQOWX25SktCWW7FuMGv8gOyw2FEn1zOA7VgHkBynWg1CZB97eOO8QI9yiH97fLnGBBXEu0A&";
    NSString *grantType = @"grant_type=authorization_code&";
    NSString *redirect = [@"&redirect_uri=roomer://" stringByAppendingString:[url host]];
    NSString *post = [NSString stringWithFormat:[clientID stringByAppendingString:[clientSecret stringByAppendingString:[grantType stringByAppendingString:[code stringByAppendingString:redirect]]]]];
    NSLog(@"%@", post);
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"https://oidc.mit.edu/token"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    NSLog(@"%@", request);
    NSURLResponse *requestResponse;
    NSData *requestHandler = [NSURLConnection sendSynchronousRequest:request returningResponse:&requestResponse error:nil];
    
    NSString *requestReply = [[NSString alloc] initWithBytes:[requestHandler bytes] length:[requestHandler length] encoding:NSASCIIStringEncoding];
    /*NSError *jsonError;
     NSData *objectData = [@"{\"2\":\"3\"}" dataUsingEncoding:NSUTF8StringEncoding];
     tokenDict = [NSJSONSerialization JSONObjectWithData:objectData
     options:NSJSONReadingMutableContainers
     error:&jsonError];*/
    NSError *error;
    NSData *data = [requestReply dataUsingEncoding:NSUTF8StringEncoding];
    tokenDict = [NSJSONSerialization JSONObjectWithData:data
                                                options:kNilOptions
                                                  error:&error];
    //NSLog(@"requestReply: %@", requestReply);
    
    //TableViewController *tvc= [TableViewController alloc];
    //tvc.token.accessToken = requestReply;
    
    return YES;
    
}
extern NSMutableDictionary *tokenDict;

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
