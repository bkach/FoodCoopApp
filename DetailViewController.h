//
//  DetailViewController.h
//  4th Street Food Coop App
//
//  Created by Boris Kachscovsky on 5/3/13.
//  Copyright (c) 2013 nyu.edu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property int index;
@property (weak, nonatomic) IBOutlet UILabel *originLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceText;
@property (weak, nonatomic) IBOutlet UINavigationItem *titleText;
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *productNextDelivery;
@property (weak, nonatomic) IBOutlet UITextView *productDescription;
@property (weak, nonatomic) IBOutlet UILabel *speciesText;

-(IBAction)backPressed:(id)sender;

@end
