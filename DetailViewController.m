//
//  DetailViewController.m
//  4th Street Food Coop App
//
//  Created by Boris Kachscovsky on 5/3/13.
//  Copyright (c) 2013 nyu.edu. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController (){
    NSString *path;
    NSMutableArray *contentArray;
    NSArray *currentProduct;
}

@end

@implementation DetailViewController

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
    //Loading the data from our property list
    path = [[NSBundle mainBundle] pathForResource:@"products" ofType:@"plist"];
    contentArray = [NSArray arrayWithContentsOfFile:path];
    currentProduct = [contentArray objectAtIndex:_index];
    int dayOfMonth = [[currentProduct objectAtIndex:1] intValue];
    
    //Filling the labels and text views with the appropriate data
    _titleText.title = [currentProduct objectAtIndex:0];
    _productDescription.text = [currentProduct objectAtIndex:3];
    _productImage.image = [UIImage imageNamed:[currentProduct objectAtIndex:4]];
    _priceText.text = [currentProduct objectAtIndex:5];
    _originLabel.text = [currentProduct objectAtIndex:6];
    _speciesText.text = [currentProduct objectAtIndex:7];
    
    //Determines whether to display the day of the week or the day of the month
    if(dayOfMonth == 0){
        switch ([[currentProduct objectAtIndex:2] intValue]){
            case 1:
                _productNextDelivery.text = @"Every Sunday";
                break;
            case 2:
                _productNextDelivery.text = @"Every Monday";
                break;
            case 3:
                _productNextDelivery.text = @"Every Tuesday";
                break;
            case 4:
                _productNextDelivery.text = @"Every Wednesday";
                break;
            case 5:
                _productNextDelivery.text = @"Every Thursday";
                break;
            case 6:
                _productNextDelivery.text = @"Every Friday";
                break;
            case 7:
                _productNextDelivery.text = @"Every Saturday";
                break;
        }
    }
    //Handles the case where the item only arrives once a month
    else {
        NSMutableString *deliveryText = [[NSMutableString alloc] init];
        
        [deliveryText appendString: [currentProduct objectAtIndex:1]];
        if(dayOfMonth/10 == 1)
            [deliveryText appendString:@"th of every month"];
        else if(dayOfMonth%10 == 1)
            [deliveryText appendString:@"st of every month"];
        else if(dayOfMonth%10 == 2)
            [deliveryText appendString:@"nd of every month"];
        else if(dayOfMonth%10 == 3)
            [deliveryText appendString:@"rd of every month"];
        else
            [deliveryText appendString:@"th of every month"];
        
        _productNextDelivery.text = deliveryText;
    }
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Back button to return to the product view
- (IBAction)backPressed:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
@end
