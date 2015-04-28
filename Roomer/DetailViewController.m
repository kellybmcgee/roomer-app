//
//  DetailViewController.m
//  Roomer
//
//  Created by Jeremy Ellison on 4/24/15.
//  Copyright (c) 2015 Roomer. All rights reserved.
//

#import "DetailViewController.h"
@implementation DetailViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    _RoomNumberLabel.text = [@"Room " stringByAppendingString:_DetailModual[0]];
    _DescriptionLabel.text = _DetailModual[1];
    _AvailabilityLabel.text = _DetailModual[2];
    _LengthOfAvailableLabel.text = _DetailModual[3];
    _CapacityLabel.text = _DetailModual[4];
    _DistanceLabel.text = [_DetailModual[5] stringByAppendingString:@" away"];
    self.navigationItem.title = _DetailModual[0];
    NSArray *roomImages = @[@"DefaultRoom.jpg", @"1-273.jpg", @"1-277.jpg",@"1-371.jpg",@"1-375.jpg",@"1-379.jpg",@"2-103.jpg",@"4-144.jpg",@"4-146.jpg",@"4-251.jpg",@"4-253.jpg",@"5-231.jpg",@"5-232.jpg",@"5-234.jpg",@"8-205.jpg",@"13-1143.jpg",@"13-5101.jpg",@"26-210.jpg",@"26-302.jpg",@"34-304.jpg",@"35-310.jpg",@"36-112.jpg",@"36-153.jpg",@"36-372.jpg",@"38-166.jpg",@"56-162.jpg",@"56-167.jpg",@"56-169.jpg",@"56-180.jpg",@"56-191.jpg",@"66-148.jpg",@"66-154.jpg",@"E51-061.jpg",@"E51-063.jpg",@"E51-385.jpg",@"E51-390.jpg",@"E51-393.jpg",@"1-115.jpg",@"1-132.jpg",@"1-134.jpg",@"1-135.jpg",@"1-136.jpg",@"1-150.jpg",@"1-190.jpg",@"1-242.jpg",@"1-246.jpg",@"1-390.jpg",@"2-105.jpg",@"2-131.jpg",@"2-132.jpg",@"2-135.jpg",@"2-136.jpg",@"2-139.jpg",@"2-142.jpg",@"-143.jpg",@"2-146.jpg",@"2-147.jpg",@"2-151.jpg",@"2-190.jpg",@"3-133.jpg",@"3-270.jpg",@"3-333.jpg",@"3-370.jpg",@"3-442.jpg",@"4-145.jpg",@"4-148.jpg",@"4-149.jpg",@"4-152.jpg",@"4-153.jpg",@"4-156.jpg",@"4-159.jpg",@"4-160.jpg",@"4-163.jpg",@"4-231.jpg",@"4-237.jpg",@"4-249.jpg",@"4-257.jpg",@"4-261.jpg",@"4-265.jpg",@"4-270.jpg",@"4-364.jpg",@"4-370.jpg",@"5-134.jpg",@"5-216.jpg",@"5-217.jpg",@"5-233.jpg",@"6-120.jpg",@"8-119.jpg",@"9-354.jpg",@"10-250.jpg",@"13-3101.jpg",@"13-4101.jpg",@"14-0637.jpg",@"14E-310.jpg",@"14N-112.jpg",@"14N-325.jpg",@"16-160.jpg",@"24-112.jpg",@"24-115.jpg",@"24-121.jpg",@"24-307.jpg",@"26-100.jpg",@"26-142.jpg",@"26-152.jpg",@"26-168.jpg",@"26-204.jpg",@"26-310.jpg",@"26-314.jpg",@"26-322.jpg",@"26-328.jpg",@"32-082.jpg",@"32-123.jpg"];
    if([roomImages containsObject:[_DetailModual[0] stringByAppendingString:@".jpg"]]){
        int *picIndex = [roomImages indexOfObject:[_DetailModual[0] stringByAppendingString:@".jpg"]];
        _roomPicture.image = [UIImage imageNamed:[roomImages objectAtIndex:picIndex]];
    }
    else {
        _roomPicture.image = [UIImage imageNamed:[roomImages objectAtIndex:0]];
    }
    //int *picIndex = [roomImages indexOfObject:[_DetailModual[0] stringByAppendingString:@".jpg"]];
    //_roomPicture.image = [UIImage imageNamed:[roomImages objectAtIndex:picIndex]];
    //_roomPicture.image = [UIImage imageNamed:[roomImages objectAtIndex:0]];
    //int *picIndex = [roomImages indexOfObject:[_DetailModual[0] stringByAppendingString:@".jpg"]];
    //_roomPicture.image = [UIImage imageNamed:[roomImages objectAtIndex:picIndex]];
    //_roomPicture.image = [UIImage imageNamed:[roomImages objectAtIndex:0]];
    _clock.image = [UIImage imageNamed:@"clock1.png"];
    _pin.image = [UIImage imageNamed:@"pin2.png"];
    _dude.image = [UIImage imageNamed:@"capacity.png"];
    _star.image = [UIImage imageNamed:@"star.png"];
    _moreChecks.image = [UIImage imageNamed:@"circleCheck 2.png"];
    
}
@end
