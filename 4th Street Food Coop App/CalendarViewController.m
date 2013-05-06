//
//  CalendarViewController.m
//  4th Street Food Coop App
//
//  Created by Boris Kachscovsky on 4/25/13.
//  Copyright (c) 2013 nyu.edu. All rights reserved.
//

#import "CalendarViewController.h"
#import "Kal/Kal.h"
#import "DataSource.h"
#import "DetailViewController.h"

@interface CalendarViewController ()

@end

@implementation CalendarViewController

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
    
    // Initialize the Data source for the Calendar View
    id<KalDataSource> source = [[DataSource alloc] init];

    // Create and display the Calendar as a child view controller
    KalViewController *calendar = [[KalViewController alloc] init];
    [self.view addSubview:calendar.view];
    [self addChildViewController:calendar];
    calendar.DataSource = source;
    
    calendar.title = @"Delivery Calendar";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
