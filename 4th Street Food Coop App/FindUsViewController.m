//
//  FindUsViewController.m
//  4th Street Food Coop App
//
//  Created by Boris Kachscovsky on 4/22/13.
//  Copyright (c) 2013 nyu.edu. All rights reserved.
//

#import "FindUsViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface FindUsViewController ()

@end

@implementation FindUsViewController{
    GMSMapView *mapView_;
}


- (void)loadView {
    
    // Alert Setup
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Need Directions?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    // Alert Details
    UITextView *text = [[UITextView alloc] initWithFrame:CGRectMake(15, 35, 250, 10)];
    text.backgroundColor = [UIColor clearColor];
    text.textColor = [UIColor whiteColor];
    text.editable = NO;
    text.font = [UIFont systemFontOfSize:15];
    text.text = @"Directions";
    [alert addSubview:text];
    [alert show];
    
    
    // Creates the initial destination
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude: 40.726614
                                                            longitude:-73.990815
                                                                 zoom:16];
    
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;
    
    // Creates the marker
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(40.726614, -73.990815);
    GMSMarker *marker = [GMSMarker markerWithPosition:position];
    marker.icon = [UIImage imageNamed:@"carrotCross.png"];
    marker.title = @"4th Street Food Coop";
    marker.snippet = @"58 E 4th St, New York, NY";

    
    marker.map = mapView_;
    

    mapView_.settings.myLocationButton = YES;
    mapView_.settings.compassButton = YES;

}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    // Link to native maps application
    if(buttonIndex == 1){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://maps.apple.com/?daddr=58+East+4th+Street,New+York+NY+10003"]];
    }
}




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
