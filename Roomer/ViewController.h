//
//  ViewController.h
//  Roomer
//
//  Created by Jeremy Ellison on 4/3/15.
//  Copyright (c) 2015 Roomer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreLocationController.h"

@interface ViewController : UIViewController <CoreLocationControllerDelegate>

@property (nonatomic, retain) CoreLocationController *locationController;

@end

